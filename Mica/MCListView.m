//
//  MCListView.m
//  Mica
//
//  Created by hiseh yin on 14/12/3.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCListView.h"
#import "SVPullToRefresh.h"

@implementation MCListView
@synthesize delegate;
@synthesize mulitpleChoice = __canMulitpleSelect;

#pragma mark - public method
- (instancetype)initWithFrame:(CGRect)frame pullActionType:(MCListViewPullActionType)pullActionType dataSource:(NSArray *)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        __dataSource = [NSMutableArray arrayWithArray:dataSource];
        __editing = NO;
        __canMulitpleSelect = NO;
        __pullActionType = pullActionType;
        
        [self initTableView:frame];
    }
    return self;
}

- (void)stopPullAction {
    switch (__pullActionType) {
        case MCListViewPullActionLoadMore:
        {
            [__tableView.infiniteScrollingView stopAnimating];
            break;
        }
        case MCListViewPullActionRefresh:
        {
            [__tableView.pullToRefreshView stopAnimating];
            break;
        }
        case MCListViewPullActionRefreshAndLoadMore:
        {
            [__tableView.pullToRefreshView stopAnimating];
            [__tableView.infiniteScrollingView stopAnimating];
            break;
        }
        case MCListViewPullActionNone:
        default:
            break;
    }
}

#pragma mark load more & refresh
- (void)appendObjects:(NSArray *)objects {
    if (objects && [objects count] > 0) {
        [__dataSource addObjectsFromArray:objects];
        [__tableView reloadData];
    }
    
}

- (void)refreshWithObjects:(NSArray *)objects {
    if (objects) {
        [__dataSource removeAllObjects];
        [__dataSource addObjectsFromArray:objects];
        [__tableView reloadData];
    }
}

#pragma mark 改变 UI
- (void)resizeWithFrame:(CGRect)frame {
    self.frame = frame;
    __tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)scrollToIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:__dataSource.count - 1 inSection:0];
    
    if (__dataSource.count > 0) {
        [__tableView scrollToRowAtIndexPath:indexPath
                           atScrollPosition:UITableViewScrollPositionMiddle
                                   animated:YES];
    }
}

- (void)scrollToBottom {
    NSInteger index = __dataSource.count - 1;
    [self scrollToIndex:index];
}


- (void)setEditing:(BOOL)editing {
    if ( editing) {
        [__tableView setEditing:YES animated:YES];
        __editing = YES;
    } else {
        [__tableView setEditing:NO animated:YES];
        __editing = NO;
    }
    
    [__tableView reloadData];
}

#pragma mark - 初始化table view
- (void)initTableView:(CGRect)frame {
    __tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                frame.size.width,
                                                                frame.size.height)];
    __tableView.delegate = self;
    __tableView.dataSource = self;
    __tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __tableView.hidden = NO;
    __tableView.scrollEnabled = YES;
    __tableView.bounces = YES;
    __tableView.alwaysBounceHorizontal = NO;
    __tableView.alwaysBounceVertical = YES;
    __tableView.bouncesZoom = NO;
    [self addSubview:__tableView];
    
    if (__pullActionType != MCListViewPullActionNone) {
        __weak MCListView *weakSelf = self;
        switch (__pullActionType) {
            case MCListViewPullActionLoadMore:
            {
                [__tableView addInfiniteScrollingWithActionHandler:^{
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [weakSelf.delegate listViewShouldBeginLoadMore:weakSelf];
                    });
                }];
                break;
            }
            case MCListViewPullActionRefresh:
            {
                [__tableView addPullToRefreshWithActionHandler:^{
                    [weakSelf.delegate listViewShouldBeginRefresh:weakSelf];
                }];
                break;
            }
            case MCListViewPullActionRefreshAndLoadMore:
            {
                [__tableView addInfiniteScrollingWithActionHandler:^{
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [weakSelf.delegate listViewShouldBeginLoadMore:weakSelf];
                    });
                }];
                [__tableView addPullToRefreshWithActionHandler:^{
                    [weakSelf.delegate listViewShouldBeginRefresh:weakSelf];
                }];
                break;
            }
            case MCListViewPullActionNone:
            default:
                break;
        }
        
        [__tableView.infiniteScrollingView setCustomView:[[UIView alloc] initWithLoadMoreIndicator] forState:SVInfiniteScrollingStateTriggered];
        [__tableView.infiniteScrollingView setCustomView:[[UIView alloc] initWithLoadingIndicator] forState:SVInfiniteScrollingStateLoading];
    }
}

#pragma mark - 删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [__dataSource removeObjectAtIndex:[indexPath row]];
    [__tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.delegate listViewDidEndEditing:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return __editing;
}

#pragma mark 移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return __editing;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [__dataSource objectAtIndex:fromRow];
    [__dataSource removeObjectAtIndex:fromRow];
    [__dataSource insertObject:object atIndex:toRow];
    
    [self.delegate listViewDidEndEditing:self];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [__dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
    
    UIView *elementView = [__dataSource objectAtIndex:indexPath.row];
    [cell addSubview:elementView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *elementView = [__dataSource firstObject];
    return elementView.frame.size.height + 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (__canMulitpleSelect) {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    [self.delegate listView:self didSelectRow:indexPath.row];
}

@end

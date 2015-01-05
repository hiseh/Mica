//
//  MCListView.m
//  Mica
//
//  Created by hiseh yin on 14/12/3.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCListView.h"
#import "SVPullToRefresh.h"

NSUInteger const LIST_ELEMENT_TAG = 8000;

@implementation MCListView
@synthesize delegate;
@synthesize mulitpleChoice = canMulitpleSelect__;

#pragma mark - public method
- (instancetype)initWithFrame:(CGRect)frame pullActionType:(MCListViewPullActionType)pullActionType dataSource:(NSArray *)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        dataSource__ = [NSMutableArray arrayWithArray:dataSource];
        editing__ = NO;
        canMulitpleSelect__ = NO;
        pullActionType__ = pullActionType;
        
        [self initTableView:frame];
    }
    return self;
}

- (void)stopPullAction {
    switch (pullActionType__) {
        case MCListViewPullActionLoadMore:
        {
            [tableView__.infiniteScrollingView stopAnimating];
            break;
        }
        case MCListViewPullActionRefresh:
        {
            [tableView__.pullToRefreshView stopAnimating];
            break;
        }
        case MCListViewPullActionRefreshAndLoadMore:
        {
            [tableView__.pullToRefreshView stopAnimating];
            [tableView__.infiniteScrollingView stopAnimating];
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
        [dataSource__ addObjectsFromArray:objects];
        [tableView__ reloadData];
    }
    
}

- (void)refreshWithObjects:(NSArray *)objects {
    if (objects) {
        [dataSource__ removeAllObjects];
        [dataSource__ addObjectsFromArray:objects];
        [tableView__ reloadData];
    }
}

#pragma mark 改变 UI
- (void)resizeWithFrame:(CGRect)frame {
    self.frame = frame;
    tableView__.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)scrollToIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataSource__.count - 1 inSection:0];
    
    if (dataSource__.count > 0) {
        [tableView__ scrollToRowAtIndexPath:indexPath
                           atScrollPosition:UITableViewScrollPositionMiddle
                                   animated:YES];
    }
}

- (void)scrollToBottom {
    NSInteger index = dataSource__.count - 1;
    [self scrollToIndex:index];
}


- (void)setEditing:(BOOL)editing {
    if ( editing) {
        [tableView__ setEditing:YES animated:YES];
        editing__ = YES;
    } else {
        [tableView__ setEditing:NO animated:YES];
        editing__ = NO;
    }
    
    [tableView__ reloadData];
}

#pragma mark - 初始化table view
- (void)initTableView:(CGRect)frame {
    tableView__ = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                frame.size.width,
                                                                frame.size.height)];
    tableView__.delegate = self;
    tableView__.dataSource = self;
    tableView__.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView__.hidden = NO;
    tableView__.scrollEnabled = YES;
    tableView__.bounces = YES;
    tableView__.alwaysBounceHorizontal = NO;
    tableView__.alwaysBounceVertical = YES;
    tableView__.bouncesZoom = NO;
    tableView__.tableFooterView = [[UIView alloc] init];
    [self addSubview:tableView__];
    
    if (pullActionType__ != MCListViewPullActionNone) {
        __weak MCListView *weakSelf = self;
        switch (pullActionType__) {
            case MCListViewPullActionLoadMore:
            {
                [tableView__ addInfiniteScrollingWithActionHandler:^{
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [weakSelf.delegate listViewShouldBeginLoadMore:weakSelf];
                    });
                }];
                break;
            }
            case MCListViewPullActionRefresh:
            {
                [tableView__ addPullToRefreshWithActionHandler:^{
                    [weakSelf.delegate listViewShouldBeginRefresh:weakSelf];
                }];
                break;
            }
            case MCListViewPullActionRefreshAndLoadMore:
            {
                [tableView__ addInfiniteScrollingWithActionHandler:^{
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [weakSelf.delegate listViewShouldBeginLoadMore:weakSelf];
                    });
                }];
                [tableView__ addPullToRefreshWithActionHandler:^{
                    [weakSelf.delegate listViewShouldBeginRefresh:weakSelf];
                }];
                break;
            }
            case MCListViewPullActionNone:
            default:
                break;
        }
        
        [tableView__.infiniteScrollingView setCustomView:[[UIView alloc] initWithLoadMoreIndicator] forState:SVInfiniteScrollingStateTriggered];
        [tableView__.infiniteScrollingView setCustomView:[[UIView alloc] initWithLoadingIndicator] forState:SVInfiniteScrollingStateLoading];
    }
}

#pragma mark - 删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [dataSource__ removeObjectAtIndex:[indexPath row]];
    [tableView__ deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.delegate listViewDidEndEditing:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return editing__;
}

#pragma mark 移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return editing__;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [dataSource__ objectAtIndex:fromRow];
    [dataSource__ removeObjectAtIndex:fromRow];
    [dataSource__ insertObject:object atIndex:toRow];
    
    [self.delegate listViewDidEndEditing:self];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource__ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
    
    UIView *elementView = [dataSource__ objectAtIndex:indexPath.row];
    [cell addSubview:elementView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *elementView = [dataSource__ firstObject];
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
    if (canMulitpleSelect__) {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    [self.delegate listView:self didSelectRow:indexPath.row];
}

@end

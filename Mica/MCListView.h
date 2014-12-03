//
//  MCListView.h
//  Mica
//
//  Created by hiseh yin on 14/12/3.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCView.h"
typedef enum {
    MCListViewPullActionNone,
    MCListViewPullActionRefresh,
    MCListViewPullActionLoadMore,
    MCListViewPullActionRefreshAndLoadMore
} MCListViewPullActionType;

@protocol MCListViewDelegate <NSObject>

@optional
- (void)MCListViewWillLoadMore;
- (void)MCListViewWillRefresh;
- (void)MCListViewDidSelectRow:(NSInteger)row;
- (void)MCListViewDidEdit;

@end

@interface MCListView : MCView <UITableViewDataSource, UITableViewDelegate> {
@private
    NSMutableArray  *__dataSource;
    UITableView     *__tableView;
    BOOL            __isEdit;
    BOOL            __canMulitpleSelect;
    MCListViewPullActionType __pullActionType;
}

@property (nonatomic, weak) id<MCListViewDelegate> delegate;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL canMulitpleSelect;

/**
 Create a base table list view.
 Example usage:
 @code
 [[MCListView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) pullActionType:MCListViewPullActionNone dataSource:nil];
 @endcode
 @param frame
 Frame of the list view.
 @param pullActionType
 Pull and push action type.
 @param dataSource
 Table list data source.
 @return UIView
 */
- (instancetype)initWithFrame:(CGRect)frame pullActionType:(MCListViewPullActionType)pullActionType dataSource:(NSArray *)dataSource;

- (void)appendObjects:(NSArray *)objects;
- (void)refreshWithObjects:(NSArray *)objects;
- (void)setEditable:(BOOL)editable;
- (void)resize:(CGSize)frame;
- (void)scrollToBottom;
- (void)scrollToIndex:(NSInteger)index;

@end

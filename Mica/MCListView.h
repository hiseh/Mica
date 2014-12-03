//
//  MCListView.h
//  Mica
//
//  Created by hiseh yin on 14/12/3.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCView.h"
typedef enum {
    PullActionNone,
    PullActionRefresh,
    PullActionLoadMore,
    PullActionRefreshAndLoadMore
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

- (instancetype)initWithFrame:(CGRect)frame pullActionType:(MCListViewPullActionType)pullActionType dataSource:(NSArray *)dataSource;

- (void)appendObjects:(NSArray *)objects;
- (void)refreshWithObjects:(NSArray *)objects;
- (void)setEditable:(BOOL)editable;
- (void)resize:(CGSize)frame;
- (void)scrollToBottom;
- (void)scrollToIndex:(NSInteger)index;

@end

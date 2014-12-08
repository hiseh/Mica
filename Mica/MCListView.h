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

@class MCListView;
@protocol MCListViewDelegate <NSObject>
@optional
/**
 Asks the delegate if view should show load more indicator.
 @param listView
 The current view.
 */
- (void)listViewShouldBeginLoadMore:(MCListView *)listView;

/**
 Asks the delegate if view should show refresh indicator.
 @param listView
 The current view.
 */
- (void)listViewShouldBeginRefresh:(MCListView *)listView;

/**
 Tells the delegate that the specified row is now selected.
 @param listView
 The current view.
 @param row
 The row num locating the new selected row.
 */
- (void)listView:(UIView *)listView didSelectRow:(NSInteger)row;

/**
 Tells the delegate if view did end editing mode.
 @param listView
 The current view.
 */
- (void)listViewDidEndEditing:(UIView *)listView;

@end

@interface MCListView : MCView <UITableViewDataSource, UITableViewDelegate> {
@private
    NSMutableArray  *dataSource__;
    UITableView     *tableView__;
    BOOL            editing__;
    BOOL            canMulitpleSelect__;
    MCListViewPullActionType pullActionType__;
}

@property (nonatomic, weak) id<MCListViewDelegate> delegate;

/**
 Enables the table list can be mulitple choice;
 */
@property (nonatomic, assign) BOOL mulitpleChoice;

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

/**
 Stop refresh indicator and load more indicator.
 */
- (void)stopPullAction;

/**
 Add the objects contained in another given array to the end of the table list.
 @param objects
 An array of objects to add to the end of the table list.
 */
- (void)appendObjects:(NSArray *)objects;

/**
 Refresh the table list.
 @param objects
 The new data source.
 */
- (void)refreshWithObjects:(NSArray *)objects;

/**
 Resize the view frame.
 @param frame
 The new Rect frame of the view.
 */
- (void)resizeWithFrame:(CGRect)frame;

/**
 Scrolls the receiver until a row identified by index is at a middle of the view.
 @param index
 The aim index of the row.
 */
- (void)scrollToIndex:(NSInteger)index;

/**
 Scrolls the receiver until the last row is at middle of the view.
 */
- (void)scrollToBottom;

/**
 Toggles the receiver into and out of editing mode.
 @param editing
 YES to enter editing mode, NO to leave it. The default value is NO .
 */
- (void)setEditing:(BOOL)editing;

@end

extern NSUInteger const LIST_ELEMENT_TAG;

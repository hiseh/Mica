//
//  MCGridView.h
//  Mica-Example
//
//  Created by hiseh yin on 14/12/4.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCListView.h"

@class MCGridView;
@protocol MCGridViewDelegate <MCListViewDelegate>

/**
 Tells the delegate that the specified element is now selected.
 @param gridView
 The current view.
 @param elementIdex
 The index locating the new selected element.
 */
- (void)gridView:(MCGridView *)gridView didSelectElement:(NSInteger)elementIdex;

@end

/**
 The root class of grid list view.
 */
@interface MCGridView : MCListView {
    CGSize      itemSize__;
    NSUInteger  numEveryRow__;
}

@property (nonatomic, weak) id <MCGridViewDelegate> delegate;

@end

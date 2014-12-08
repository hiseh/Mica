//
//  MCGridView.m
//  Mica-Example
//
//  Created by hiseh yin on 14/12/4.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "MCGridView.h"

@implementation MCGridView
@synthesize delegate;

static NSUInteger elementTag__;
- (instancetype)initWithFrame:(CGRect)frame pullActionType:(MCListViewPullActionType)pullActionType dataSource:(NSArray *)dataSource {
    elementTag__ = 0;
    numEveryRow__ = ((NSUInteger)frame.size.width - 5) / (((UIView *)[dataSource firstObject]).frame.size.width + 5);
    
    UIView *itemView = (UIView *)[dataSource firstObject];
    itemSize__ = CGSizeMake(itemView.frame.size.width, itemView.frame.size.height);
    
    self = [super initWithFrame:frame
                 pullActionType:pullActionType
                     dataSource:[self generateElementListWithFrame:frame dataSource:dataSource]];
    return self;
}

- (void)appendObjects:(NSArray *)objects {
    [super appendObjects:[self generateElementListWithFrame:self.bounds dataSource:objects]];
}

#pragma mark -
- (NSArray *)generateElementListWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    NSUInteger totalListNum = [dataSource count] % numEveryRow__ == 0? [dataSource count] / numEveryRow__: [dataSource count] / numEveryRow__ + 1;
    NSMutableArray *elementList = [NSMutableArray arrayWithCapacity:totalListNum];
    for (NSUInteger listI = 0; listI < totalListNum; listI ++) {
        UIView *elementView =[[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      frame.size.width,
                                                                      itemSize__.height + 10)];
        for (NSUInteger itemI = listI * numEveryRow__; (itemI < (listI + 1) * numEveryRow__) && (itemI < [dataSource count]); itemI ++) {
            UIView *itemView = (UIView *)[dataSource objectAtIndex:itemI];
            itemView.frame = CGRectMake(5 + (itemView.frame.size.width + 5) * (itemI % numEveryRow__),
                                        5,
                                        itemSize__.width,
                                        itemSize__.height);
            [elementView addSubview:itemView];
            
            {
                UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
                iconButton.tag = LIST_ELEMENT_TAG + elementTag__ ++;
                iconButton.frame = itemView.frame;
                [iconButton addTarget:self action:@selector(pressItem:) forControlEvents:UIControlEventTouchUpInside];
                [elementView addSubview:iconButton];
            }
        }
        [elementList addObject:elementView];
    }
    return elementList;
}

- (void)pressItem:(UIButton *)sender
{
    NSUInteger tagNum = sender.tag - LIST_ELEMENT_TAG;
    [self.delegate gridView:self didSelectElement:tagNum];
}
@end

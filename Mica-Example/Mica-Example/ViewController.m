//
//  ViewController.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/26.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "ViewController.h"
#import "Mica.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - test mclistview
- (void)initListView {
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i ++) {
        UILabel *element = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40) parameterKey:@"Body"];
        element.backgroundColor = [UIColor colorFromPlistWithKey:@"DarKSeparatorColor"];
        element.text = [NSString stringWithFormat:@"第 %d 个", i];
        element.textAlignment = NSTextAlignmentCenter;
        [dataSource addObject:element];
    }
    MCGridView *gridView = [[MCGridView alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height)
                                              pullActionType:MCListViewPullActionRefreshAndLoadMore
                                                  dataSource:dataSource];
    gridView.delegate = self;
    [self.view addSubview:gridView];
}

- (void)listViewShouldBeginLoadMore:(MCListView *)listView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [listView stopPullAction];
    });
}

- (void)listViewShouldBeginRefresh:(MCListView *)listView {
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [listView stopPullAction];
   });
}

- (void)gridView:(MCGridView *)gridView didSelectElement:(NSInteger)elementIdex {
    NSLog(@"select element is %d", elementIdex);
}

- (void)listView:(UIView *)listView didSelectRow:(NSInteger)row {
    NSLog(@"selected row is %d", row);
}

- (void)listViewDidEndEditing:(UIView *)listView {
    
}


@end

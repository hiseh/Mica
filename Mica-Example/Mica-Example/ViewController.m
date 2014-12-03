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
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel *element = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) parameterKey:@"Title"];
        element.text = [NSString stringWithFormat:@"%d", i];
        element.textAlignment = NSTextAlignmentCenter;
        [dataSource addObject:element];
    }
    MCListView *listView = [[MCListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                              pullActionType:MCListViewPullActionLoadMore
                                                  dataSource:dataSource];
    listView.delegate = self;
    [self.view addSubview:listView];
}

- (void)listViewShouldBeginLoadMore:(MCListView *)listView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500 * NSEC_PER_MSEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [listView stopPullAction];
    });
}

- (void)listView:(UIView *)listView didSelectRow:(NSInteger)row {
    NSLog(@"selected row is %d", row);
}

- (void)listViewDidEndEditing:(UIView *)listView {
    
}


@end

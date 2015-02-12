//
//  ViewController.m
//  Mica-Example
//
//  Created by hiseh yin on 14/11/26.
//  Copyright (c) 2014年 hiseh. All rights reserved.
//

#import "ViewController.h"
#import "Mica.h"

@interface ViewController () {
@private
    NSString *identifier__;
    MCRSA *rsa__;
    NSString *planText__;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self initListView];
    
//    {
//        //测试rsa
//        identifier__ = @"org.hiseh.rsa_key_test";
//        planText__ = @"hello";
//        rsa__ = [[MCRSA alloc] initWithIdntifier:identifier__];
//    
//        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button1.frame = CGRectMake(0, 0, 100, 40);
//        [button1 setTitle:@"创建&保存" forState:UIControlStateNormal];
//        button1.center = CGPointMake(self.view.center.x, 100);
//        [button1 addTarget:self action:@selector(initRSA) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button1];
//        
//        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button2.frame = button1.frame;
//        button2.center = CGPointMake(button1.center.x, button1.center.y + 40);
//        [button2 setTitle:@"读取&解密" forState:UIControlStateNormal];
//        [button2 addTarget:self action:@selector(useRSA) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button2];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - test rsa
- (void)initRSA {
    [rsa__ generateKeyPair];
    NSLog(@"public key:\n%@", rsa__.base64PublicKey);
    BOOL result = [rsa__ localKeyWriteToFile];
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RSA"
                                                        message:@"创建成功"
                                                       delegate:nil
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)useRSA {
    [rsa__ localKeyPairWithContentsOfFile];
    NSLog(@"public key:\n%@", rsa__.base64PublicKey);
    
    NSString *encrypted1 = @"EfEneo5AoOLk0Mjl6jeBJGUgkjKvJ01W9NmFJNc80Y2bdq/v966FpB1r1Y6OgjQWaytXoMGICj1wQNsr9u0tonrwWuB1uHHVA0I3gzhfuvA/dfgJDBiyDRz464cXYWQ8EO29mawTwhc5RVqU2WgeoQA431rYVLRszEOdiNHqJkc=";
    NSString *encrypted2 = [rsa__ encryptWithKeySource:PublicKeyFromLocal text:planText__];
    
//    NSLog(@"加密后，1:\n%@\n2:\n%@", encrypted1, encrypted2);
    
    NSString *recovered1 = [[rsa__ decrypt:encrypted1] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSString *recovered2 = [[rsa__ decrypt:encrypted2] stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
//    NSLog(@"解密后，1:\n%@\n2:\n%@", recovered1, recovered2);
    if ([recovered1 isEqualToString:planText__] && [recovered2 isEqualToString:planText__]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RSA" message:@"OK" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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

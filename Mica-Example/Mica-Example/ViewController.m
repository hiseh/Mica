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
    {
        identifier__ = @"org.hiseh.rsa_key_test";
        planText__ = @"hello";
        

        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button1.frame = CGRectMake(0, 0, 100, 40);
        [button1 setTitle:@"保存" forState:UIControlStateNormal];
        button1.center = CGPointMake(self.view.center.x, 100);
        [button1 addTarget:self action:@selector(saveKeychain) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];

        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button2.frame = button1.frame;
        button2.center = CGPointMake(button1.center.x, button1.center.y + 40);
        [button2 setTitle:@"读取" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(loadKeychain) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)saveKeychain {
    MCKeychainItemWrapper *wrapper = [[MCKeychainItemWrapper alloc] initWithIdentifier:identifier__ accessGroup:nil];
    if ([wrapper saveWithObject:planText__]) {
        NSLog(@"OK");
    }
//    if ([JNKeychain saveValue:planText__ forKey:identifier__]) {
//        NSLog(@"ok");
//    }
}

- (void)loadKeychain {
    MCKeychainItemWrapper *wrapper = [[MCKeychainItemWrapper alloc] initWithIdentifier:identifier__ accessGroup:nil];
    NSLog(@"result:\n%@\nend", [wrapper load]);
//    NSLog(@"result:\n%@\nend", [JNKeychain loadValueForKey:identifier__]);
}

@end

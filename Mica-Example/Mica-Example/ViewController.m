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
    
    UIColor *color = [UIColor colorFromHEX:@"ff00ff"];
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

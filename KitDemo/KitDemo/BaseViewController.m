//
//  BaseViewController.m
//  KitDemo
//
//  Created by Hu on 16/8/2.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self setUI];
}

- (void)initData {
    
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  WeicomeViewController.m
//  KitDemo
//
//  Created by Hu on 16/8/2.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "WelcomeViewController.h"
#import "YHWelcomeView.h"

@interface WelcomeViewController ()
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    [super setUI];
    self.navigationController.navigationBar.hidden = YES;

    YHWelcomeView *welcomeView = [[YHWelcomeView alloc] initWithPrefix:@"ind_upgrade" count:5 complete:nil];
    [welcomeView showInView:self.view];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end

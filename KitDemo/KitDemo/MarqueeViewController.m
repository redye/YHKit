//
//  MarqueeViewController.m
//  KitDemo
//
//  Created by Hu on 16/9/30.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "MarqueeViewController.h"
#import "YHMarqueeView.h"

@interface MarqueeViewController ()
@property (nonatomic, strong) YHMarqueeView *marqueeView;
@end

@implementation MarqueeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (void)setUI {
    [super setUI];
    
    _marqueeView = [[YHMarqueeView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), kMarqueeHeight) margin:10 fontSize:14.0];
    _marqueeView.bellImage = [UIImage imageNamed:@"star"];
    _marqueeView.backgroundColor = [UIColor orangeColor];
    _marqueeView.textColor = [UIColor whiteColor];
    [self.view addSubview:_marqueeView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 200, 100, 30);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"有动画" forState:UIControlStateNormal];
    [button setTitle:@"无动画" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(doAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)doAnimation:(UIButton *)button {
    if (!button.selected) {
        _marqueeView.message = @"转场动画就是从一个场景以动画的形式过渡到另一个场景。转场动画的使用一般分为以下几个步骤";
    } else {
        _marqueeView.message = @"转场动画";
    }
    button.selected = !button.selected;
}

@end

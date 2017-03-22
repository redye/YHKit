//
//  YHTransitionView.m
//  KitDemo
//
//  Created by Hu on 16/9/30.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "YHTransitionView.h"

@interface YHTransitionView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YHTransitionView
- (UIImageView *)imageView {
    if (_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)addGestures {
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipeGesture];
}

- (void)layoutSubviews {
    if (![self.imageView isDescendantOfView:self]) {
        [self addSubview:self.imageView];
        [self addGestures];
    }
    self.imageView.frame = self.bounds;
}

#pragma mark - Action
- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture {

}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture {

}

@end



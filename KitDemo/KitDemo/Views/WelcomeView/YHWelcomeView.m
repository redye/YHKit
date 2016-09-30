//
//  YHWelcomeView.m
//  KitDemo
//
//  Created by Hu on 16/8/2.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "YHWelcomeView.h"

typedef void(^CompleteBlock)(void);

#define kWelcomeViewAnimationDuration 0.3

@interface YHWelcomeView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControll;
@property (nonatomic, copy) NSString *prefix;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, copy) CompleteBlock complete;
@end

@implementation YHWelcomeView

- (instancetype)initWithPrefix:(NSString *)prefix count:(NSUInteger)count complete:(void (^)())complete {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    _prefix = prefix;
    _count = count;
    _complete = complete;
    [self setUI];
    return self;
}

- (void)setUI {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(width * _count, height);
    [self addSubview:_scrollView];
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageName = nil;
    for (int i = 0; i < _count; i ++) {
        x = width * i;
        if (scale == 3) {
            imageName = [NSString stringWithFormat:@"%@_%iX%i_%i.jpg", _prefix, 1080, 1920, i + 1];
        } else {
            imageName = [NSString stringWithFormat:@"%@_%dX%d_%d.jpg", _prefix, (int)(width * scale), (int)(height * scale), i + 1];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        imageView.image = [UIImage imageNamed:imageName];
        [_scrollView addSubview:imageView];
    }

    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - 40, width, 20)];
    _pageControll.numberOfPages = _count;
    _pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControll.currentPage = 0;
    [self addSubview:_pageControll];
    
    UIButton *ignoreButton = [[UIButton alloc] initWithFrame:CGRectMake(width - 65, 20, 50, 25)];
    [ignoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ignoreButton setTitle:@"跳过" forState:UIControlStateNormal];
    ignoreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [ignoreButton addTarget:self action:@selector(welcomeEnterApp) forControlEvents:UIControlEventTouchUpInside];
    ignoreButton.layer.cornerRadius = 3;
    ignoreButton.layer.borderWidth = 1;
    ignoreButton.layer.borderColor = [UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:1].CGColor;
    [self addSubview:ignoreButton];
    
    imageName = [NSString stringWithFormat:@"%@_start", _prefix];
    UIImage *nextImage = [UIImage imageNamed:imageName];
    CGSize imageSize = nextImage.size;
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    x = width * (_count - 1) + (width - imageSize.width) / 2;
    startButton.frame = CGRectMake(x, height - 40 - imageSize.height, imageSize.width, imageSize.height);
    [startButton setImage:nextImage forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(welcomeEnterApp) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:startButton];
}

- (void)welcomeEnterApp {
    [UIView animateWithDuration:kWelcomeViewAnimationDuration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.complete) {
            self.complete();
        }
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)containerView {
    self.alpha = 0;
    [containerView addSubview:self];
    [UIView animateWithDuration:kWelcomeViewAnimationDuration animations:^{
        self.alpha = 1;
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSUInteger currentPage = offset.x / CGRectGetWidth(scrollView.frame);
    _pageControll.currentPage = currentPage;
}


@end


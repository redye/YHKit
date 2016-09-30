//
//  MarqueeView.m
//  KeyframeAnimation
//
//  Created by Hu on 16/9/29.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "YHMarqueeView.h"

NSString * const kAnimationKey = @"MarqueeAnimation";
static NSInteger kReferenceWidth = 500;

@interface YHMarqueeView ()
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat visibleWidth;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat fontSize;
@end

@implementation YHMarqueeView

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
    }
    return _label1;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
    }
    return _label2;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (CGFloat)visibleWidth {
    _visibleWidth = CGRectGetWidth(self.frame) - kMarqueeHeight - _margin * 3;
    return _visibleWidth;
}

- (void)setUI {
    _margin = 10.0;
    self.imageView.frame = CGRectMake(_margin, 0, kMarqueeHeight, kMarqueeHeight);
    CGFloat x = CGRectGetMaxX(self.imageView.frame) + _margin;
    self.contentView.frame = CGRectMake(x, 0, self.visibleWidth, kMarqueeHeight);
    self.label1.frame = self.contentView.bounds;
    self.label2.frame = CGRectMake(CGRectGetWidth(self.contentView.frame), 0, 0, kMarqueeHeight);
    self.label1.font = [UIFont systemFontOfSize:_fontSize];
    self.label2.font = [UIFont systemFontOfSize:_fontSize];
    
    [self addSubview:self.imageView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
}

- (void)setContentWidth:(CGFloat)contentWidth {
    
    CGRect frame1 = self.label1.frame;
    CGRect frame2 = self.label2.frame;
    if (contentWidth > self.visibleWidth) {
        contentWidth += 100;
        
        frame1.size.width = contentWidth;
        frame2.origin.x = contentWidth;
        frame2.size.width = contentWidth;
        
        self.label1.frame = frame1;
        self.label2.frame = frame2;
        [self addAnimation];
    } else {
        contentWidth = self.visibleWidth;
        frame1.size.width = contentWidth;
        frame2.origin.x = contentWidth;
        frame2.size.width = contentWidth;
        
        self.label1.frame = frame1;
        self.label2.frame = frame2;
        [self removeAnimation];
    }
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.label1.text = _message;
    self.label2.text = _message;
    CGFloat width = [_message sizeWithAttributes:@{NSFontAttributeName: self.label1.font}].width;
    [self setContentWidth:width];
}

- (void)addAnimation {
    CGFloat contentWidth = CGRectGetWidth(self.label1.frame);
    CGFloat positionY = kMarqueeHeight / 2.0;
    CGFloat x = 0.9 / 2;
    if (![self.label1.layer animationForKey:kAnimationKey]) {
        NSArray *values = @[[NSValue valueWithCGPoint:CGPointMake(contentWidth / 2, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(-contentWidth / 2, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(contentWidth / 2 + contentWidth, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(contentWidth / 2 + contentWidth, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(contentWidth / 2, positionY)]];
        CAKeyframeAnimation *animation1 = [self keyframeAnimationWithKeyPath:@"position"
                                                                      values:values
                                                                    keyTimes:@[@(0.05), @(x + 0.05), @(x + 0.05), @(x + 0.05 + 0.05), @(1)]];
        [self.label1.layer addAnimation:animation1 forKey:kAnimationKey];
    }
    if (![self.label2.layer animationForKey:kAnimationKey]) {
        self.label2.frame = CGRectMake(contentWidth, 0, contentWidth, kMarqueeHeight);
        self.label2.textColor = [UIColor redColor];
        NSArray *values = @[[NSValue valueWithCGPoint:CGPointMake(contentWidth / 2 + contentWidth, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(contentWidth / 2, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(contentWidth / 2, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(-contentWidth / 2, positionY)],
                            [NSValue valueWithCGPoint:CGPointMake(contentWidth / 2 + contentWidth, positionY)]];
        CAKeyframeAnimation *animation2 = [self keyframeAnimationWithKeyPath:@"position"
                                                                      values:values
                                                                    keyTimes:@[@(0.05), @(x + 0.05), @(x + 0.05 + 0.05), @(1), @(1)]];
        [self.label2.layer addAnimation:animation2 forKey:kAnimationKey];
    }
}

- (void)removeAnimation {
    [self.label1.layer removeAnimationForKey:kAnimationKey];
    [self.label2.layer removeAnimationForKey:kAnimationKey];
}

- (NSTimeInterval)animationDuration {
    return 20 * CGRectGetWidth(self.label1.frame) / kReferenceWidth;
}

- (CAKeyframeAnimation *)keyframeAnimationWithKeyPath:(NSString *)keyPath values:(NSArray *)values keyTimes:(NSArray *)keyTimes {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.values = values;
    animation.keyTimes = keyTimes;
    animation.duration = [self animationDuration];
    animation.repeatCount = HUGE_VAL;
    animation.removedOnCompletion = NO;
    return animation;
}

- (void)setBellImage:(UIImage *)bellImage {
    _bellImage = bellImage;
    self.imageView.image = _bellImage;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label1.textColor = _textColor;
    self.label2.textColor = _textColor;
}

- (instancetype)initWithFrame:(CGRect)frame margin:(CGFloat)margin fontSize:(CGFloat)fontSize {
    self = [super initWithFrame:frame];
    _margin = margin;
    _fontSize = fontSize;
    [self setUI];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame margin:10.0 fontSize:14.0];
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

@end

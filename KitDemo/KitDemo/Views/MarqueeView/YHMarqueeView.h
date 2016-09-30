//
//  MarqueeView.h
//  KeyframeAnimation
//
//  Created by Hu on 16/9/29.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kMarqueeHeight = 30.0;


@interface YHMarqueeView : UIView

@property (nonatomic, strong) UIImage *bellImage;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, copy) NSString *message;

- (instancetype)initWithFrame:(CGRect)frame margin:(CGFloat)margin fontSize:(CGFloat)fontSize;


@end

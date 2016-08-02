//
//  YHWelcomeView.h
//  KitDemo
//
//  Created by Hu on 16/8/2.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHWelcomeView : UIView
- (instancetype)initWithPrefix:(NSString *)prefix count:(NSUInteger)count complete:(void(^)())complete;

- (void)showInView:(UIView *)containerView;
@end

//
//  ViewController.m
//  KitDemo
//
//  Created by Hu on 16/7/29.
//  Copyright © 2016年 redye. All rights reserved.
//

#import "ViewController.h"
#import "YHCarouselView.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<YHCarouselViewDelegate> {
    NSArray *_imageUrls;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YHCarouselView *carouselView = [[YHCarouselView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 200)];
    carouselView.delegate = self;
    [self.view addSubview:carouselView];
    
    NSArray *imageNames = @[@"IMG_0010.JPG",
                            @"IMG_0021.JPG",
                            @"IMG_0023.JPG",
                            @"IMG_0149.JPG",
                            @"IMG_0151.JPG",
                            @"IMG_0166.JPG"
                            ];
    _imageUrls = @[@"http://a.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40fa38bfc55a964034f79f019ec.jpg",
                   @"http://photo.enterdesk.com/2011-2-16/enterdesk.com-1AA0C93EFFA51E6D7EFE1AE7B671951F.jpg",
                   @"http://dl.bizhi.sogou.com/images/2012/09/30/44928.jpg",
                   @"http://dl.bizhi.sogou.com/images/2012/03/08/96703.jpg",
                   @"http://image.tianjimedia.com/uploadImages/2012/010/XC4Y39BYZT9A.jpg"
                   ];
    carouselView.imageCount = _imageUrls.count;
//    [carouselView loadImageNames:imageNames];
}

#pragma mark - YHCarouselViewDelegate
- (void)carouselView:(YHCarouselView *)carouselView didShowAtIndex:(NSUInteger)index imageView:(UIImageView *)imageView {
    NSString *url = [_imageUrls objectAtIndex:index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"下载完成 %@", image);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

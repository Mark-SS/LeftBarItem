//
//  UIViewController+LeftBarItem.h
//  Test0113NavigationBackBar
//
//  Created by markss on 15/1/13.
//  Copyright (c) 2015年 GL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LeftBarItem)

- (void)setLeftBarItemTitle:(NSString *)title;

- (void)setLeftBarItemTitle:(NSString *)title
                   callback:(void(^)(UIViewController *vc))callback;

- (void)setLeftBarItemImage:(UIImage *)image;

- (void)setLeftBarItemImage:(UIImage *)image
                   callback:(void(^)(UIViewController *vc))callback;

- (void)setLeftBarItemTitle:(NSString *)title
                      image:(UIImage *)image;

/**
 *  [self setLeftBarItemTitle:@"返回" 
                        image:[UIImage imageNamed:@"barbuttonicon_back"]
                     callback:^(UIViewController *vc) {
        [vc.navigationController popViewControllerAnimated:YES];
    }];
 *
 *  @param title    @"返回"
 *  @param image    @"image"
 *  @param callback callback
 */
- (void)setLeftBarItemTitle:(NSString *)title
                      image:(UIImage *)image
                   callback:(void(^)(UIViewController *vc))callback;

@end

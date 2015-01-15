//
//  UIViewController+LeftBarItem.m
//  Test0113NavigationBackBar
//
//  Created by markss on 15/1/13.
//  Copyright (c) 2015年 GL. All rights reserved.
//

#import "UIViewController+LeftBarItem.h"
#import <objc/runtime.h>

static const void *LeftBarItemBlockKey = &LeftBarItemBlockKey;

@implementation UIViewController (LeftBarItem)

- (void)setLeftBarItemTitle:(NSString *)title {
    [self setLeftBarItemTitle:title
                        image:nil
                     callback:nil];
}

- (void)setLeftBarItemTitle:(NSString *)title
                   callback:(void(^)(UIViewController *vc))callback {
    [self setLeftBarItemTitle:title
                        image:nil
                     callback:callback];
}

- (void)setLeftBarItemImage:(UIImage *)image {
    [self setLeftBarItemTitle:nil
                        image:image
                     callback:nil];
    
}

- (void)setLeftBarItemImage:(UIImage *)image
                   callback:(void(^)(UIViewController *vc))callback {
    [self setLeftBarItemTitle:nil
                        image:image
                     callback:callback];
}

- (void)setLeftBarItemTitle:(NSString *)title
                      image:(UIImage *)image {
    [self setLeftBarItemTitle:title
                        image:image
                     callback:nil];
}

- (void)setLeftBarItemTitle:(NSString *)title
                      image:(UIImage *)image
                   callback:(void(^)(UIViewController *vc))callback {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    CGSize size;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        size = [button.titleLabel sizeThatFits:CGSizeMake(60, 30)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        if (!title) {
            size = image.size;
        } else {
            size.width += image.size.width;
            size.height = size.height > image.size.height ? size.height : image.size.height;
        }
       [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    
    button.frame = CGRectMake(0, 0, size.width, size.height);
    
    if (callback) {
        objc_setAssociatedObject(self, LeftBarItemBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    [button addTarget:self
               action:@selector(popBack:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma private function
- (void)popBack:(id)sender {
    void (^callback)(UIViewController *vc) = objc_getAssociatedObject(self, LeftBarItemBlockKey);
    if (callback) {
        callback(self);
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end

//
//  ViewController.m
//  RuntimeInvoker
//
//  Created by cyan on 16/5/27.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+RuntimeInvoker.h"

@implementation ViewController

- (CGRect)aRect {
    return CGRectMake(0, 0, 100, 100);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // public selector
    CGRect rect = [[self invoke:@"aRect"] CGRectValue];
    NSLog(@"rect: %@", NSStringFromCGRect(rect));
    
    // public selector with argument
    [self.view invoke:@"setBackgroundColor:" arguments:@[ [UIColor whiteColor] ]];
    [self.view invoke:@"setAlpha:" arguments:@[ @(0.5) ]];
    [UIView animateWithDuration:3 animations:^{
        [self.view invoke:@"setAlpha:" arguments:@[ @(1.0)]];
    }];
    
    // private selector
    int sizeClass = [[self invoke:@"_verticalSizeClass"] intValue];
    NSLog(@"sizeClass: %d", sizeClass);
    
    // private selector with argument
    [self invoke:@"_setShowingLinkPreview:" args:@(NO), nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self invoke:@"_setShowingLinkPreview:" args:@(YES), nil];
    });
}

@end

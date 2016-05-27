//
//  NSObject+RuntimeInvoker.h
//  RuntimeInvoker
//
//  Created by cyan on 16/5/27.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeInvoker)

/**
 *  Invoke a selector with name
 *
 *  @param selector selector name
 *
 *  @return return value
 */
- (id)invoke:(NSString *)selector;

/**
 *  Invoke a selector with name and args
 *
 *  @param selector  selector name
 *  @param arguments arguments list
 *
 *  @return return value
 */
- (id)invoke:(NSString *)selector arguments:(NSArray *)arguments;

/**
 *  Invoke a selector with name and args
 *
 *  @param selector selector name
 *  @param arg      arguments list (end with nil)
 *
 *  @return return value
 */
- (id)invoke:(NSString *)selector args:(id)arg, ... ;

+ (id)invoke:(NSString *)selector;
+ (id)invoke:(NSString *)selector arguments:(NSArray *)arguments;
+ (id)invoke:(NSString *)selector args:(id)arg, ... ;

@end

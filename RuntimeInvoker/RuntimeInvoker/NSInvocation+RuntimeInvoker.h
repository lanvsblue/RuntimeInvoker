//
//  NSInvocation+RuntimeInvoker.h
//  RuntimeInvoker
//
//  Created by cyan on 16/3/31.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (RuntimeInvoker)

/**
 *  Invoke and return a object
 *
 *  @param target   target
 *  @param selector selector
 *
 *  @return object
 */
- (id)invoke:(id)target selector:(SEL)selector;

@end

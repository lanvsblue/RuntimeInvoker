//
//  NSObject+RuntimeInvoker.m
//  RuntimeInvoker
//
//  Created by cyan on 16/5/27.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "NSObject+RuntimeInvoker.h"
#import "NSInvocation+RuntimeInvoker.h"
#import "NSMethodSignature+RuntimeInvoker.h"

@implementation NSObject (RuntimeInvoker)

- (id)invoke:(NSString *)selector {
    return [self invoke:selector arguments:@[]];
}

- (id)invoke:(NSString *)selector arguments:(NSArray *)arguments {
    SEL sel = NSSelectorFromString(selector);
    NSMethodSignature *signature = [self methodSignatureForSelector:sel];
    NSInvocation *invocation = [signature invocationWithArguments:arguments];
    id returnValue = [invocation invoke:self selector:sel];
    return returnValue;
}

- (id)invoke:(NSString *)selector args:(id)arg, ... {
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:arg];
    
    va_list args;
    va_start(args, arg);
    
    id next = nil;
    while ((next = va_arg(args,id))) {
        [array addObject:next];
    }
    
    va_end(args);
    
    return [self invoke:selector arguments:array];
}

+ (id)invoke:(NSString *)selector {
    return [self.class invoke:selector arguments:@[]];
}

+ (id)invoke:(NSString *)selector arguments:(NSArray *)arguments {
    SEL sel = NSSelectorFromString(selector);
    NSMethodSignature *signature = [self.class methodSignatureForSelector:sel];
    NSInvocation *invocation = [signature invocationWithArguments:arguments];
    id returnValue = [invocation invoke:self selector:sel];
    return returnValue;
}

+ (id)invoke:(NSString *)selector args:(id)arg, ... {
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:arg];
    
    va_list args;
    va_start(args, arg);
    
    id next = nil;
    while ((next = va_arg(args,id))) {
        [array addObject:next];
    }
    
    va_end(args);
    
    return [self.class invoke:selector arguments:array];
}

@end

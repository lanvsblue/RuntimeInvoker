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

#define _DEFINE_ARRAY(arg) \
NSMutableArray *array = [NSMutableArray arrayWithObject:arg];\
va_list args;\
va_start(args, arg);\
id next = nil;\
while ((next = va_arg(args,id))) {\
    [array addObject:next];\
}\
va_end(args);\

@implementation NSObject (RuntimeInvoker)

id _invoke(id target, NSString *selector, NSArray *arguments) {
    SEL sel = NSSelectorFromString(selector);
    NSMethodSignature *signature = [target methodSignatureForSelector:sel];
    NSInvocation *invocation = [signature invocationWithArguments:arguments];
    id returnValue = [invocation invoke:target selector:sel];
    return returnValue;
}

- (id)invoke:(NSString *)selector arguments:(NSArray *)arguments {
    return _invoke(self, selector, arguments);
}

- (id)invoke:(NSString *)selector {
    return [self invoke:selector arguments:nil];
}

- (id)invoke:(NSString *)selector args:(id)arg, ... {
    _DEFINE_ARRAY(arg);
    return [self invoke:selector arguments:array];
}

+ (id)invoke:(NSString *)selector {
    return [self.class invoke:selector arguments:nil];
}

+ (id)invoke:(NSString *)selector args:(id)arg, ... {
    _DEFINE_ARRAY(arg);
    return [self.class invoke:selector arguments:array];
}

+ (id)invoke:(NSString *)selector arguments:(NSArray *)arguments {
    return _invoke(self.class, selector, arguments);
}

@end

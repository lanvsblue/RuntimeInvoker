//
//  NSInvocation+RuntimeInvoker.m
//  RuntimeInvoker
//
//  Created by cyan on 16/3/31.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "NSInvocation+RuntimeInvoker.h"
#import "NSMethodSignature+RuntimeInvoker.h"
#import <UIKit/UIKit.h>

@implementation NSInvocation (RuntimeInvoker)

/**
 *  Boxing returnType of NSMethodSignature
 *
 *  @param signature signature
 *
 *  @return boxed value
 */
- (id)returnValueOfSignature:(NSMethodSignature *)signature {
    
    id returnValue;
    
    RIMethodArgumentType returnType = [signature returnType];
    switch (returnType) {
        case RIMethodArgumentTypeChar: {
            char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeInt:  {
            int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeShort:  {
            short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeLong:  {
            long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeLongLong:  {
            long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeUnsignedChar:  {
            unsigned char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeUnsignedInt:  {
            unsigned int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeUnsignedShort:  {
            unsigned short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeUnsignedLong:  {
            unsigned long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeUnsignedLongLong:  {
            unsigned long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeFloat:  {
            float value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeDouble:  {
            double value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeBool: {
            BOOL value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case RIMethodArgumentTypeCharacterString: {
            const char *value;
            [self getReturnValue:&value];
            returnValue = [NSString stringWithUTF8String:value];
        } break;
        case RIMethodArgumentTypeCGPoint: {
            CGPoint value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGPoint:value];
        } break;
        case RIMethodArgumentTypeCGSize: {
            CGSize value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGSize:value];
        } break;
        case RIMethodArgumentTypeCGRect: {
            CGRect value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGRect:value];
        } break;
        case RIMethodArgumentTypeUIEdgeInsets: {
            UIEdgeInsets value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithUIEdgeInsets:value];
        } break;
        case RIMethodArgumentTypeObject:
        case RIMethodArgumentTypeClass:
            [self getReturnValue:&returnValue];
            break;
        default: break;
    }
    return returnValue;
}

- (id)invoke:(id)target selector:(SEL)selector {
    self.target = target;
    self.selector = selector;
    [self invoke];
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    return [self returnValueOfSignature:signature];
}

@end

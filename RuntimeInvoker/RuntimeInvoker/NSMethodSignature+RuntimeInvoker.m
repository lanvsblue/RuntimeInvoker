//
//  NSMethodSignature+RuntimeInvoker.m
//  RuntimeInvoker
//
//  Created by cyan on 16/3/31.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "NSMethodSignature+RuntimeInvoker.h"
#import <UIKit/UIKit.h>

@interface NSString (TypeChecking)

- (BOOL)isEqualToType:(char [])type;

@end

@implementation NSString (TypeChecking)

- (BOOL)isEqualToType:(char [])type {
    return [self isEqualToString:[NSString stringWithUTF8String:type]];
}

@end

@implementation NSMethodSignature (RuntimeInvoker)

- (RIMethodArgumentType)returnType {
    return [NSMethodSignature argumentTypeWithEncode:[self methodReturnType]];
}

+ (RIMethodArgumentType)argumentTypeWithEncode:(const char *)encode {
    NSString *type = [NSString stringWithUTF8String:encode];
    
    if ([type isEqualToType:@encode(char)]) {
        return RIMethodArgumentTypeChar;
    } else if ([type isEqualToType:@encode(int)]) {
        return RIMethodArgumentTypeInt;
    } else if ([type isEqualToType:@encode(short)]) {
        return RIMethodArgumentTypeShort;
    } else if ([type isEqualToType:@encode(long)]) {
        return RIMethodArgumentTypeLong;
    } else if ([type isEqualToType:@encode(long long)]) {
        return RIMethodArgumentTypeLongLong;
    } else if ([type isEqualToType:@encode(unsigned char)]) {
        return RIMethodArgumentTypeUnsignedChar;
    } else if ([type isEqualToType:@encode(unsigned int)]) {
        return RIMethodArgumentTypeUnsignedInt;
    } else if ([type isEqualToType:@encode(unsigned short)]) {
        return RIMethodArgumentTypeUnsignedShort;
    } else if ([type isEqualToType:@encode(unsigned long)]) {
        return RIMethodArgumentTypeUnsignedLong;
    } else if ([type isEqualToType:@encode(unsigned long long)]) {
        return RIMethodArgumentTypeUnsignedLongLong;
    } else if ([type isEqualToType:@encode(float)]) {
        return RIMethodArgumentTypeFloat;
    } else if ([type isEqualToType:@encode(double)]) {
        return RIMethodArgumentTypeDouble;
    } else if ([type isEqualToType:@encode(BOOL)]) {
        return RIMethodArgumentTypeBool;
    } else if ([type isEqualToType:@encode(void)]) {
        return RIMethodArgumentTypeVoid;
    } else if ([type isEqualToType:@encode(char *)]) {
        return RIMethodArgumentTypeCharacterString;
    } else if ([type isEqualToType:@encode(id)]) {
        return RIMethodArgumentTypeObject;
    } else if ([type isEqualToType:@encode(Class)]) {
        return RIMethodArgumentTypeClass;
    } else if ([type isEqualToType:@encode(CGPoint)]) {
        return RIMethodArgumentTypeCGPoint;
    } else if ([type isEqualToType:@encode(CGSize)]) {
        return RIMethodArgumentTypeCGSize;
    } else if ([type isEqualToType:@encode(CGRect)]) {
        return RIMethodArgumentTypeCGRect;
    } else if ([type isEqualToType:@encode(UIEdgeInsets)]) {
        return RIMethodArgumentTypeUIEdgeInsets;
    }
    
    return RIMethodArgumentTypeUnknown;
}

- (RIMethodArgumentType)argumentTypeAtIndex:(NSInteger)index {
    const char *encode = [self getArgumentTypeAtIndex:index];
    return [NSMethodSignature argumentTypeWithEncode:encode];
}

- (NSInvocation *)invocationWithArguments:(NSArray *)arguments {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self];
    
    if ([arguments isKindOfClass:[NSArray class]]) {
        [arguments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger index = idx + 2; // start with 2
            RIMethodArgumentType type = [self argumentTypeAtIndex:index];
            switch (type) {
                case RIMethodArgumentTypeChar: {
                    char value = [obj charValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeInt: {
                    int value = [obj intValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeShort: {
                    short value = [obj shortValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeLong: {
                    long value = [obj longValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeLongLong: {
                    long long value = [obj longLongValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeUnsignedChar: {
                    unsigned char value = [obj unsignedCharValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeUnsignedInt: {
                    unsigned int value = [obj unsignedIntValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeUnsignedShort: {
                    unsigned short value = [obj unsignedShortValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeUnsignedLong: {
                    unsigned long value = [obj unsignedLongValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeUnsignedLongLong: {
                    unsigned long long value = [obj unsignedLongLongValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeFloat: {
                    float value = [obj floatValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeDouble: {
                    double value = [obj doubleValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeBool: {
                    BOOL value = [obj boolValue];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeVoid: {
                    
                } break;
                case RIMethodArgumentTypeCharacterString: {
                    const char *value = [obj UTF8String];
                    [invocation setArgument:&value atIndex:index];
                } break;
                case RIMethodArgumentTypeObject: {
                    [invocation setArgument:&obj atIndex:index];
                } break;
                case RIMethodArgumentTypeClass: {
                    Class value = [obj class];
                    [invocation setArgument:&value atIndex:index];
                } break;
                    
                default: break;
            }
        }];
    }

    return invocation;
}

@end

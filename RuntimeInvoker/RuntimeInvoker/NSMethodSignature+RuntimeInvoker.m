//
//  NSMethodSignature+RuntimeInvoker.m
//  RuntimeInvoker
//
//  Created by cyan on 16/3/31.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "NSMethodSignature+RuntimeInvoker.h"
#import <UIKit/UIKit.h>

@implementation NSMethodSignature (RuntimeInvoker)

- (RIMethodArgumentType)returnType {
    return [NSMethodSignature argumentTypeWithEncode:[self methodReturnType]];
}

+ (RIMethodArgumentType)argumentTypeWithEncode:(const char *)encode {
    
    if (strcmp(encode, @encode(char)) == 0) {
        return RIMethodArgumentTypeChar;
    } else if (strcmp(encode, @encode(int)) == 0) {
        return RIMethodArgumentTypeInt;
    } else if (strcmp(encode, @encode(short)) == 0) {
        return RIMethodArgumentTypeShort;
    } else if (strcmp(encode, @encode(long)) == 0) {
        return RIMethodArgumentTypeLong;
    } else if (strcmp(encode, @encode(long long)) == 0) {
        return RIMethodArgumentTypeLongLong;
    } else if (strcmp(encode, @encode(unsigned char)) == 0) {
        return RIMethodArgumentTypeUnsignedChar;
    } else if (strcmp(encode, @encode(unsigned int)) == 0) {
        return RIMethodArgumentTypeUnsignedInt;
    } else if (strcmp(encode, @encode(unsigned short)) == 0) {
        return RIMethodArgumentTypeUnsignedShort;
    } else if (strcmp(encode, @encode(unsigned long)) == 0) {
        return RIMethodArgumentTypeUnsignedLong;
    } else if (strcmp(encode, @encode(unsigned long long)) == 0) {
        return RIMethodArgumentTypeUnsignedLongLong;
    } else if (strcmp(encode, @encode(float)) == 0) {
        return RIMethodArgumentTypeFloat;
    } else if (strcmp(encode, @encode(double)) == 0) {
        return RIMethodArgumentTypeDouble;
    } else if (strcmp(encode, @encode(BOOL)) == 0) {
        return RIMethodArgumentTypeBool;
    } else if (strcmp(encode, @encode(void)) == 0) {
        return RIMethodArgumentTypeVoid;
    } else if (strcmp(encode, @encode(char *)) == 0) {
        return RIMethodArgumentTypeCharacterString;
    } else if (strcmp(encode, @encode(id)) == 0) {
        return RIMethodArgumentTypeObject;
    } else if (strcmp(encode, @encode(Class)) == 0) {
        return RIMethodArgumentTypeClass;
    } else if (strcmp(encode, @encode(CGPoint)) == 0) {
        return RIMethodArgumentTypeCGPoint;
    } else if (strcmp(encode, @encode(CGSize)) == 0) {
        return RIMethodArgumentTypeCGSize;
    } else if (strcmp(encode, @encode(CGRect)) == 0) {
        return RIMethodArgumentTypeCGRect;
    } else if (strcmp(encode, @encode(UIEdgeInsets)) == 0) {
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

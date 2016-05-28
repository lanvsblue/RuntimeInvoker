//
//  RuntimeInvoker.m
//  RuntimeInvoker
//
//  Created by cyan on 16/5/27.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "RuntimeInvoker.h"
#import <UIKit/UIKit.h>

#define _DEFINE_ARRAY(arg) \
NSMutableArray *array = [NSMutableArray arrayWithObject:arg];\
va_list args;\
va_start(args, arg);\
id next = nil;\
while ((next = va_arg(args,id))) {\
    [array addObject:next];\
}\
va_end(args);\

#pragma mark - NSMethodSignature Category

//  Objective-C Type Encoding: http://nshipster.com/type-encodings/
typedef NS_ENUM(NSInteger, RIMethodArgumentType) {
    RIMethodArgumentTypeUnknown             = 0,
    RIMethodArgumentTypeChar,
    RIMethodArgumentTypeInt,
    RIMethodArgumentTypeShort,
    RIMethodArgumentTypeLong,
    RIMethodArgumentTypeLongLong,
    RIMethodArgumentTypeUnsignedChar,
    RIMethodArgumentTypeUnsignedInt,
    RIMethodArgumentTypeUnsignedShort,
    RIMethodArgumentTypeUnsignedLong,
    RIMethodArgumentTypeUnsignedLongLong,
    RIMethodArgumentTypeFloat,
    RIMethodArgumentTypeDouble,
    RIMethodArgumentTypeBool,
    RIMethodArgumentTypeVoid,
    RIMethodArgumentTypeCharacterString,
    RIMethodArgumentTypeCGPoint,
    RIMethodArgumentTypeCGSize,
    RIMethodArgumentTypeCGRect,
    RIMethodArgumentTypeUIEdgeInsets,
    RIMethodArgumentTypeObject,
    RIMethodArgumentTypeClass
};

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

#pragma mark - NSInvocation Category

@implementation NSInvocation (RuntimeInvoker)

/**
 *  Boxing returnType of NSMethodSignature
 *
 *  @param signature signature
 *
 *  @return boxed value
 */
- (id)returnValueOfSignature:(NSMethodSignature *)signature {
    
    __unsafe_unretained id returnValue;
    
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

- (id)invoke:(id)target selector:(SEL)selector signature:(NSMethodSignature *)signature {
    self.target = target;
    self.selector = selector;
    [self invoke];
    return [self returnValueOfSignature:signature];
}

@end

#pragma mark - NSObject Category

@implementation NSObject (RuntimeInvoker)

id _invoke(id target, NSString *selector, NSArray *arguments) {
    SEL sel = NSSelectorFromString(selector);
    NSMethodSignature *signature = [target methodSignatureForSelector:sel];
    if (signature) {
        NSInvocation *invocation = [signature invocationWithArguments:arguments];
        id returnValue = [invocation invoke:target selector:sel signature:signature];
        return returnValue;
    } else {
        NSLog(@"# RuntimeInvoker # selector: \"%@\" NOT FOUND", selector);
        return nil;
    }
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

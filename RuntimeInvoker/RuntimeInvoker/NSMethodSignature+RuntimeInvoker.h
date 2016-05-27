//
//  NSMethodSignature+RuntimeInvoker.h
//  RuntimeInvoker
//
//  Created by cyan on 16/3/31.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface NSMethodSignature (RuntimeInvoker)

/**
 *  NSMethodSignature return type
 *
 *  @return type
 */
- (RIMethodArgumentType)returnType;

/**
 *  Argument type at index
 *
 *  @param index index
 *
 *  @return argument type
 */
- (RIMethodArgumentType)argumentTypeAtIndex:(NSInteger)index;

/**
 *  Argument type with encode
 *
 *  @param encode encode
 *
 *  @return argument type
 */
+ (RIMethodArgumentType)argumentTypeWithEncode:(const char *)encode;

/**
 *  Get invocation with args list
 *
 *  @param arguments arguments
 *
 *  @return NSInvocation
 */
- (NSInvocation *)invocationWithArguments:(NSArray *)arguments;

@end

//
//  RuntimeInvoker.h
//  RuntimeInvoker
//
//  Created by cyan on 16/5/27.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LANEncryptTypeNoEncrypt,
    LANEncryptTypeBase64
}LANEncryptType;

@interface NSObject (RuntimeInvoker)

/**
 *  Invoke a selector with name
 *
 *  @param selector Selector name
 *
 *  @return Return value
 */
- (id)invoke:(NSString *)selector;

/**
 *  Invoke a selector with name
 *
 *  @param selector Selector name
 *  @param type     Encrypt type
 *
 *  @return Return value
 */

- (id)invoke:(NSString *)selector selectorEncryptType:(LANEncryptType) type;


/**
 *  Invoke a selector with name and args
 *
 *  @param selector Selector name
 *  @param arg      Arguments list (end with nil)
 *
 *  @return Return value
 */
- (id)invoke:(NSString *)selector args:(id)arg, ... ;


/**
 *  Invoke a selector with name and args
 *
 *  @param selector Selector name
 *  @param type     Encrypt type
 *  @param arg      Arguments list (end with nil)
 *
 *  @return Return value
 */
- (id)invoke:(NSString *)selector selectorEncryptType:(LANEncryptType) type args:(id)arg, ... ;


/**
 *  Invoke a selector with name and args
 *
 *  @param selector  Selector name
 *  @param arguments Arguments list
 *
 *  @return Return value
 */

- (id)invoke:(NSString *)selector arguments:(NSArray *)arguments;


/**
 *  Invoke a selector with name and args
 *
 *  @param selector  Selector name
 *  @param type      Encrypt type
 *  @param arguments Arguments list
 *
 *  @return Return value
 */

- (id)invoke:(NSString *)selector selectorEncryptType:(LANEncryptType) type arguments:(NSArray *)arguments;


/**
 *  Invoke a selector with name (Class Method)
 *
 *  @param selector Selector name
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector;


/**
 *  Invoke a selector with name (Class Method)
 *
 *  @param selector Selector name
 *  @param type     Encrypt type
 *
 *  @return Return value
 */

+ (id)invoke:(NSString *)selector selectorEncryptType:(LANEncryptType) type;



/**
 *  Invoke a selector with name and args (Class Method)
 *
 *  @param selector Selector name
 *  @param arg      Arguments list (end with nil)
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector args:(id)arg, ... ;


/**
 *  Invoke a selector with name and args (Class Method)
 *
 *  @param selector Selector name
 *  @param type     Encrypt type
 *  @param arg      Arguments list (end with nil)
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector selectorEncryptType:(LANEncryptType) type args:(id)arg, ... ;


/**
 *  Invoke a selector with name and args (Class Method)
 *
 *  @param selector  Selector name
 *  @param arguments Arguments list
 *
 *  @return Return value
 */
+ (id)invoke:(NSString *)selector arguments:(NSArray *)arguments;


/**
 *  Invoke a selector with name and args (Class Method)
 *
 *  @param selector  Selector name
 *  @param type      Encrypt type
 *  @param arguments Arguments list
 *
 *  @return Return value
 */

+ (id)invoke:(NSString *)selector selectorEncryptType:(LANEncryptType) type arguments:(NSArray *)arguments;

@end


/**
 NSString Category for Class Method
 */
@interface NSString (RuntimeInvoker)

/**
 Invoke class method with NSString

 @param selector Selector name
 @return Return value
 */
- (id)invokeClassMethod:(NSString *)selector;


/**
 Invoke class method with NSString
 
 @param selector      Selector name
 @param classType     Encrypt class type
 @param selectorType  Encrypt selector type
 @return Return value
 */
- (id)invokeClassMethod:(NSString *)selector classEncryptType:(LANEncryptType)classType selectorEncryptType:(LANEncryptType)selectorType;


/**
 Invoke class method with NSString

 @param selector Selector name
 @param arg Arguments list (end with nil)
 @return Return value
 */
- (id)invokeClassMethod:(NSString *)selector args:(id)arg, ... ;


/**
 Invoke class method with NSString
 
 @param selector Selector name
 @param classType     Encrypt class type
 @param selectorType  Encrypt selector type
 @param arg Arguments list (end with nil)
 @return Return value
 */
- (id)invokeClassMethod:(NSString *)selector classEncryptType:(LANEncryptType)classType selectorEncryptType:(LANEncryptType)selectorType args:(id)arg, ... ;


/**
 Invoke class method with NSString

 @param selector Selector name
 @param arguments Arguments list
 @return Return value
 */
- (id)invokeClassMethod:(NSString *)selector arguments:(NSArray *)arguments;


/**
 Invoke class method with NSString
 
 @param selector Selector name
 @param classType     Encrypt class type
 @param selectorType  Encrypt selector type
 @param arguments Arguments list
 @return Return value
 */
- (id)invokeClassMethod:(NSString *)selector classEncryptType:(LANEncryptType)classType selectorEncryptType:(LANEncryptType)selectorType arguments:(NSArray *)arguments;

/**
 解密Base64算法生成的字符串
 */
- (NSString *)decodeBase64;
@end

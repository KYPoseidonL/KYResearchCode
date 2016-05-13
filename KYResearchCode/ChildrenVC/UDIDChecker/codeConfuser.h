//
//  codeConfuser.h
//  FMDecrypt
//
//

#import <Foundation/Foundation.h>

@interface codeConfuser : NSObject

@property (nonatomic,copy) NSString *key;

/**
 *  数组加密
 *
 *  @param array 要加密的字符串数组
 *
 *  @return 加密好的字符串数组
 */
- (NSMutableString *)powerfulEncodeStrArr:(NSArray*)array;


/**
 *  解密工具方法 （字符串）
 *
 *  @return 返回一个字典，value为解密后的字符串，key是在加密时规定好的key
 */
- (NSMutableDictionary* )powerfulDecodeWithStr:(NSString*)str;



@end

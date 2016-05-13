//
//  codeConfuser.m
//  FMDecrypt
//
//

#import "codeConfuser.h"
#import "FMEncryption.h"
#import "AESCrypt.h"
@interface codeConfuser ()
{
    FMEncryption* encryptImpl;
    
}

@property (nonatomic,strong) NSMutableArray *encodeArr;

@end


@implementation codeConfuser

- (NSMutableArray *)encodeArr
{
    if (!_encodeArr) {
        _encodeArr = [[NSMutableArray alloc] init];
   
    }
        return  _encodeArr;
}


- (NSMutableString *)powerfulEncodeStrArr:(NSArray*)array
{
    __block NSMutableArray *encodeArr = [[NSMutableArray alloc] init];
    __block NSMutableString *Mstr = [[NSMutableString alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *str = (NSString*)obj;
        
        NSString *lsEncrypt = [AESCrypt encrypt:str password:[self Encrypter:self.key]];
//        DDLogDebug(@"idx: %lu",(unsigned long)idx);
//        DDLogDebug(@"lsEncrypt: %@",lsEncrypt);
        if (idx !=0) {
            [Mstr appendString:[NSString stringWithFormat:@"|||%@",lsEncrypt]];
        }else{
            [Mstr appendString:lsEncrypt];
        }
        [encodeArr addObject:lsEncrypt];
        
    }];
//    DDLogDebug(@"Mstr: %@",Mstr);
    self.encodeArr = encodeArr;
    return Mstr;
}

- (NSMutableDictionary* )powerfulDecodeWithStr:(NSString*)str
{
    NSArray *array = [str componentsSeparatedByString:@"|||"];
    __block  NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
    // NSLog(@"%@",array);
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        NSString *str = (NSString*)obj;
        NSString *lsDecrypt = [AESCrypt decrypt:str password:[self Encrypter:self.key]];
        
        NSArray* arr = [lsDecrypt componentsSeparatedByString:@"|"];
        // NSLog(@"%@",[arr objectAtIndex:0]);
        [arr objectAtIndex:0];
        //[mdic setObject:lsDecrypt forKey:[NSString stringWithFormat:@"func%ld",(unsigned long)idx]];
        [mdic setObject:[arr objectAtIndex:0] forKey:[arr objectAtIndex:1]];
    }];
    return mdic;
    
    
}


//- (NSMutableDictionary* )powerfulDecodeWithStrArr:(NSArray*)array
//{
//     __block  NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
//        NSString *str = (NSString*)obj;
//        NSString *lsDecrypt = [AESCrypt decrypt:str password:[self Encrypter:self.key]];
//        [mdic setObject:lsDecrypt forKey:[NSString stringWithFormat:@"func%ld",(unsigned long)idx]];
//    }];
//    
//    return mdic;
//}


/**
 *  加密key
 *
 *  @param content 要加密的字符串
 *
 *  @return 加密后的字符串
 */
- (NSString*) Encrypter:(NSString*)content
{
    if( encryptImpl == nil )
        encryptImpl = new FMEncryption();
    const char* datechar = [content UTF8String];
    
    char des[KCheckSumLength+1];
    memset(des, 0,sizeof(des));
    
    encryptImpl->Encipher(datechar,des,strlen(datechar));
    
    des[KCheckSumLength] = '\0';
    return [[NSString alloc] initWithCString:des encoding:NSUTF8StringEncoding];
}



@end

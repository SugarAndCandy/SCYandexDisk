//
//  SCYandexDiskKeychainStore.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 14.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskKeychainStore.h"

@implementation SCYandexDiskKeychainStore
- (instancetype)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup{
    if ((self = [super init])) {
        _service = service ? [service copy] : [[NSBundle mainBundle] bundleIdentifier];
        _accessGroup = [accessGroup copy];
        NSAssert(_service, @"Keychain must be initialized with service");
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithService:nil accessGroup:nil];
}

-(BOOL) setData:(NSData *)data forKey:(NSString *)key{
    
    OSStatus status;
    NSMutableDictionary * dict = [self queryForKey:key];
    
    NSData *cahhedData = [self dataForKey:key];
    
    if (data) {
        
        if (![data isEqualToData:cahhedData]) {
            
            if (cahhedData) {
                return [self updateData:data forKey:key];
            }
        } else {
            [self setData:nil forKey:key];
        }
        
        [dict setObject:data forKey:(__bridge id)kSecValueData];
        
        status = SecItemAdd((__bridge CFDictionaryRef)dict, NULL);
        if(errSecSuccess != status) {
            NSLog(@"Unable add item with key =%@ error:%d",key,(int)status);
        }
    } else {
        status = SecItemDelete((__bridge CFDictionaryRef)dict);
        if( status != errSecSuccess) {
            NSLog(@"Unable to remove item for key %@ with error:%d",key,(int)status);
            //return NO;
        }
    }
    
    return (errSecSuccess == status);
}

-(BOOL) updateData:(NSData*)data forKey:(NSString*)key
{
    NSMutableDictionary * dictKey =[self queryForKey:key];
    
    NSMutableDictionary * dictUpdate =[[NSMutableDictionary alloc] init];
    [dictUpdate setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)dictKey, (__bridge CFDictionaryRef)dictUpdate);
    if(errSecSuccess != status) {
        NSLog(@"Unable add update with key =%@ error:%d",key,(int)status);
    }
    return (errSecSuccess == status);
    
    return YES;
    
}

-(NSData*) dataForKey:(NSString*)key{
    NSMutableDictionary *dict = [self queryForKey:key];
    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dict,&result);
    
    if( status != errSecSuccess) {
        NSLog(@"Unable to fetch item for key %@ with error:%d",key,(int)status);
        return nil;
    }
    
    return (__bridge NSData *)result;
}


-(BOOL)setString:(NSString *)string forKey:(NSString *)key {
    NSData *date = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self setData:date forKey:key];
}
-(NSString *)stringForKey:(NSString *)key {
    NSData *data = [self dataForKey:key];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

-(BOOL)setNumberForKey:(NSNumber *)number forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:number];
    return [self setData:data forKey:key];
}
-(NSNumber *)numberForKey:(NSString *)key {
    NSData *data = [self dataForKey:key];
    NSNumber *indexNum = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return indexNum;
}

-(BOOL) setDicitonary:(NSDictionary *)data forKey:(NSString *)key {
    NSData *value = data == nil ? nil : [NSKeyedArchiver archivedDataWithRootObject:data];
    return [self setData:value forKey:key];
}

-(NSDictionary*) dictionaryForKey:(NSString*)key {
    NSData *data = [self dataForKey:key];
    if (!data) {
        return nil;
    }
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return dict;}

-(NSMutableDictionary*) queryForKey:(NSString *) key {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrGeneric];
    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrAccount];
    [dict setObject:_service forKey:(__bridge id)kSecAttrService];
    [dict setObject:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
    
    //This is for sharing data across apps
    if(_accessGroup != nil)
        [dict setObject:_accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
    
    return  dict;
    
}

@end

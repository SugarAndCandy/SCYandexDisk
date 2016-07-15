//
//  SCYandexDiskAccessToken.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 14.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskAccessToken.h"
#import "SCYandexDiskKeychainStore.h"

#define SC_ACCESSTOKEN_TOKENSTRING_KEY @"SC_ACCESSTOKEN_TOKENSTRING_KEY"

static SCYandexDiskAccessToken *_currentAccessToken;

NSString *const SCYandexDiskAccessTokenDidChangeNotification = @"SCYandexDiskAccessTokenDidChangeNotification";
NSString *const SCYandexDiskAccessTokenDidRemovedNotification = @"SCYandexDiskAccessTokenDidRemovedNotification";
NSString *const SCYandexDiskAccessTokenChangeNewKey = @"SCYandexDiskAccessTokenChangeNewKey";
NSString *const SCYandexDiskAccessTokenChangeOldKey = @"SCYandexDiskAccessTokenChangeOldKey";

static NSString *const kSCYandexDiskAccessTokenUserDefaultsKey = @"kSCYandexDiskAccessTokenUserDefaultsKey";
static NSString *const kSCYandexDiskAccessTokenUUIDKey = @"tokenUUID";
static NSString *const kSCYandexDiskAccessTokenEncodedKey = @"tokenEncoded";

@interface SCYandexDiskAccessToken ()

@end

@implementation SCYandexDiskAccessToken

- (instancetype)initWithTokenString:(NSString *)tokenString {
    if ((self = [super init])) {
        _tokenString = [tokenString copy];
    }
    return self;
    
}

#pragma mark - Class Methods

+ (SCYandexDiskAccessToken *)currentAccessToken {
    return [SCYandexDiskAccessToken fetchAccessToken];
}

static inline void setValueInDictionaryForKey(id object, NSMutableDictionary *dictionary, id key) {
    if (object && key && dictionary) {
        [dictionary setObject:object forKey:key];
    }
}

+ (void)setCurrentAccessToken:(SCYandexDiskAccessToken *)token {
    if (!token) {
        [SCYandexDiskAccessToken clearCache];
        [[NSNotificationCenter defaultCenter] postNotificationName:SCYandexDiskAccessTokenDidRemovedNotification
                                                            object:[self class]
                                                          userInfo:nil];
    } else {
        if (token != _currentAccessToken) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            setValueInDictionaryForKey(token,userInfo,SCYandexDiskAccessTokenChangeNewKey);
            setValueInDictionaryForKey(_currentAccessToken,userInfo,SCYandexDiskAccessTokenChangeNewKey);
            _currentAccessToken = token;
            [SCYandexDiskAccessToken cacheAccessToken:token];
            [[NSNotificationCenter defaultCenter] postNotificationName:SCYandexDiskAccessTokenDidChangeNotification
                                                                object:[self class]
                                                              userInfo:userInfo];
        }
    }
}

+ (void)refreshCurrentAccessToken:(SCYandexDiskAccessTokenRequestHandler)completionHandler {
    
}

#pragma mark NSCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *tokenString = [decoder decodeObjectOfClass:[NSString class] forKey:SC_ACCESSTOKEN_TOKENSTRING_KEY];
    return [self initWithTokenString:tokenString];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.tokenString forKey:SC_ACCESSTOKEN_TOKENSTRING_KEY];
}

#pragma mark - Private

+ (SCYandexDiskAccessToken *)fetchAccessToken{
    //return [[SCYandexDiskAccessToken alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:kSCYandexDiskAccessTokenUserDefaultsKey];
    
    NSString *keyChainServiceIdentifier = [NSString stringWithFormat:@"cloud-api.yandex.net.tokencache.%@", [[NSBundle mainBundle] bundleIdentifier]];
    SCYandexDiskKeychainStore *_keychainStore = [[SCYandexDiskKeychainStore alloc] initWithService:keyChainServiceIdentifier accessGroup:nil];
    
    NSDictionary *dict = [_keychainStore dictionaryForKey:kSCYandexDiskAccessTokenUserDefaultsKey];
    if (![dict[kSCYandexDiskAccessTokenUUIDKey] isEqualToString:uuid]) {
        // if the uuid doesn't match (including if there is no uuid in defaults which means uninstalled case)
        // clear the keychain and return nil.
        [SCYandexDiskAccessToken clearCache];
        return nil;
    }
    
    id tokenData = dict[kSCYandexDiskAccessTokenEncodedKey];
    if ([tokenData isKindOfClass:[NSData class]]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
    } else {
        return nil;
    }
}

+ (void)cacheAccessToken:(SCYandexDiskAccessToken *)token{
    if (!token) {
        [SCYandexDiskAccessToken clearCache];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:kSCYandexDiskAccessTokenUserDefaultsKey];
    if (!uuid) {
        uuid = [[NSUUID UUID] UUIDString];
        [defaults setObject:uuid forKey:kSCYandexDiskAccessTokenUserDefaultsKey];
        [defaults synchronize];
    }
    NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:token];
    NSDictionary *dict = @{kSCYandexDiskAccessTokenUUIDKey : uuid,
                           kSCYandexDiskAccessTokenEncodedKey : tokenData};
    NSString *keyChainServiceIdentifier = [NSString stringWithFormat:@"cloud-api.yandex.net.tokencache.%@", [[NSBundle mainBundle] bundleIdentifier]];
    SCYandexDiskKeychainStore *_keychainStore = [[SCYandexDiskKeychainStore alloc] initWithService:keyChainServiceIdentifier accessGroup:nil];
    [_keychainStore setDicitonary:dict
                           forKey:kSCYandexDiskAccessTokenUserDefaultsKey];
    
}

+ (void)clearCache{
    NSString *keyChainServiceIdentifier = [NSString stringWithFormat:@"cloud-api.yandex.net.tokencache.%@", [[NSBundle mainBundle] bundleIdentifier]];
    SCYandexDiskKeychainStore *_keychainStore = [[SCYandexDiskKeychainStore alloc] initWithService:keyChainServiceIdentifier accessGroup:nil];
    [_keychainStore setDicitonary:nil
                           forKey:kSCYandexDiskAccessTokenUserDefaultsKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kSCYandexDiskAccessTokenUserDefaultsKey];
    [defaults synchronize];
}

@end
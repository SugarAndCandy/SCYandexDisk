//
//  SCYandexDiskAccessToken.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 14.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SC_YANDEX_DISK_EXTERN extern __attribute__((visibility ("default")))

@class SCYandexDiskAccessToken;
typedef void (^SCYandexDiskAccessTokenRequestHandler)(SCYandexDiskAccessToken *result, NSError *error);

/*
 @abstract Notification indicating that the `currentAccessToken` has changed.
 @discussion the userInfo dictionary of the notification will contain keys
 `SCYandexDiskAccessTokenChangeOldKey` and
 `SCYandexDiskAccessTokenChangeNewKey`.
 */
SC_YANDEX_DISK_EXTERN NSString *const SCYandexDiskAccessTokenDidChangeNotification;

/**
 Нотификация сообщающая о том, что настоящий Access Token был удален из хранилища.
 */
SC_YANDEX_DISK_EXTERN NSString *const SCYandexDiskAccessTokenDidRemovedNotification;

/*
 @abstract key in notification's userInfo object for getting the old token.
 @discussion If there was no old token, the key will not be present.
 */
SC_YANDEX_DISK_EXTERN NSString *const SCYandexDiskAccessTokenChangeOldKey;

/*
 @abstract key in notification's userInfo object for getting the new token.
 @discussion If there is no new token, the key will not be present.
 */
SC_YANDEX_DISK_EXTERN NSString *const SCYandexDiskAccessTokenChangeNewKey;

@interface SCYandexDiskAccessToken : NSObject <NSSecureCoding>

/*
 @abstract Returns the opaque token string.
 */
@property (readonly, copy, nonatomic) NSString *tokenString;

/*
 @abstract Initializes a new instance.
 @param tokenString the opaque token string.
 @param userID the user ID.
 @discussion This initializer should only be used for aSCanced apps that
 manage tokens explicitly. Typical login flows only need to use `SCLoginManager`
 along with `+currentAccessToken`.
 */

- (instancetype)initWithTokenString:(NSString *)tokenString;

/*
 @abstract Returns the "global" access token that represents the currently logged in user.
 */
+ (SCYandexDiskAccessToken *)currentAccessToken;

/*
 @abstract Sets the "global" access token that represents the currently logged in user.
 @param token The access token to set.
 @discussion This will broadcast a notification and save the token to the app keychain.
 */
+ (void)setCurrentAccessToken:(SCYandexDiskAccessToken *)token;

@end


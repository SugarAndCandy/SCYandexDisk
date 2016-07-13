//
//  SCYandexDisk.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAuthDelegate.h"

/**
 @abstract Common interface for Authentication View on iOS and OSX.

 @discussion
 This protocol represents the common interface of YOAuth2ViewController and YOAuth2WondowController.
 */
@protocol SCAuthProtocol <NSObject>

/**
 @abstract Delegate for the authentication process.
 */
@property (nonatomic, weak) id<SCAuthDelegate> delegate;

/**
 @abstract After suffessful authentication, this property contains the OAuth2 token that can be used with the registered Yandex web services.
 */
@property (nonatomic, copy, readonly) NSString *token;

@end

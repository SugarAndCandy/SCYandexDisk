//
//  SCService.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^yandexDiskCompletionHandler)(BOOL success, id responseData, NSError *error);

extern const struct YandexDiskErrorEntity {
    __unsafe_unretained NSString *status;
    __unsafe_unretained NSString *message;
    __unsafe_unretained NSString *errorCode;
} YandexDiskErrorEntity;

/**
 Вызывать когда от сервера пришел идентичный lastUpdate нашему.
 Возвращать в блоке success вместе с success == YES.
*/
static inline NSError *equalValuesError(void) {
    return [NSError errorWithDomain:@"Equal Values" code:304 userInfo:nil];
}

/**
 Возвращает ошибку соединения с интернетом.
*/
static inline NSError *connectionError(void) {
    return [NSError errorWithDomain:@"Connection"
                            code:NSURLErrorNotConnectedToInternet
                        userInfo:@{
                            YandexDiskErrorEntity.message :
                                @"Отсутствует соединение"
                        }];
}

/**
 Возвращает кастомную ошибку устаревшего токена.
*/
static inline NSError *oldTokenError(void) {
    return [NSError errorWithDomain:@"Old Token" code:0 userInfo:nil];
}

@interface SCYandexDiskService : NSObject

+ (SCYandexDiskService *)sharedInstance;
- (BOOL)connected;

- (void)getObjectsFromPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                completion:(yandexDiskCompletionHandler)completion;
- (void)postObjectsFromPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                 completion:(yandexDiskCompletionHandler)completion;
- (void)putObjectsFromPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                completion:(yandexDiskCompletionHandler)completion;
- (void)deleteObjectsFromPath:(NSString *)path
                   parameters:(NSDictionary *)parameters
                   completion:(yandexDiskCompletionHandler)completion;

@end
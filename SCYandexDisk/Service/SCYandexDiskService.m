//
//  SCService.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIKit+AFNetworking.h>
#import <Reachability/Reachability.h>
#import "SCYandexDiskAccessToken.h"
#import "SCYandexDiskConstantValues.h"
#import "SCYandexDiskService.h"

#define showNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define hideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

const struct YandexDiskErrorEntity YandexDiskErrorEntity = {
    .status = @"status",
    .message = @"message",
    .errorCode = @"errorCode"
};

typedef NS_ENUM(NSUInteger, SCServiceMethodType) {
    SCServiceMethodTypeGET,
    SCServiceMethodTypePOST,
    SCServiceMethodTypePUT,
    SCServiceMethodTypeDELETE
};

static NSString *const DISK_BASE_URL = @"https://cloud-api.yandex.net/v1/";

const struct YandexDiskHeaderKeys {
    __unsafe_unretained NSString *authorization;
} YandexDiskHeaderKeys = {
    .authorization = @"Authorization"
};

@interface SCYandexDiskService ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation SCYandexDiskService

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:DISK_BASE_URL]];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        SCYandexDiskAccessToken *token = [SCYandexDiskAccessToken currentAccessToken];
        if (token) {
            [requestSerializer setValue:token.tokenString forHTTPHeaderField:YandexDiskHeaderKeys.authorization];
            manager.requestSerializer = requestSerializer;
        }
        manager.requestSerializer = requestSerializer;
        _sessionManager = manager;
    }
    return _sessionManager;
}

+ (SCYandexDiskService *)sharedInstance {
    static dispatch_once_t onceToken;
    static SCYandexDiskService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[SCYandexDiskService alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:service
                                                 selector:@selector(accessTokenDidRemovedNotification:)
                                                     name:SCYandexDiskAccessTokenDidRemovedNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:service
                                                 selector:@selector(accessTokenDidChangedNotification:)
                                                     name:SCYandexDiskAccessTokenDidChangeNotification
                                                   object:nil];
    });
    return service;
}

- (BOOL)connected {
    Reachability *reachability =
    [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)accessTokenDidRemovedNotification:(NSNotification *)notification {
    [self.sessionManager.requestSerializer setValue:nil forHTTPHeaderField:YandexDiskHeaderKeys.authorization];
}

- (void)accessTokenDidChangedNotification:(NSNotification *)notification {
    [self.sessionManager.requestSerializer setValue:[SCYandexDiskAccessToken currentAccessToken].tokenString forHTTPHeaderField:YandexDiskHeaderKeys.authorization];
}

#pragma mark - Base Methods

- (void)getObjectsFromPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                completion:(yandexDiskCompletionHandler)completion {
    [self baseRequestWithType:SCServiceMethodTypeGET
                     fromPath:path
                   parameters:parameters
                   completion:completion];
}

- (void)postObjectsFromPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                 completion:(yandexDiskCompletionHandler)completion {
    [self baseRequestWithType:SCServiceMethodTypePOST
                     fromPath:path
                   parameters:parameters
                   completion:completion];
}

- (void)putObjectsFromPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                completion:(yandexDiskCompletionHandler)completion {
    [self baseRequestWithType:SCServiceMethodTypePUT
                     fromPath:path
                   parameters:parameters
                   completion:completion];
}

- (void)deleteObjectsFromPath:(NSString *)path
                   parameters:(NSDictionary *)parameters
                   completion:(yandexDiskCompletionHandler)completion {
    [self baseRequestWithType:SCServiceMethodTypeDELETE
                     fromPath:path
                   parameters:parameters
                   completion:completion];
}

- (void)baseRequestWithType:(SCServiceMethodType)type
                   fromPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                 completion:(yandexDiskCompletionHandler)completion {
    showNetworkActivityIndicator();
    
    if (!completion) {
        completion = ^(BOOL success, id responseData, NSError *error) {
        };
    }
    
    if (!self.connected) {
        hideNetworkActivityIndicator();
        completion(NO, nil, yandexDiskConnectionError());
        return;
    } else {
        switch (type) {
            case SCServiceMethodTypeGET: {
                [self.sessionManager GET:path
                              parameters:parameters
                                progress:^(NSProgress *_Nonnull downloadProgress) {
                                }
                                 success:^(NSURLSessionDataTask *_Nonnull task,
                                           id _Nullable responseObject) {
                                     [self requestType:type
                                                atPath:path
                                   withSessionDataTask:task
                                        withParameters:parameters
                    didFinishWithSuccessResponseObject:responseObject
                                            completiom:completion];
                                 }
                                 failure:^(NSURLSessionDataTask *_Nullable task,
                                           NSError *_Nonnull error) {
                                     [self requestType:type
                                                atPath:path
                                   withSessionDataTask:task
                                        withParameters:parameters
                                    didFinishWithError:error
                                            completion:completion];
                                 }];
                break;
            }
                
            case SCServiceMethodTypePOST: {
                [self.sessionManager POST:path
                               parameters:parameters
                                 progress:^(NSProgress *_Nonnull uploadProgress) {
                                 }
                                  success:^(NSURLSessionDataTask *_Nonnull task,
                                            id _Nullable responseObject) {
                                      [self requestType:type
                                                 atPath:path
                                    withSessionDataTask:task
                                         withParameters:parameters
                     didFinishWithSuccessResponseObject:responseObject
                                             completiom:completion];
                                  }
                                  failure:^(NSURLSessionDataTask *_Nullable task,
                                            NSError *_Nonnull error) {
                                      [self requestType:type
                                                 atPath:path
                                    withSessionDataTask:task
                                         withParameters:parameters
                                     didFinishWithError:error
                                             completion:completion];
                                  }];
                break;
            }
            case SCServiceMethodTypePUT: {
                [self.sessionManager PUT:path
                              parameters:parameters
                                 success:^(NSURLSessionDataTask *_Nonnull task,
                                           id _Nullable responseObject) {
                                     [self requestType:type
                                                atPath:path
                                   withSessionDataTask:task
                                        withParameters:parameters
                    didFinishWithSuccessResponseObject:responseObject
                                            completiom:completion];
                                 }
                                 failure:^(NSURLSessionDataTask *_Nullable task,
                                           NSError *_Nonnull error) {
                                     [self requestType:type
                                                atPath:path
                                   withSessionDataTask:task
                                        withParameters:parameters
                                    didFinishWithError:error
                                            completion:completion];
                                 }];
                break;
            }
                
            case SCServiceMethodTypeDELETE: {
                [self.sessionManager DELETE:path
                                 parameters:parameters
                                    success:^(NSURLSessionDataTask *_Nonnull task,
                                              id _Nullable responseObject) {
                                        [self requestType:type
                                                   atPath:path
                                      withSessionDataTask:task
                                           withParameters:parameters
                       didFinishWithSuccessResponseObject:responseObject
                                               completiom:completion];
                                    }
                                    failure:^(NSURLSessionDataTask *_Nullable task,
                                              NSError *_Nonnull error) {
                                        [self requestType:type
                                                   atPath:path
                                      withSessionDataTask:task
                                           withParameters:parameters
                                       didFinishWithError:error
                                               completion:completion];
                                    }];
                break;
            }
        }
    }
}

- (void)requestType:(SCServiceMethodType)type
             atPath:(NSString *)path
withSessionDataTask:(NSURLSessionDataTask *)task
     withParameters:(NSDictionary *)parameters
didFinishWithSuccessResponseObject:(id)responseObject
         completiom:(yandexDiskCompletionHandler)completion {
    completion(YES, responseObject, nil);
    hideNetworkActivityIndicator();
}

- (void)requestType:(SCServiceMethodType)type
             atPath:(NSString *)path
withSessionDataTask:(NSURLSessionDataTask *)task
     withParameters:(NSDictionary *)parameters
 didFinishWithError:(NSError *)error
         completion:(yandexDiskCompletionHandler)completion {
    hideNetworkActivityIndicator();
    
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (errorData) {
        NSError *parsingError;
        NSDictionary *dataDict =
        [NSJSONSerialization JSONObjectWithData:errorData
                                        options:NSJSONReadingAllowFragments
                                          error:&parsingError];
        if (!parsingError && dataDict) {
            error = [NSError
                     errorWithDomain:path
                     code:[dataDict[YandexDiskErrorEntity.errorCode] integerValue]
                     userInfo:@{
                                YandexDiskErrorEntity.message : dataDict[YandexDiskErrorEntity.message]
                                }];
        }
    }
    
    [self checkErrorOldToken:error
          previousMethodType:type
                previousPath:path
          previousParameters:parameters
                  completion:completion];
}

- (void)checkErrorOldToken:(NSError *)error
        previousMethodType:(SCServiceMethodType)previousType
              previousPath:(NSString *)previousPath
        previousParameters:(NSDictionary *)previousParameters
                completion:(yandexDiskCompletionHandler)completion {
    NSLog(@"%@",error);
    if (error.code == yandexDiskOldTokenError().code) {
//TODO check token
        if (!error) {
            [self baseRequestWithType:previousType
                             fromPath:previousPath
                           parameters:previousParameters
                           completion:completion];
        } else {
            completion(NO, nil, error);
        }
    } else {
        completion(NO, nil, error);
    }
}

@end
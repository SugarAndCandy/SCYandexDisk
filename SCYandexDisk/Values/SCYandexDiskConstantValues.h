//
//  SCConstantValues.h
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#ifndef SCConstantValues_h
#define SCConstantValues_h

#define SC_EXTERN extern __attribute__((visibility ("default")))

#define showNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define hideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#endif /* SCConstantValues_h */


SC_EXTERN NSInteger const kSCSessionErrorUnknown;

SC_EXTERN NSString *const kSCSessionAuthenticationErrorDomain;
SC_EXTERN NSString *const kSCSessionBadArgumentErrorDomain;
SC_EXTERN NSString *const kSCSessionBadResponseErrorDomain;
SC_EXTERN NSString *const kSCSessionConnectionErrorDomain;
SC_EXTERN NSString *const kSCSessionRequestErrorDomain;

SC_EXTERN NSString *const kSCSessionConnectionDidFailAuthenticateWithError;
SC_EXTERN NSString *const kSCSessionResponseError;

SC_EXTERN NSString *const kSCSessionDidAuthNotification;
SC_EXTERN NSString *const kSCSessionDidFailWithAuthRequestNotification;
SC_EXTERN NSString *const kSCSessionDidFailWithFetchDirectoryRequestNotification;
SC_EXTERN NSString *const kSCSessionDidFailWithFetchStatusRequestNotification;
SC_EXTERN NSString *const kSCSessionDidFailToCreateDirectoryNotification;
SC_EXTERN NSString *const kSCSessionDidCreateDirectoryNotification;
SC_EXTERN NSString *const kSCSessionDidSendCreateDirectoryRequestNotification;
SC_EXTERN NSString *const kSCSessionDidRemoveNotification;
SC_EXTERN NSString *const kSCSessionDidFailWithRemoveRequestNotification;
SC_EXTERN NSString *const kSCSessionDidSendRemoveRequestNotification;
SC_EXTERN NSString *const kSCSessionDidFailToMoveNotification;
SC_EXTERN NSString *const kSCSessionDidMoveNotification;
SC_EXTERN NSString *const kSCSessionDidSendMoveRequestNotification;
SC_EXTERN NSString *const kSCSessionDidStartUploadFileNotification;
SC_EXTERN NSString *const kSCSessionDidFinishUploadFileNotification;
SC_EXTERN NSString *const kSCSessionDidSendPartialDataForFileNotification;
SC_EXTERN NSString *const kSCSessionDidFailUploadFileNotification;
SC_EXTERN NSString *const kSCSessionDidGetPartialDataForFileNotification;
SC_EXTERN NSString *const kSCSessionDidDownloadFileNotification;
SC_EXTERN NSString *const kSCSessionDidFailToDownloadFileNotification;
SC_EXTERN NSString *const kSCSessionDidStartDownloadFileNotification;
SC_EXTERN NSString *const kSCSessionDidPublishFileNotification;
SC_EXTERN NSString *const kSCSessionDidFailWithPublishRequestNotification;
SC_EXTERN NSString *const kSCSessionDidUnpublishFileNotification;
SC_EXTERN NSString *const kSCSessionDidFailWithUnpublishRequestNotification;
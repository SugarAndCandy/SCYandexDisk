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

#endif /* SCConstantValues_h */


SC_EXTERN NSInteger const kYDSessionErrorUnknown;

SC_EXTERN NSString *const kYDSessionAuthenticationErrorDomain;
SC_EXTERN NSString *const kYDSessionBadArgumentErrorDomain;
SC_EXTERN NSString *const kYDSessionBadResponseErrorDomain;
SC_EXTERN NSString *const kYDSessionConnectionErrorDomain;
SC_EXTERN NSString *const kYDSessionRequestErrorDomain;

SC_EXTERN NSString *const kYDSessionConnectionDidFailAuthenticateWithError;
SC_EXTERN NSString *const kYDSessionResponseError;

SC_EXTERN NSString *const kYDSessionDidAuthNotification;
SC_EXTERN NSString *const kYDSessionDidFailWithAuthRequestNotification;
SC_EXTERN NSString *const kYDSessionDidFailWithFetchDirectoryRequestNotification;
SC_EXTERN NSString *const kYDSessionDidFailWithFetchStatusRequestNotification;
SC_EXTERN NSString *const kYDSessionDidFailToCreateDirectoryNotification;
SC_EXTERN NSString *const kYDSessionDidCreateDirectoryNotification;
SC_EXTERN NSString *const kYDSessionDidSendCreateDirectoryRequestNotification;
SC_EXTERN NSString *const kYDSessionDidRemoveNotification;
SC_EXTERN NSString *const kYDSessionDidFailWithRemoveRequestNotification;
SC_EXTERN NSString *const kYDSessionDidSendRemoveRequestNotification;
SC_EXTERN NSString *const kYDSessionDidFailToMoveNotification;
SC_EXTERN NSString *const kYDSessionDidMoveNotification;
SC_EXTERN NSString *const kYDSessionDidSendMoveRequestNotification;
SC_EXTERN NSString *const kYDSessionDidStartUploadFileNotification;
SC_EXTERN NSString *const kYDSessionDidFinishUploadFileNotification;
SC_EXTERN NSString *const kYDSessionDidSendPartialDataForFileNotification;
SC_EXTERN NSString *const kYDSessionDidFailUploadFileNotification;
SC_EXTERN NSString *const kYDSessionDidGetPartialDataForFileNotification;
SC_EXTERN NSString *const kYDSessionDidDownloadFileNotification;
SC_EXTERN NSString *const kYDSessionDidFailToDownloadFileNotification;
SC_EXTERN NSString *const kYDSessionDidStartDownloadFileNotification;
SC_EXTERN NSString *const kYDSessionDidPublishFileNotification;
SC_EXTERN NSString *const kYDSessionDidFailWithPublishRequestNotification;
SC_EXTERN NSString *const kYDSessionDidUnpublishFileNotification;
SC_EXTERN NSString *const kYDSessionDidFailWithUnpublishRequestNotification;
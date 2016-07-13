//
//  SCConstantValues.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCYandexDiskConstantValues.h"

NSInteger const kSCSessionErrorUnknown = -1;

NSString *const kSCSessionAuthenticationErrorDomain = @"kSCSessionAuthenticationErrorDomain";
NSString *const kSCSessionBadArgumentErrorDomain = @"kSCSessionBadArgumentErrorDomain";
NSString *const kSCSessionBadResponseErrorDomain = @"kSCSessionBadResponseErrorDomain";
NSString *const kSCSessionRequestErrorDomain = @"kSCSessionRequestErrorDomain";
NSString *const kSCSessionConnectionErrorDomain = @"kSCSessionConnectionErrorDomain";

NSString *const kSCSessionConnectionDidFailAuthenticateWithError = @"kSCSessionConnectionDidFailAuthenticateWithError";
NSString *const kSCSessionResponseError = @"kSCSessionResponseError";

NSString *const kSCSessionDidAuthNotification = @"kSCSessionDidAuthNotification";
NSString *const kSCSessionDidFailWithAuthRequestNotification = @"kSCSessionDidFailWithAuthRequestNotification";
NSString *const kSCSessionDidFailWithFetchDirectoryRequestNotification = @"kSCSessionDidFailWithFetchDirectoryRequestNotification";
NSString *const kSCSessionDidFailWithFetchStatusRequestNotification = @"kSCSessionDidFailWithFetchStatusRequestNotification";
NSString *const kSCSessionDidFailToCreateDirectoryNotification = @"kSCSessionDidFailToCreateDirectoryNotification";
NSString *const kSCSessionDidCreateDirectoryNotification = @"kSCSessionDidCreateDirectoryNotification";
NSString *const kSCSessionDidSendCreateDirectoryRequestNotification = @"kSCSessionDidSendCreateDirectoryRequestNotification";
NSString *const kSCSessionDidRemoveNotification = @"kSCSessionDidRemoveNotification";
NSString *const kSCSessionDidFailWithRemoveRequestNotification = @"kSCSessionDidFailWithRemoveRequestNotification";
NSString *const kSCSessionDidSendRemoveRequestNotification = @"kSCSessionDidSendRemoveRequestNotification";
NSString *const kSCSessionDidFailToMoveNotification = @"kSCSessionDidFailToMoveNotification";
NSString *const kSCSessionDidMoveNotification = @"kSCSessionDidMoveNotification";
NSString *const kSCSessionDidSendMoveRequestNotification = @"kSCSessionDidSendMoveRequestNotification";
NSString *const kSCSessionDidStartUploadFileNotification = @"kSCSessionDidStartUploadFileNotification";
NSString *const kSCSessionDidFinishUploadFileNotification = @"kSCSessionDidFinishUploadFileNotification";
NSString *const kSCSessionDidSendPartialDataForFileNotification = @"kSCSessionDidSendPartialDataForFileNotification";
NSString *const kSCSessionDidFailUploadFileNotification = @"kSCSessionDidFailUploadFileNotification";
NSString *const kSCSessionDidGetPartialDataForFileNotification = @"kSCSessionDidGetPartialDataForFileNotification";
NSString *const kSCSessionDidDownloadFileNotification = @"kSCSessionDidDownloadFileNotification";
NSString *const kSCSessionDidFailToDownloadFileNotification = @"kSCSessionDidFailToDownloadFileNotification";
NSString *const kSCSessionDidStartDownloadFileNotification = @"kSCSessionDidStartDownloadFileNotification";
NSString *const kSCSessionDidPublishFileNotification = @"kSCSessionDidPublishFileNotification";
NSString *const kSCSessionDidFailWithPublishRequestNotification = @"kSCSessionDidFailWithPublishRequestNotification";
NSString *const kSCSessionDidUnpublishFileNotification = @"kSCSessionDidUnpublishFileNotification";
NSString *const kSCSessionDidFailWithUnpublishRequestNotification = @"kSCSessionDidFailWithUnpublishRequestNotification";
//
//  SCYandexDiskFile.h
//
//  Created by maks kolesnik on 13.07.16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCYandexDiskResource.h"

extern NSString *const file;

@interface SCYandexDiskFile: NSObject<NSCoding, NSCopying, SCYandexDiskResource>

@property (nonatomic, strong) NSString *preview;
@property (nonatomic, strong) NSString *modified;
@property (nonatomic, strong) NSString *mediaType;
@property (nonatomic, strong) NSString *publicUrl;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) double size;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *md5;
@property (nonatomic, strong) NSString *publicKey;
@property (nonatomic, strong) NSString *name;

+ (instancetype)fileFromDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

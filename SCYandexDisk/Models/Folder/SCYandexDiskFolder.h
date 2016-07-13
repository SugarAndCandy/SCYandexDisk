//
//  SCYandexDiskFolder.h
//
//  Created by maks kolesnik on 13.07.16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCYandexDiskResource.h"

extern NSString *const dir;

@interface SCYandexDiskFolder : NSObject<NSCoding, NSCopying, SCYandexDiskResource>

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *modified;

+ (instancetype)folderFromDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

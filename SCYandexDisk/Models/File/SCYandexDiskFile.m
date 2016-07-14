//
//  SCYandexDiskFile.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskFile.h"

NSString *const file = @"file";

NSString *const kSCYandexDiskFilePreview = @"preview";
NSString *const kSCYandexDiskFileModified = @"modified";
NSString *const kSCYandexDiskFileMediaType = @"media_type";
NSString *const kSCYandexDiskFilePublicUrl = @"public_url";
NSString *const kSCYandexDiskFilePath = @"path";
NSString *const kSCYandexDiskFileSize = @"size";
NSString *const kSCYandexDiskFileType = @"type";
NSString *const kSCYandexDiskFileMimeType = @"mime_type";
NSString *const kSCYandexDiskFileCreated = @"created";
NSString *const kSCYandexDiskFileMd5 = @"md5";
NSString *const kSCYandexDiskFilePublicKey = @"public_key";
NSString *const kSCYandexDiskFileName = @"name";

@interface SCYandexDiskFile ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SCYandexDiskFile

@synthesize preview = _preview;
@synthesize modified = _modified;
@synthesize mediaType = _mediaType;
@synthesize publicUrl = _publicUrl;
@synthesize path = _path;
@synthesize size = _size;
@synthesize type = _type;
@synthesize mimeType = _mimeType;
@synthesize created = _created;
@synthesize md5 = _md5;
@synthesize publicKey = _publicKey;
@synthesize name = _name;

+ (instancetype)fileFromDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.preview = [self objectOrNilForKey:kSCYandexDiskFilePreview fromDictionary:dict];
        self.modified = [self objectOrNilForKey:kSCYandexDiskFileModified fromDictionary:dict];
        self.mediaType = [self objectOrNilForKey:kSCYandexDiskFileMediaType fromDictionary:dict];
        self.publicUrl = [self objectOrNilForKey:kSCYandexDiskFilePublicUrl fromDictionary:dict];
        self.path = [self objectOrNilForKey:kSCYandexDiskFilePath fromDictionary:dict];
        self.size = [[self objectOrNilForKey:kSCYandexDiskFileSize fromDictionary:dict] doubleValue];
        self.type = [self objectOrNilForKey:kSCYandexDiskFileType fromDictionary:dict];
        self.mimeType = [self objectOrNilForKey:kSCYandexDiskFileMimeType fromDictionary:dict];
        self.created = [self objectOrNilForKey:kSCYandexDiskFileCreated fromDictionary:dict];
        self.md5 = [self objectOrNilForKey:kSCYandexDiskFileMd5 fromDictionary:dict];
        self.publicKey = [self objectOrNilForKey:kSCYandexDiskFilePublicKey fromDictionary:dict];
        self.name = [self objectOrNilForKey:kSCYandexDiskFileName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.preview forKey:kSCYandexDiskFilePreview];
    [mutableDict setValue:self.modified forKey:kSCYandexDiskFileModified];
    [mutableDict setValue:self.mediaType forKey:kSCYandexDiskFileMediaType];
    [mutableDict setValue:self.publicUrl forKey:kSCYandexDiskFilePublicUrl];
    [mutableDict setValue:self.path forKey:kSCYandexDiskFilePath];
    [mutableDict setValue:[NSNumber numberWithDouble:self.size] forKey:kSCYandexDiskFileSize];
    [mutableDict setValue:self.type forKey:kSCYandexDiskFileType];
    [mutableDict setValue:self.mimeType forKey:kSCYandexDiskFileMimeType];
    [mutableDict setValue:self.created forKey:kSCYandexDiskFileCreated];
    [mutableDict setValue:self.md5 forKey:kSCYandexDiskFileMd5];
    [mutableDict setValue:self.publicKey forKey:kSCYandexDiskFilePublicKey];
    [mutableDict setValue:self.name forKey:kSCYandexDiskFileName];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.preview = [aDecoder decodeObjectForKey:kSCYandexDiskFilePreview];
    self.modified = [aDecoder decodeObjectForKey:kSCYandexDiskFileModified];
    self.mediaType = [aDecoder decodeObjectForKey:kSCYandexDiskFileMediaType];
    self.publicUrl = [aDecoder decodeObjectForKey:kSCYandexDiskFilePublicUrl];
    self.path = [aDecoder decodeObjectForKey:kSCYandexDiskFilePath];
    self.size = [aDecoder decodeDoubleForKey:kSCYandexDiskFileSize];
    self.type = [aDecoder decodeObjectForKey:kSCYandexDiskFileType];
    self.mimeType = [aDecoder decodeObjectForKey:kSCYandexDiskFileMimeType];
    self.created = [aDecoder decodeObjectForKey:kSCYandexDiskFileCreated];
    self.md5 = [aDecoder decodeObjectForKey:kSCYandexDiskFileMd5];
    self.publicKey = [aDecoder decodeObjectForKey:kSCYandexDiskFilePublicKey];
    self.name = [aDecoder decodeObjectForKey:kSCYandexDiskFileName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_preview forKey:kSCYandexDiskFilePreview];
    [aCoder encodeObject:_modified forKey:kSCYandexDiskFileModified];
    [aCoder encodeObject:_mediaType forKey:kSCYandexDiskFileMediaType];
    [aCoder encodeObject:_publicUrl forKey:kSCYandexDiskFilePublicUrl];
    [aCoder encodeObject:_path forKey:kSCYandexDiskFilePath];
    [aCoder encodeDouble:_size forKey:kSCYandexDiskFileSize];
    [aCoder encodeObject:_type forKey:kSCYandexDiskFileType];
    [aCoder encodeObject:_mimeType forKey:kSCYandexDiskFileMimeType];
    [aCoder encodeObject:_created forKey:kSCYandexDiskFileCreated];
    [aCoder encodeObject:_md5 forKey:kSCYandexDiskFileMd5];
    [aCoder encodeObject:_publicKey forKey:kSCYandexDiskFilePublicKey];
    [aCoder encodeObject:_name forKey:kSCYandexDiskFileName];
}

- (id)copyWithZone:(NSZone *)zone {
    SCYandexDiskFile *copy = [[SCYandexDiskFile alloc] init];
    
    if (copy) {
        
        copy.preview = [self.preview copyWithZone:zone];
        copy.modified = [self.modified copyWithZone:zone];
        copy.mediaType = [self.mediaType copyWithZone:zone];
        copy.publicUrl = [self.publicUrl copyWithZone:zone];
        copy.path = [self.path copyWithZone:zone];
        copy.size = self.size;
        copy.type = [self.type copyWithZone:zone];
        copy.mimeType = [self.mimeType copyWithZone:zone];
        copy.created = [self.created copyWithZone:zone];
        copy.md5 = [self.md5 copyWithZone:zone];
        copy.publicKey = [self.publicKey copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
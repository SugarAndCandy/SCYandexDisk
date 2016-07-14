//
//  SCYandexDiskFolder.m
//  SCYandexDisk
//
//  Created by Maxim Kolesnik on 13.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCYandexDiskFolder.h"

NSString *const dir = @"dir";

NSString *const kSCYandexDiskFolderPath = @"path";
NSString *const kSCYandexDiskFolderCreated = @"created";
NSString *const kSCYandexDiskFolderType = @"type";
NSString *const kSCYandexDiskFolderName = @"name";
NSString *const kSCYandexDiskFolderModified = @"modified";

@interface SCYandexDiskFolder ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SCYandexDiskFolder

@synthesize path = _path;
@synthesize created = _created;
@synthesize type = _type;
@synthesize name = _name;
@synthesize modified = _modified;

+ (instancetype)folderFromDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.path = [self objectOrNilForKey:kSCYandexDiskFolderPath fromDictionary:dict];
        self.created = [self objectOrNilForKey:kSCYandexDiskFolderCreated fromDictionary:dict];
        self.type = [self objectOrNilForKey:kSCYandexDiskFolderType fromDictionary:dict];
        self.name = [self objectOrNilForKey:kSCYandexDiskFolderName fromDictionary:dict];
        self.modified = [self objectOrNilForKey:kSCYandexDiskFolderModified fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.path forKey:kSCYandexDiskFolderPath];
    [mutableDict setValue:self.created forKey:kSCYandexDiskFolderCreated];
    [mutableDict setValue:self.type forKey:kSCYandexDiskFolderType];
    [mutableDict setValue:self.name forKey:kSCYandexDiskFolderName];
    [mutableDict setValue:self.modified forKey:kSCYandexDiskFolderModified];
    
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
    
    self.path = [aDecoder decodeObjectForKey:kSCYandexDiskFolderPath];
    self.created = [aDecoder decodeObjectForKey:kSCYandexDiskFolderCreated];
    self.type = [aDecoder decodeObjectForKey:kSCYandexDiskFolderType];
    self.name = [aDecoder decodeObjectForKey:kSCYandexDiskFolderName];
    self.modified = [aDecoder decodeObjectForKey:kSCYandexDiskFolderModified];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_path forKey:kSCYandexDiskFolderPath];
    [aCoder encodeObject:_created forKey:kSCYandexDiskFolderCreated];
    [aCoder encodeObject:_type forKey:kSCYandexDiskFolderType];
    [aCoder encodeObject:_name forKey:kSCYandexDiskFolderName];
    [aCoder encodeObject:_modified forKey:kSCYandexDiskFolderModified];
}

- (id)copyWithZone:(NSZone *)zone{
    SCYandexDiskFolder *copy = [[SCYandexDiskFolder alloc] init];
    
    if (copy) {
        
        copy.path = [self.path copyWithZone:zone];
        copy.created = [self.created copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.modified = [self.modified copyWithZone:zone];
    }
    
    return copy;
}


@end

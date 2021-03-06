//
//  SDCachedURLResponse.m
//  SDURLCache
//
//  Created by Olivier Poitrey on 12/05/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SDCachedURLResponse.h"

@implementation SDCachedURLResponse

@synthesize response;

+ (id)cachedURLResponseWithNSCachedURLResponse:(NSCachedURLResponse *)response
{
    SDCachedURLResponse *wrappedResponse = [[SDCachedURLResponse alloc] init];
    wrappedResponse.response = response;
    return wrappedResponse;
}

#pragma mark NSCopying Methods

- (id)copyWithZone:(NSZone *)zone
{
    SDCachedURLResponse *newResponse = [[[self class] allocWithZone:zone] init];

    if (newResponse)
    {
        newResponse.response = [self.response copyWithZone:zone] ;
    }

    return newResponse;
}

#pragma mark NSCoding Methods
- (void)encodeWithCoder:(NSCoder *)coder
{
    // force write the data of underlying cached response
    [coder encodeDataObject:self.response.data];
    [coder encodeObject:self.response.response forKey:@"response"];
    [coder encodeObject:self.response.userInfo forKey:@"userInfo"];
    [coder encodeInt:self.response.storagePolicy forKey:@"storagePolicy"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ((self = [super init]))
    {
        self.response = [[NSCachedURLResponse alloc] initWithResponse:[coder decodeObjectForKey:@"response"]
                                                                  data:[coder decodeDataObject]
                                                              userInfo:[coder decodeObjectForKey:@"userInfo"]
                                                         storagePolicy:[coder decodeIntForKey:@"storagePolicy"]];
    }

    return self;
}

- (void)dealloc
{
    response = nil;
}

@end

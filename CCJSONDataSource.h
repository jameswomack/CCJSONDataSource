//
//  CCJSONDataSource.h
//
//  Created by James on 3/1/11.
//  Copyright 2011 Cirrostratus Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface CCJSONDataSource : NSObject {
    
}

- (id)jsonObjectWithUrlString:(NSString *)theUrlString;
- (id)jsonObjectWithJSONString:(NSString *)theJSONString;
- (id)jsonObjectWithData:(NSData *)theData;
- (NSArray *)arrayFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey;
- (NSArray *)arrayFromURLString:(NSString *)theString;
- (NSDictionary *)dictionaryFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey;
- (NSDictionary *)dictionaryFromURLString:(NSString *)theString;
- (NSString *)stringFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey;

- (id)jsonObjectWithUrl:(NSURL *)theUrl;
- (NSArray *)arrayFromURL:(NSURL *)theURL;
- (NSArray *)arrayFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey;
- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL;
- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey;
- (NSString *)stringFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey;

+ (BOOL)isSiteReachable:(const char*)siteURLString;

@end

//
//  CCJSONDataSource.h
//
//  Created by James on 3/1/11.
//  Copyright 2011 Cirrostratus Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCJSONDataSource : NSObject

- (id)jsonObjectWithUrlString:(NSString *)theUrlString;
- (id)jsonObjectWithUrl:(NSURL *)theUrl;
- (id)jsonObjectWithJSONString:(NSString *)theJSONString;
- (id)jsonObjectWithData:(NSData *)theData;

- (NSDictionary *)dictionaryFromURLString:(NSString *)theString 
                         andDictionaryKey:(NSString *)theKey;
- (NSDictionary *)dictionaryFromURLString:(NSString *)theString;
- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL;
- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL 
                   andDictionaryKey:(NSString *)theKey;

- (NSArray *)arrayFromURLString:(NSString *)theString 
               andDictionaryKey:(NSString *)theKey;
- (NSArray *)arrayFromURLString:(NSString *)theString;
- (NSArray *)arrayFromURL:(NSURL *)theURL;
- (NSArray *)arrayFromURL:(NSURL *)theURL 
         andDictionaryKey:(NSString *)theKey;

- (NSString *)stringFromURL:(NSURL *)theURL 
           andDictionaryKey:(NSString *)theKey;
- (NSString *)stringFromURLString:(NSString *)theString 
                 andDictionaryKey:(NSString *)theKey;

+ (BOOL)isSiteReachable:(const char*)siteURLString;

@end

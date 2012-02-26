//
//  CCJSONDataSource.m
//
//  Created by James on 3/1/11.
//  Copyright 2011 Cirrostratus Co. All rights reserved.
//

#import "CCJSONDataSource.h"

#import <sys/utsname.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "JSONKit.h"
#import "Reachability.h"
#import "NSString+CCAdditions.h"
#import "NSObject+Debugging.h"


#ifndef __has_feature
    #define __has_feature(x) 0
#endif

#ifdef __OBJC_GC__
    #error CCJSONDataSource does not support Objective-C Garbage Collection
#endif

#if __has_feature(objc_arc)
    #error CCJSONDataSource does not support Objective-C Automatic Reference Counting (ARC)
#endif


@implementation CCJSONDataSource


+ (BOOL)isSiteReachable:(const char*)host_name; 
{
	BOOL _isDataSourceAvailable;
	Boolean success;    
	
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
	SCNetworkReachabilityFlags flags;
	success = SCNetworkReachabilityGetFlags(reachability, &flags);
	_isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
	CFRelease(reachability); 

    return _isDataSourceAvailable;
}

- (id)jsonObjectWithUrlString:(NSString *)theUrlString; 
{
    NSParameterAssert(ValidString(theUrlString));
	return [self jsonObjectWithUrl:[NSURL URLWithString:theUrlString]];
}

- (id)jsonObjectWithUrl:(NSURL *)url; 
{	
    NSParameterAssert(ValidURL(url));
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setTimeoutInterval:20];
	[request setURL:url];
	[request setHTTPMethod:@"GET"];
	
	NSError *error = nil;
	
	NSData *returnData2 = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: &error ];	
    
	if (returnData2)
		return [self jsonObjectWithData:returnData2];
	else if (error)
        NSLog(@"%@",error);
	
	return nil;
}

- (id)jsonObjectWithData:(NSData *)theData; 
{
    NSParameterAssert(ValidObj(theData));
    if ([theData length]) 
    {
        JSONDecoder *decoder = [JSONDecoder decoder];
		NSError *error2 = nil;
		id anObject = nil;
        
        anObject = [decoder 
                    objectWithUTF8String:(const unsigned char *)[theData bytes] 
                    length:[theData length]];
		
		if(!error2) 
			return anObject;
		else
        {
            NSLog(@"Error parsing search results: %@", error2);
            NSLog(@"Data: %@", theData); 
        }        
	}
	return nil;
}



- (id)jsonObjectWithJSONString:(NSString *)theJSONString 
{
    BOOL isValid = ValidString(theJSONString);
    if (!isValid) 
    {
        
        NSLog(@"Non-string passed: %@ : %@", theJSONString,  [theJSONString class]);
    }
	if (theJSONString) 
    {
		NSError *error2 = nil;
		id anObject = nil;
        
        anObject = [theJSONString 
                    objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode 
                    error:&error2];
		
		if( !error2)        
			return anObject;
        
        NSLog(@"Error parsing search results: %@", error2);
        NSLog(@"Data: %@", theJSONString);
	}
	return nil;
}

- (NSArray *)arrayFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey; 
{
    NSParameterAssert(ValidString(theString) && ValidString(theKey));
	return [self arrayFromURL:[NSURL URLWithString:theString] andDictionaryKey:theKey];
}

- (NSArray *)arrayFromURLString:(NSString *)theString; 
{
    NSParameterAssert(ValidString(theString));
	return [self arrayFromURL:[NSURL URLWithString:theString]];
}

- (NSArray *)arrayFromURL:(NSURL *)theURL; 
{
    NSParameterAssert(ValidURL(theURL));
	NSArray *array = [self jsonObjectWithUrl:theURL];
    
	if (ValidArray(array))
        return array;
    
	return nil;
}

- (NSArray *)arrayFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey; 
{
    NSParameterAssert(ValidURL(theURL) && ValidString(theKey));
	NSDictionary *dictionary = [self jsonObjectWithUrl:theURL];
	if (dictionary && [[dictionary allKeys] count]) 
    {
		if (ValidArray([dictionary objectForKey:theKey]))
			return [dictionary objectForKey:theKey];
		else
			NSLog(@"Dictionary key is not array or is empty: %@",dictionary);
	}
	return nil;
}

- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey; 
{
    NSParameterAssert(ValidURL(theURL) && ValidString(theKey));
	NSDictionary *dictionary = [self dictionaryFromURL:theURL];
    if (dictionary)
        return [dictionary objectForKey:theKey];
	return nil;
}

- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL; 
{
    NSParameterAssert(ValidURL(theURL));
	NSDictionary *dictionary = [self jsonObjectWithUrl:theURL];
	if (ValidDict(dictionary))
		return dictionary;
	else
		NSLog(@"Error: %@",dictionary);
	return nil;
}

- (NSDictionary *)dictionaryFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey; 
{
    NSParameterAssert(ValidString(theString) && ValidString(theKey));
	return [self dictionaryFromURL:[NSURL URLWithString:theString] andDictionaryKey:theKey];
}

- (NSDictionary *)dictionaryFromURLString:(NSString *)theString; 
{
    NSParameterAssert(ValidString(theString));
	return [self dictionaryFromURL:[NSURL URLWithString:theString]];
}

- (NSString *)stringFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey; 
{
    NSParameterAssert(ValidURL(theURL) && ValidString(theKey));
	NSDictionary *dictionary = [self dictionaryFromURL:theURL];
    if (KeyIsValidForClass(dictionary,theKey,[NSString class]))
        return [dictionary objectForKey:theKey];
	return nil;
}


- (NSString *)stringFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey; 
{
    NSParameterAssert(ValidString(theString) && ValidString(theKey));
	return [self stringFromURL:[NSURL URLWithString:theString] andDictionaryKey:theKey];
}

@end

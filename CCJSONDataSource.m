//
//  CCJSONDataSource.m
//
//  Created by James on 3/1/11.
//  Copyright 2011 Cirrostratus Co. All rights reserved.
//

#import <sys/utsname.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "CCJSONDataSource.h"
#import "JSONKit.h"
#import "Stopwatch.h"


@implementation CCJSONDataSource


+ (BOOL)isSiteReachable:(const char*)host_name; {
	static BOOL checkNetwork = YES;
    static BOOL _isDataSourceAvailable = NO;
	if (checkNetwork) {
        checkNetwork = NO;
        
        Boolean success;    
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
		SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
		CFRelease(reachability); 
    }
    return _isDataSourceAvailable;
}

- (id)jsonObjectWithUrl:(NSURL *)url; {
    NSError *error = nil;
    NSData *theData = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
	if (theData) {
		return [self jsonObjectWithData:theData];
	}else {
		ILogPlus(@"%@",error);
	}
	return nil;
}


- (id)jsonObjectWithUrlString:(NSString *)theUrlString; {
	return [self jsonObjectWithUrl:[NSURL URLWithString:theUrlString]];
}


- (NSArray *)arrayFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey; {
	return [self arrayFromURL:[NSURL URLWithString:theString] andDictionaryKey:theKey];
}

- (NSArray *)arrayFromURLString:(NSString *)theString; {
	return [self arrayFromURL:[NSURL URLWithString:theString]];
}


- (NSDictionary *)dictionaryFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey; {
	return [self dictionaryFromURL:[NSURL URLWithString:theString] andDictionaryKey:theKey];
}

- (NSDictionary *)dictionaryFromURLString:(NSString *)theString; {
	return [self dictionaryFromURL:[NSURL URLWithString:theString]];
}


- (NSString *)stringFromURLString:(NSString *)theString andDictionaryKey:(NSString *)theKey; {
	return [self stringFromURLString:[NSURL URLWithString:theString] andDictionaryKey:theKey];
}


- (id)jsonObjectWithData:(NSData *)theData; {
    
    JSONDecoder *decoder = [[JSONDecoder allocWithZone:NULL] init];
    if ([theData length]) {
		NSError *error2 = nil;
		id anObject = nil;
		@try {
			anObject = [decoder objectWithUTF8String:(const unsigned char *)[theData bytes] length:[theData length]];
		}
		@catch (NSException * e) {
			ILogPlus(@"Exception: %@", e);
		}
		
		if( !error2) {
            
            [decoder release];
			return anObject;
		} else {
			[decoder release];
			ILogPlus(@"Error parsing search results: %@", error2);
			ILogPlus(@"Data: %@", theData);
            
            
			return nil;
		}
	}
    
    [decoder release];
	return nil;
}


- (id)jsonObjectWithJSONString:(NSString *)theJSONString {
    
	if (theJSONString) {
		NSError *error2 = nil;
		id anObject = nil;
		@try {
			anObject = [theJSONString objectFromJSONString];
		}
		@catch (NSException * e) {
			ILogPlus(@"Exception: %@", e);
		}
		
		if( !error2) {
            
            
			return anObject;
		} else {
			ILogPlus(@"Error parsing search results: %@", error2);
			ILogPlus(@"Data: %@", theJSONString);
            
            
			return nil;
		}
	}
	return nil;
}

- (NSArray *)arrayFromURL:(NSURL *)theURL; {
	NSArray *array = nil;
	array = [self jsonObjectWithUrl:theURL];
	if (array && [array count]) {
		if ([array count] > 0) {
			//ILogPlus(@"%@",array);
			return array;
		}else {
			return nil;
		}
	}
	return nil;
}

- (NSArray *)arrayFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey; {
	NSDictionary *dictionary = nil;
	dictionary = [self jsonObjectWithUrl:theURL];
	if (dictionary && [[dictionary allKeys] count]) {
		if ([[dictionary objectForKey:theKey] count] > 0) {
			return [dictionary objectForKey:theKey];
		}else {
			ILogPlus(@"%@",dictionary);
			return nil;
		}
	}
	return nil;
}

- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey; {
	NSDictionary *dictionary = nil;
	dictionary = [self jsonObjectWithUrl:theURL];
	if (dictionary && [[dictionary allKeys] count]) {
		if ([[dictionary objectForKey:theKey] count] > 0) {
			return [dictionary objectForKey:theKey];
		}else {
			ILogPlus(@"%@",dictionary);
			return nil;
		}
	}
	return nil;
}

- (NSDictionary *)dictionaryFromURL:(NSURL *)theURL; {
	NSDictionary *dictionary = nil;
	dictionary = [[self jsonObjectWithUrl:theURL] copy];
	if (dictionary && [[dictionary allKeys] count]) {
		return [dictionary autorelease];
	}else {
		ILogPlus(@"Error: %@",[dictionary autorelease]);
		return nil;
	}
	return nil;
}

- (NSString *)stringFromURL:(NSURL *)theURL andDictionaryKey:(NSString *)theKey; {
	NSDictionary *dictionary = nil;
	dictionary = [self jsonObjectWithUrl:theURL];
	if (dictionary && [[dictionary allKeys] count]) {
		if ([dictionary objectForKey:theKey]) {
			return [dictionary objectForKey:theKey];
		}else {
			return nil;
		}
	}
	return nil;
}

@end
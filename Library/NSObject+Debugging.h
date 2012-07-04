//
//  NSObject+Debugging.h
//
//  Created by James Womack on 1/1/12.
//  Copyright (c) 2012 Cirrostratus Design Company. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NGTryAssign(anObject,aValue) @try \
{\
anObject = aValue;\
}\
@catch (NSException * e) \
{\
ALog(@"Exception: %@", e);\
}\

#define ValidObj(obj) (obj && (id)obj != [NSNull null])

#define ValidImg(img) (ValidObj(img) && [img isKindOfClass:[UIImage class]]) 

#define ValidDict(dictionary) (ValidObj(dictionary) && [dictionary isKindOfClass:[NSDictionary class]])

#define ValidData(data) (ValidObj(data) && [data isKindOfClass:[NSData class]] && data.length)

#define ValidArray(array) (ValidObj(array) && [array isKindOfClass:[NSArray class]])

#define ValidURL(url) (ValidObj(url) && [url isKindOfClass:[NSURL class]] && [url scheme])

#define ValidString(string) (ValidObj(string) && [string isKindOfClass:[NSString class]] && [string length])

#define KeyIsValidForClass(dict,key,class) (ValidObj(dict) && [[dictionary objectForKey:key] isKindOfClass:class])

@interface NSObject (Debugging)

- (void)log:(id)anObject;
- (void)logInProduction:(id)anObject;
- (void)performSelectorIfDebugging:(SEL)aSelector;
- (void)performSelectorIfDebugging:(SEL)aSelector withObject:(id)arg;
- (void)performSelectorSafely:(SEL)aSelector withObject:(id)arg;
void Swizzle(Class c, Class c2, SEL orig, SEL new);

@end

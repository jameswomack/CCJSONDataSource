//
//  NSObject+Debugging.m
//  DoubleStamp
//
//  Created by James Womack on 1/1/12.
//  Copyright (c) 2012 Cirrostratus Design Company. All rights reserved.
//

#import "NSObject+Debugging.h"

@implementation NSObject (Debugging)

- (void)performSelectorIfDebugging:(SEL)aSelector;
{
#ifdef DEBUG
    [self performSelector:aSelector];
#endif
}

- (void)performSelectorIfDebugging:(SEL)aSelector withObject:(id)arg
{
#ifdef DEBUG
    [self performSelector:aSelector withObject:arg];
#endif   
}


- (void)performSelectorSafely:(SEL)aSelector withObject:(id)arg;
{
    if ([self respondsToSelector:aSelector]) 
        (arg)?[self performSelector:aSelector withObject:arg]:[self performSelector:aSelector];
    else
        [self logInProduction:[NSString stringWithFormat:@"%@ didn't respond to selector: %@",self,NSStringFromSelector(aSelector)]];
}

- (void)log:(id)anObject;
{
    NSLog(@"%@", anObject);
}

- (void)logInProduction:(id)anObject;
{
    NSLog(@"%@", anObject);
}

@end

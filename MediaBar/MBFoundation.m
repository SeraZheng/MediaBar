//
//  MBFoundation.m
//  MediaBarDemo
//
//  Created by bv-zheng on 7/13/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import "MBFoundation.h"

@implementation MBFoundation

BOOL isIPAD(){
    
    static BOOL cached = NO;
    static BOOL isIPAD_cache;
    
    if (cached == NO) {
        cached = YES;
        if ([[[UIDevice currentDevice] model] hasPrefix:@"iPad"]) {
            isIPAD_cache = YES;
            
        }else
            isIPAD_cache = NO;
        
        return isIPAD_cache;
    }else
        return isIPAD_cache;
    
}

BOOL isIPHONE(){
    if ([[[UIDevice currentDevice] model] hasPrefix:@"iPhone"]) {
        return YES;
    }else
        return NO;
}

CGFloat screenHeight(){
    
    CGFloat sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (isIPAD() && sysVer < 8.0) {
        //UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            return [[UIScreen mainScreen] bounds].size.height;
        }
        else if(UIInterfaceOrientationIsLandscape(orientation)) {
            return [[UIScreen mainScreen] bounds].size.width;
        }
    }
    
    return [[UIScreen mainScreen] bounds].size.height;
    
}

CGFloat screenWidth(){
    
    CGFloat sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (isIPAD() && sysVer < 8.0) {
        //UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            return [[UIScreen mainScreen] bounds].size.width;
        }
        else if(UIInterfaceOrientationIsLandscape(orientation)) {
            return [[UIScreen mainScreen] bounds].size.height;
        }
    }
    
    return [[UIScreen mainScreen] bounds].size.width;
    
}


@end

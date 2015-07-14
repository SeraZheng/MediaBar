//
//  ViewController.h
//  MediaBarDemo
//
//  Created by bv-zheng on 7/13/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaBar.h"
#import "MBFoundation.h"

@interface MBDemoViewController : UIViewController <AssetsDelegate>

@property (nonatomic, retain) MediaBar* mediaBar;

@end


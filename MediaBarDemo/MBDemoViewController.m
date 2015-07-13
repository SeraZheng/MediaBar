//
//  ViewController.m
//  MediaBarDemo
//
//  Created by bv-zheng on 7/13/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import "MBDemoViewController.h"

#define BAR_HEIGHT 44

@interface MBDemoViewController ()

@end

@implementation MBDemoViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor grayColor];
    self.mediaBar.frame = CGRectMake(0, screenHeight()-BAR_HEIGHT, screenWidth(), BAR_HEIGHT);
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MediaBar *)mediaBar
{
    if (!_mediaBar) {
        _mediaBar = [[MediaBar alloc] initWithFrame:CGRectZero];
        _mediaBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_mediaBar setBackgroundColor:[UIColor blueColor]];
        
        [self.view addSubview:_mediaBar];
    }
    return _mediaBar;
}

@end

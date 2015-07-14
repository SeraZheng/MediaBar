//
//  ViewController.m
//  MediaBarDemo
//
//  Created by bv-zheng on 7/13/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import "MBDemoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define BAR_HEIGHT 44
#define IMAGEVIEW_HEIGTH 200
#define SELECT_LIMIT 1

@interface MBDemoViewController ()

@property (nonatomic, retain) UIImageView* imageView;

@end

@implementation MBDemoViewController

- (void)viewDidLoad {
    
    self.mediaBar.frame = CGRectMake(0, screenHeight()-BAR_HEIGHT, screenWidth(), BAR_HEIGHT);
    [_mediaBar setImageButtonEnabled:YES];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BAR_HEIGHT, screenWidth(), IMAGEVIEW_HEIGTH)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_imageView];
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
        _mediaBar = [[MediaBar alloc] initWithController:self];
        _mediaBar.assetsDelegate = self;
        _mediaBar.showsNumberOfAssets = YES;
        _mediaBar.showsCancelButton = YES;
        _mediaBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self.view addSubview:_mediaBar];
    }
    return _mediaBar;
}

#pragma mark -
#pragma mark - AssetsDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* originalImage = (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage];
    [_imageView setImage:originalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    ALAsset* asset = [assets lastObject];
    [_imageView setImage:[UIImage imageWithCGImage:asset.thumbnail scale:1.0 orientation:UIImageOrientationUp]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (picker.selectedAssets.count == SELECT_LIMIT) {
        [[[UIAlertView alloc] initWithTitle:@"Deny Select" message:[NSString stringWithFormat:@"You can choose %d items most",SELECT_LIMIT] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return NO;
    }
    return YES;
}

@end

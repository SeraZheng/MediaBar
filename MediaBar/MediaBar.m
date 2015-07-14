//
//  MediaBar.m
//  MediaBarDemo
//
//  Created by bv-zheng on 7/13/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import "MediaBar.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>

#define BARBUTTON_IMG_WIDTH                 24
#define BARBUTTON_IMG_HEIGHT                24

@interface MediaBar () <CTAssetsPickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UIViewController* myController;
@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation MediaBar

- (instancetype)initWithController:(UIViewController *)viewController
{
    if (self = [super init]) {
        _myController = viewController;
    }
    
    return self;
}

#pragma makr -
#pragma mark - Override

- (void)setImageButtonEnabled:(BOOL)imageButtonEnabled
{
    _imageButtonEnabled = imageButtonEnabled;
    if (imageButtonEnabled) {
        UIBarButtonItem* fleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [self setItems:@[fleItem,self.imageButton] animated:imageButtonEnabled];
    }
}

#pragma mark -
#pragma mark - UIBarButtonItem

- (CGFloat)barWidth
{
    if (!_barWidth) {
        _barWidth = self.bounds.size.width;
    }
    return _barWidth;
}

- (CGFloat)barHeight
{
    if (!_barHeight) {
        _barHeight = self.bounds.size.height;
    }
    return _barHeight;
}

- (UIBarButtonItem *)imageButton
{
    if (!_imageButton) {
        UIButton* imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(0, 0, self.barHeight, self.barHeight);
        imageBtn.imageEdgeInsets = self.edgeInsets;
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        imageBtn.showsTouchWhenHighlighted = YES;
        [imageBtn addTarget:self action:@selector(imageButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        _imageButton = [[UIBarButtonItem alloc] initWithCustomView:imageBtn];
    }
    
    return _imageButton;
}

- (UIEdgeInsets)edgeInsets
{
    _edgeInsets = UIEdgeInsetsMake((self.barHeight - BARBUTTON_IMG_WIDTH)/2, (self.barHeight - BARBUTTON_IMG_HEIGHT)/2, (self.barHeight - BARBUTTON_IMG_HEIGHT)/2, (self.barHeight - BARBUTTON_IMG_WIDTH)/2);
    return _edgeInsets;
}

#pragma mark -
#pragma mark - Private

- (void)imageButtonTouch
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:MBLog(@"From Camera", @"")];
    }
    [actionSheet addButtonWithTitle:MBLog(@"From Library", @"")];
    [actionSheet addButtonWithTitle:MBLog(@"Cancel", @"")];
    actionSheet.cancelButtonIndex = [actionSheet numberOfButtons] - 1;
    [actionSheet showInView:self.myController.view];
}

#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:MBLog(@"From Camera", @"")]) {
        UIImagePickerController* pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        pickerController.delegate = self;
        
        [self.myController presentViewController:pickerController animated:YES completion:nil];
    }else if ([title isEqualToString:MBLog(@"From Library", @"")]){
        CTAssetsPickerController* pickerController = [[CTAssetsPickerController alloc] init];
        pickerController.assetsFilter = [ALAssetsFilter allAssets];
        pickerController.showsCancelButton = self.showsCancelButton;
        pickerController.showsNumberOfAssets = self.showsNumberOfAssets;
        pickerController.alwaysEnableDoneButton = self.alwaysEnableDoneButton;
        pickerController.delegate = self;
        
        [self.myController presentViewController:pickerController animated:YES completion:nil];
    }

}

#pragma mark -
#pragma makr - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
        [_assetsDelegate imagePickerController:picker didFinishPickingMediaWithInfo:info];
    }
}

#pragma mark -
#pragma makr - CTAssetsPickerControllerDelegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:didFinishPickingAssets:)]) {
        [_assetsDelegate assetsPickerController:picker didFinishPickingAssets:assets];
    }
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerControllerDidCancel:)]) {
        [_assetsDelegate assetsPickerControllerDidCancel:picker];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldShowAssetsGroup:(ALAssetsGroup *)group
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:shouldShowAssetsGroup:)]) {
        return [_assetsDelegate assetsPickerController:picker shouldShowAssetsGroup:group];
    }
    return YES;
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:isDefaultAssetsGroup:)]) {
        return [_assetsDelegate assetsPickerController:picker isDefaultAssetsGroup:group];
    }
    return NO;
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldShowAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:shouldShowAsset:)]) {
        return [_assetsDelegate assetsPickerController:picker shouldShowAsset:asset];
    }
    return YES;
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:shouldEnableAsset:)]) {
        return [_assetsDelegate assetsPickerController:picker shouldEnableAsset:asset];
    }
    return YES;
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:shouldSelectAsset:)]) {
        return [_assetsDelegate assetsPickerController:picker shouldSelectAsset:asset];
    }
    return YES;
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didSelectAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:didSelectAsset:)]) {
        [_assetsDelegate assetsPickerController:picker didSelectAsset:asset];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldDeselectAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:shouldDeselectAsset:)]) {
        return [_assetsDelegate assetsPickerController:picker shouldDeselectAsset:asset];
    }
    return YES;
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didDeselectAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:didDeselectAsset:)]) {
        [_assetsDelegate assetsPickerController:picker didDeselectAsset:asset];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldHighlightAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:shouldHighlightAsset:)]) {
        return [_assetsDelegate assetsPickerController:picker shouldHighlightAsset:asset];
    }
    return YES;
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didHighlightAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:didHighlightAsset:)]) {
        [_assetsDelegate assetsPickerController:picker didHighlightAsset:asset];
    }
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didUnhighlightAsset:(ALAsset *)asset
{
    if (_assetsDelegate && [_assetsDelegate respondsToSelector:@selector(assetsPickerController:didUnhighlightAsset:)]) {
        [_assetsDelegate assetsPickerController:picker didUnhighlightAsset:asset];
    }
}

@end

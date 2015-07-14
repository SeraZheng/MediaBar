//
//  MediaBar.h
//  MediaBarDemo
//
//  Created by bv-zheng on 7/13/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsDelegate.h"

#define MBLog(_text, _comment)	NSLocalizedString(_text, _comment)

@interface MediaBar : UIToolbar 

/**
 * Decide to display imageButton,Default is NO
 */
@property (nonatomic, assign) BOOL imageButtonEnabled;

/**
 * One button for select image or video from local
 */
@property (nonatomic, retain) UIBarButtonItem* imageButton;

/**
 * Delegate coordinate with CTAssetsPickerControllerDelegate
 */
@property (nonatomic, retain) id<AssetsDelegate> assetsDelegate;

/**
 *  Determines whether or not the cancel button is visible in the picker.
 *
 *  The cancel button is visible by default. To hide the cancel button, (e.g. presenting the picker in `UIPopoverController`)
 *  set this property’s value to `NO`.
 */
@property (nonatomic, assign) BOOL showsCancelButton;

/**
 *  Determines whether or not the number of assets is shown in the album list.
 *
 *  The number of assets is visible by default. To hide the number of assets, (e.g. implementing `shouldShowAsset` delegate method)
 *  set this property’s value to `NO`.
 */
@property (nonatomic, assign) BOOL showsNumberOfAssets;

/**
 *  Determines whether or not the done button is always enabled.
 *
 *  The done button is enabled only when assets are selected. To enable the done button even without assets selected,
 *  set this property’s value to `YES`.
 */
@property (nonatomic, assign) BOOL alwaysEnableDoneButton;


/**
 * Initialize mediaBar with UIViewController
 * @param viewController assign private property "myController" with UIViewController
 */

- (instancetype)initWithController:(UIViewController*)viewController;


@end

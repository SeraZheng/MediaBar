//
//  AssetsDelegate.h
//  MediaBarDemo
//
//  Created by bv-zheng on 7/14/15.
//  Copyright (c) 2015 bvzheng. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <CTAssetsPickerController.h>

@protocol AssetsDelegate <NSObject>

/**
 *  @name Closing the Picker
 */

/**
 *  Tells the delegate that the user finish picking photos or videos from library.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param assets An array containing picked `ALAsset` objects.
 *
 *  @see assetsPickerControllerDidCancel:
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;

/**
 *  @name Closing the Picker
 */

/**
 *  Tells the delegate that the user finish capture photos or videos from camera.
 *
 *  @param picker The controller object managing the camera interface.
 *  @param info An dictionary containing capture infomation.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

@optional

/**
 *  Tells the delegate that the user cancelled the pick operation.
 *
 *  @param picker The controller object managing the assets picker interface.
 *
 *  @see assetsPickerController:didFinishPickingAssets:
 */
- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker;


/**
 *  @name Enabling Assets Group
 */

/**
 *  Ask the delegate if the specified assets group should be shown.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param group  The assets group to be shown.
 *
 *  @return `YES` if the assets group should be shown or `NO` if it should not.
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldShowAssetsGroup:(ALAssetsGroup *)group;


/**
 *  @name Showing Content of Default Assets Group
 */

/**
 *  Ask the delegate if the specified assets group is the default assets group.
 *
 *  The picker initially shows the content of default assets group instead of a list of albums. By default,
 *  there are no default assets groups.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param group  The assets group to be process.
 *
 *  @return `YES` if the assets group is the default assets group or `NO` if it is not.
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group;


/**
 *  @name Enabling Assets
 */

/**
 *  Ask the delegate if the specified asset shoule be shown.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset to be shown.
 *
 *  @return `YES` if the asset should be shown or `NO` if it should not.
 *
 *  @see [assetsFilter]([CTAssetsPickerController assetsFilter])
 *  @see assetsPickerController:shouldEnableAsset:
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldShowAsset:(ALAsset *)asset;

/**
 *  Ask the delegate if the specified asset should be enabled for selection.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset to be enabled.
 *
 *  @return `YES` if the asset should be enabled or `NO` if it should not.
 *
 *  @see [assetsFilter]([CTAssetsPickerController assetsFilter])
 *  @see assetsPickerController:shouldShowAsset:
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset;


/**
 *  @name Managing the Selected Assets
 */

/**
 *  Asks the delegate if the specified asset should be selected.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset to be selected.
 *
 *  @return `YES` if the asset should be selected or `NO` if it should not.
 *
 *  @see assetsPickerController:shouldDeselectAsset:
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset;

/**
 *  Tells the delegate that the asset was selected.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset that was selected.
 *
 *  @see assetsPickerController:didDeselectAsset:
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didSelectAsset:(ALAsset *)asset;

/**
 *  Asks the delegate if the specified asset should be deselected.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset to be deselected.
 *
 *  @return `YES` if the asset should be deselected or `NO` if it should not.
 *
 *  @see assetsPickerController:shouldSelectAsset:
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldDeselectAsset:(ALAsset *)asset;

/**
 *  Tells the delegate that the item at the specified path was deselected.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset that was deselected.
 *
 *  @see assetsPickerController:didSelectAsset:
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didDeselectAsset:(ALAsset *)asset;



/**
 *  @name Managing Asset Highlighting
 */

/**
 *  Asks the delegate if the specified asset should be highlighted.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset to be highlighted.
 *
 *  @return `YES` if the asset should be highlighted or `NO` if it should not.
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldHighlightAsset:(ALAsset *)asset;

/**
 *  Tells the delegate that asset was highlighted.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset that was highlighted.
 *
 *  @see assetsPickerController:didUnhighlightAsset:
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didHighlightAsset:(ALAsset *)asset;


/**
 *  Tells the delegate that the highlight was removed from the asset.
 *
 *  @param picker The controller object managing the assets picker interface.
 *  @param asset  The asset that had its highlight removed.
 *
 *  @see assetsPickerController:didHighlightAsset:
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didUnhighlightAsset:(ALAsset *)asset;

@end

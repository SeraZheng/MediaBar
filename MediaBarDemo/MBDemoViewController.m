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
#define IMAGEVIEW_HEIGTH 300
#define SELECT_LIMIT 1
#define CHAT_BOX_PADDING                    7
#define CHAT_BOX_WIDTH_SMALL                184
#define CHAT_BOX_WIDTH                      230

@interface MBDemoViewController ()

@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UITextView* textView;

@end

@implementation MBDemoViewController

- (void)viewDidLoad {
        [super viewDidLoad];
    _mediaBar = [[MediaBar alloc] initWithController:self withFrame:CGRectMake(0, screenHeight()-BAR_HEIGHT, screenWidth(), BAR_HEIGHT)];
    [_mediaBar setBackgroundColor:[UIColor blackColor]];
    _mediaBar.richTextEditor.frame = CGRectMake(CHAT_BOX_PADDING,CHAT_BOX_PADDING,CHAT_BOX_WIDTH_SMALL,50 - CHAT_BOX_PADDING * 2);
            _mediaBar.richTextEditor.defaultFontFamily = [UIFont systemFontOfSize:14].familyName;
            _mediaBar.richTextEditor.maxImageDisplaySize = CGSizeMake(200,200);
            _mediaBar.richTextEditor.autocapitalizationType = UITextAutocapitalizationTypeSentences;
            _mediaBar.richTextEditor.spellCheckingType = UITextSpellCheckingTypeYes;
            _mediaBar.richTextEditor.returnKeyType = UIReturnKeySend;
            _mediaBar.richTextEditor.contentInset = UIEdgeInsetsZero;
            _mediaBar.richTextEditor.enablesReturnKeyAutomatically = NO;
            _mediaBar.richTextEditor.layer.cornerRadius = 3.0;
            _mediaBar.richTextEditor.layer.masksToBounds = YES;
            [_mediaBar.richTextEditor setEditorViewDelegate:self];
            [_mediaBar.richTextEditor setTextDefaults:({
                NSMutableDictionary *defaults = [[_mediaBar.richTextEditor textDefaults] mutableCopy];
                [defaults setObject:@YES forKey:DTProcessCustomHTMLAttributes];
                [defaults setObject:@NO forKey:DTDefaultLinkDecoration];
                [defaults setObject:@"lightblue" forKey:DTDefaultLinkColor];
                [defaults setObject:@"red" forKey:DTDefaultLinkHighlightColor];
                [defaults setObject:[UIFont systemFontOfSize:15].familyName forKey:DTDefaultFontFamily];
                [defaults setObject:[NSValue valueWithCGSize:(CGSize) {.width = 180.f, .height = 220.f}] forKey:DTMaxImageSize];
                
                defaults;
            })];
    [_mediaBar setImageButtonEnabled:YES];
    _mediaBar.assetsDelegate = self;
    _mediaBar.showsNumberOfAssets = YES;
    _mediaBar.showsCancelButton = YES;
     _mediaBar.textViewItem.width = _mediaBar.barWidth - 2*BAR_HEIGHT;
    [_mediaBar show];
    _mediaBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_mediaBar];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BAR_HEIGHT, screenWidth(), IMAGEVIEW_HEIGTH)];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = [UIImage imageNamed:@"camera.png"];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_imageView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x, _imageView.bounds.size.height + 10, screenWidth(), screenHeight() - _imageView.bounds.size.height - 10 - _mediaBar.barHeight)];
    _textView.text = MBLog(@"Display input text here",@"");
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_textView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [nc addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [nc addObserver:self selector:@selector(handleKeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.mediaBar.richTextEditor resignFirstResponder];
}

- (void)adjustViewForKeyboardNotification:(NSNotification *)notification andKeyboard:(BOOL)showKeyboard
{
    NSDictionary *notificationInfo = [notification userInfo];
    
    // Get the end frame of the keyboard in screen coordinates.
    CGRect finalKeyboardFrame = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Convert the finalKeyboardFrame to view coordinates to take into account any rotation
    // factors applied to the window’s contents as a result of interface orientation changes.
    finalKeyboardFrame = [self.view convertRect:finalKeyboardFrame fromView:self.view.window];
    
    // Calculate new position of the commentBar
    CGRect commentBarFrame = self.mediaBar.frame;
    commentBarFrame.origin.y = finalKeyboardFrame.origin.y - commentBarFrame.size.height;
    
    // Update tableView height.
      UIViewAnimationCurve animationCurve = (UIViewAnimationCurve) [[notificationInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[notificationInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Animate view size synchronously with the appearance of the keyboard.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.mediaBar.frame = commentBarFrame;    
    [UIView commitAnimations];
    
}

- (void)handleKeyboardWillShow:(NSNotification*)notification {
    self.imageView.hidden = YES;
    self.textView.hidden = YES;

    [self adjustViewForKeyboardNotification:notification andKeyboard:YES];
}

- (void)handleKeyboardDidShow:(NSNotification*)notification {
    
}

- (void)handleKeyboardWillHide:(NSNotification*)notification {
    self.imageView.hidden = NO;
    self.textView.hidden = NO;
    
    [self adjustViewForKeyboardNotification:notification andKeyboard:NO];
    
}

- (void)handleKeyboardDidHide:(NSNotification*)notification {
   
}

#pragma mark -
#pragma mark - DTRichTextEditorViewDelegate

- (BOOL)editorView:(DTRichTextEditorView *)editorView shouldChangeTextInRange:(NSRange)range replacementText:(NSAttributedString *)text
{
    NSString *replacePlainText = [text string];
    if ([replacePlainText isEqualToString:@""]) {// delete backward
        return YES;
    } else if ([replacePlainText isEqualToString:@"\n"]) {
        NSString *currentText = [[editorView attributedText] string];
        NSCharacterSet *whitespaceAndNewLineSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmedText = [currentText stringByTrimmingCharactersInSet:whitespaceAndNewLineSet];
        
        if (trimmedText.length >= 1) {
            NSString *newText = [editorView HTMLStringWithOptions:DTHTMLWriterOptionFragment];
            self.textView.text = newText;
            [editorView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
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

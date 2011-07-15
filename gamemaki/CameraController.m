//
//  CameraController.m
//  gamemaki
//
//  Created by Socialico on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraController.h"
#import <MobileCoreServices/UTCoreTypes.h>


@implementation CameraController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)loadView
{
	[super loadView];
    UIButton* cameraOpenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraOpenBtn setTitle:@"Take Photo" forState:UIControlStateNormal];
    [cameraOpenBtn addTarget:self action:@selector(cameraOpenClick:) forControlEvents:UIControlEventTouchUpInside];
    [cameraOpenBtn sizeToFit];
    cameraOpenBtn.top = 100;
    cameraOpenBtn.left = floor(self.view.width/2 - cameraOpenBtn.width/2);
    [self.view addSubview:cameraOpenBtn];
}

-(IBAction)cameraOpenClick:(id)sender {
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Camera Roll
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    }
    
    // Handle a movie capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (
                                                 moviePath, nil, nil, nil);
        }
    }
    
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    //[picker release];
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {    
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    //[picker release];
}

@end

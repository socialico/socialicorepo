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
    [cameraImagePicker release];
    [photoLibraryImagePicker release];
    [super dealloc];
}


- (void)loadView {
	[super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];
    
    UIButton* openCameraBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [openCameraBtn setTitle:@"Take New Photo" forState:UIControlStateNormal];
    [openCameraBtn addTarget:self action:@selector(openCamera:) forControlEvents:UIControlEventTouchUpInside];
    [openCameraBtn sizeToFit];
    openCameraBtn.top = 100;
    openCameraBtn.left = floor(self.view.width/2 - openCameraBtn.width/2);
    [self.view addSubview:openCameraBtn];
    
    UIButton* openPhotoLibraryBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [openPhotoLibraryBtn setTitle:@"Select from Library" forState:UIControlStateNormal];
    [openPhotoLibraryBtn addTarget:self action:@selector(openPhotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [openPhotoLibraryBtn sizeToFit];
    openPhotoLibraryBtn.top = 140;
    openPhotoLibraryBtn.left = floor(self.view.width/2 - openPhotoLibraryBtn.width/2);
    [self.view addSubview:openPhotoLibraryBtn];
}


- (IBAction) openCamera:(id)sender {
    if (cameraImagePicker == nil) {
        cameraImagePicker = [[UIImagePickerController alloc] init];
        cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraImagePicker.delegate = self;
    }
    [self presentModalViewController:cameraImagePicker animated:YES];
}


- (IBAction) openPhotoLibrary:(id)sender {
    if (photoLibraryImagePicker == nil) {
        photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoLibraryImagePicker.delegate = self;
    }
    [self presentModalViewController:photoLibraryImagePicker animated:YES];
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

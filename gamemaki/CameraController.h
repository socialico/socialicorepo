//
//  CameraController.h
//  gamemaki
//
//  Created by Socialico on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraController : UIViewController
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate> {
    UIImagePickerController* cameraImagePicker;
    UIImagePickerController* photoLibraryImagePicker;
}

@end

//
//  UIActionSheet+DNBlock.h
//  DNCategory
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)();
typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();
typedef void (^PhotoPickedBlock)(UIImage *chosenImage);

@interface UIActionSheet (DNBlock) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

+ (void)actionSheetWithTitle:(NSString*)title
                      message:(NSString*)message
                      buttons:(NSArray*)buttonTitles
                   showInView:(UIView*)view
                    onDismiss:(DismissBlock)dismissed
                     onCancel:(CancelBlock)cancelled;


+ (void)actionSheetWithTitle:(NSString*)title
                     message:(NSString*)message
      destructiveButtonTitle:(NSString*)destructiveButtonTitle
                     buttons:(NSArray*)buttonTitles
                  showInView:(UIView*)view
                   onDismiss:(DismissBlock)dismissed
                    onCancel:(CancelBlock)cancelled;


+ (void)photoPickerWithTitle:(NSString*)title
                  showInView:(UIView*)view
                   presentVC:(UIViewController*)presentView
               onPhotoPicked:(PhotoPickedBlock)photoPicked
                    onCancel:(CancelBlock)cancelled;

@end

//
//  EditProfileTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/28/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "EditProfileTableViewController.h"
#import "User.h"
#import "DataManager.h"
#import "APIManager.h"
#import "UtilityManager.h"

@interface EditProfileTableViewController ()

@end

@implementation EditProfileTableViewController{
    User *currentUser;
    NSString *avatarBase64;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([DataManager getUserUserDefault]) {
        currentUser = [DataManager getUserUserDefault];
        
        NSString *imageURL = currentUser.avatarUrl;
        NSString *nama = currentUser.name;
        NSString *noKTP = currentUser.noKTP;
        NSString *alamat = currentUser.address;
        NSString *nomerHP = currentUser.noHP;
        
        NSString *avatarURL = [NSString stringWithFormat:@"%@%@", kBaseURL, imageURL];
        
        if (avatarURL) {
            [APIManager requestImageWithUrl:avatarURL withOnSuccessBlock:^(UIImage *image, BOOL reloadView) {
                
                [self.changeProfileBtn setBackgroundImage:image forState:UIControlStateNormal];
                
            } withOnFailureBlock:^{
                
                [UtilityManager showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:@"Error when getting the image profile from server"];
                
            }];
        }
        if (nama) {
            self.namaTF.text = nama;
        }
        if (noKTP) {
            self.noKTPTF.text = noKTP;
        }
        if (alamat) {
            self.alamatTF.text = alamat;
        }
        if (nomerHP) {
            self.nomerHPTF.text = nomerHP;
        }
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)changeProfileBtnAction:(UIButton *)sender {
    UIAlertController *actionSheet = [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhoto = [UIAlertAction
                                  actionWithTitle:@"Take Photo"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                          
                                          [UtilityManager showDefaultAlertWithViewController:self withTitle:@"" andMessage:@"Device tidak memiliki kamera"];
                                          
                                      }else{
                                          //take photo
                                          UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                          picker.delegate = self;
                                          picker.allowsEditing = YES;
                                          picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                          
                                          [self presentViewController:picker animated:YES completion:NULL];
                                          
                                      }
                                      
                                  }];
    
    [actionSheet addAction:takePhoto];
    
    UIAlertAction *openLibrary = [UIAlertAction
                                actionWithTitle:@"Select Photo"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //select photo
                                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                    picker.delegate = self;
                                    picker.allowsEditing = YES;
                                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                    
                                    [self presentViewController:picker animated:YES completion:NULL];
                                    
                                }];
    
    UIAlertAction* okBtn = [UIAlertAction
                            actionWithTitle:@"Cancel"
                            style:UIAlertActionStyleCancel
                            handler:^(UIAlertAction * action)
                            {
                                
                            }];
    
    [actionSheet addAction:okBtn];
    
    [actionSheet addAction:openLibrary];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)saveBtn:(UIButton *)sender {
    
    if (!self.isSaveAlreadyClicked) {
        
        if ([self.namaTF.text  isEqual: @""] || [self.noKTPTF.text  isEqual: @""] || [self.alamatTF.text  isEqual: @""] || [self.nomerHPTF.text  isEqual: @""])
        {
            
            [UtilityManager showDefaultAlertWithViewController:self withTitle:@"" andMessage:@"Mohon isi kolom yang kosong"];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Cek Data"
                                          message:@"Apakah yakin data sudah benar?"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okBtn = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        if (currentUser.userId) {
                                            
                                            self.isSaveAlreadyClicked = YES;
                                            
                                            currentUser.address = self.alamatTF.text;
                                            currentUser.name = self.namaTF.text;
                                            currentUser.noKTP = self.noKTPTF.text;
                                            currentUser.noHP = self.nomerHPTF.text;

                                            NSString *endpoint = [NSString stringWithFormat:@"%@/%@", kPostUsers, [DataManager getUserId]];
                                            
                                            [APIManager putAPIWithParam:@{
                                                                         @"user":@{
                                                                                 @"name":self.namaTF.text,
                                                                                 @"address":self.alamatTF.text,
                                                                                 @"phone":self.nomerHPTF.text,
                                                                                 @"avatar":avatarBase64 ? avatarBase64 : @"",
                                                                                 @"no_ktp":self.noKTPTF.text
                                                                                 }
                                                                         }andEndPoint:endpoint withAuthorization:YES successBlock:^(NSDictionary *response) {
                                                                             
                                                                             [UtilityManager showDefaultAlertWithViewController:self withTitle:@"Sukses" andMessage:@"Data tersimpan"];
                                                                             
                                                                         } andFailureBlock:^(NSString *errorMessage) {
                                                                             
                                                                             [UtilityManager showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:errorMessage];
                                                                             
                                                                             self.isSaveAlreadyClicked = NO;
                                                                         }];
                                        }
                                        
                                        
                                    }];
            
            [alert addAction:okBtn];
            
            UIAlertAction* cancelBtn = [UIAlertAction
                                        actionWithTitle:@"Batal"
                                        style:UIAlertActionStyleCancel
                                        handler:^(UIAlertAction * action)
                                        {
                                            
                                        }];
            
            [alert addAction:cancelBtn];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    avatarBase64 = [NSString stringWithFormat:@"data:image/jpg;base64,%@", [UIImageJPEGRepresentation(chosenImage, 0.7) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    [self.changeProfileBtn setBackgroundImage:chosenImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end

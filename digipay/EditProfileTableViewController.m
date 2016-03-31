//
//  EditProfileTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/28/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "EditProfileTableViewController.h"
#import "User.h"
#import "Utils.h"
#import "APIClient.h"

@interface EditProfileTableViewController ()

@end

@implementation EditProfileTableViewController{
    User *currentUser;
    NSString *avatarBase64;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([Utils getUserUserDefault]) {
        currentUser = [Utils getUserUserDefault];
        
        NSString *nama = currentUser.name;
        NSString *noKTP = currentUser.noKTP;
        NSString *alamat = currentUser.address;
        NSString *nomerHP = currentUser.noHP;
        
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
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
                                          
                                          [Utils showDefaultAlertWithViewController:self withTitle:@"" andMessage:@"Device tidak memiliki kamera"];
                                          
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
            
            [Utils showDefaultAlertWithViewController:self withTitle:@"" andMessage:@"Mohon isi kolom yang kosong"];
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

                                            NSString *endpoint = [NSString stringWithFormat:@"%@/%@", kPostUsers, [Utils getUserId]];
                                            
                                            [APIClient putAPIWithParam:@{
                                                                         @"user":@{
                                                                                 @"name":self.namaTF.text,
                                                                                 @"address":self.alamatTF.text,
                                                                                 @"phone":self.nomerHPTF.text,
                                                                                 @"avatar":avatarBase64 ? avatarBase64 : @"",
                                                                                 @"no_ktp":self.noKTPTF.text
                                                                                 }
                                                                         }andEndPoint:endpoint withAuthorization:YES successBlock:^(NSDictionary *response) {
                                                                             
                                                                             [Utils showDefaultAlertWithViewController:self withTitle:@"Sukses" andMessage:@"Data tersimpan"];
                                                                             
                                                                         } andFailureBlock:^(NSString *errorMessage) {
                                                                             
                                                                             [Utils showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:errorMessage];
                                                                             
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

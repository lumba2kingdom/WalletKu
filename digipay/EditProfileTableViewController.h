//
//  EditProfileTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/28/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseTableViewController.h"

@interface EditProfileTableViewController : BaseTableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *namaTF;
@property (weak, nonatomic) IBOutlet UITextField *noKTPTF;
@property (weak, nonatomic) IBOutlet UIButton *changeProfileBtn;
@property (weak, nonatomic) IBOutlet UITextField *alamatTF;
@property (weak, nonatomic) IBOutlet UITextField *nomerHPTF;

@property BOOL isSaveAlreadyClicked;

- (IBAction)changeProfileBtnAction:(UIButton *)sender;
- (IBAction)saveBtn:(UIButton *)sender;
@end

//
//  CallUsViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 4/1/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseViewController.h"

@interface CallUsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *divisionTF;
@property (weak, nonatomic) IBOutlet UITextView *messageTV;
- (IBAction)sendBtn:(UIButton *)sender;
- (IBAction)backgroundTap:(UITapGestureRecognizer *)sender;
- (IBAction)contactUsBtn:(UIButton *)sender;
@end

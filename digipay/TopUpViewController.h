//
//  TopUpViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (IBAction)transferBankBtn:(UIButton *)sender;
- (IBAction)creditCardBtn:(UIButton *)sender;
@end

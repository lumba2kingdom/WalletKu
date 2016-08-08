//
//  DataPemesanHeaderTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 8/8/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataPemesanHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *noHandphoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@property (weak, nonatomic) IBOutlet UIButton *pencarianUlangButton;
@end

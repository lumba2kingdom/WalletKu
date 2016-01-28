//
//  RegisterTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "RegisterTableViewController.h"

@interface RegisterTableViewController ()

@end

@implementation RegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
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

- (IBAction)daftarBtn:(UIButton *)sender {
    
    if ([self.namaTF.text  isEqual: @""] || [self.emailTF.text  isEqual: @""] || [self.alamatTF.text  isEqual: @""] || [self.passwordTF.text  isEqual: @""] || [self.ulangPasswordTF.text isEqual: @""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Mohon isi kolom yang kosong"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    
                                }];
        
        [alert addAction:okBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSString *emailid = self.emailTF.text;
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        BOOL myStringMatchesRegEx=[emailPredicate evaluateWithObject:emailid];
        
        if (! myStringMatchesRegEx)
        {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Alamat email tidak sesuai"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okBtn = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        
                                    }];
            
            [alert addAction:okBtn];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else if (![self.passwordTF.text isEqualToString:self.ulangPasswordTF.text]){
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Password tidak sesuai"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okBtn = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        
                                    }];
            
            [alert addAction:okBtn];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else if (!self.pernyataanSwitch.isOn){
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Anda belum menyutujui pernyataan yang tertulis."
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okBtn = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        
                                    }];
            
            [alert addAction:okBtn];
            
            [self presentViewController:alert animated:YES completion:nil];
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
                                        
                                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                                        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
                                        [self presentViewController:vc animated:YES completion:nil];
                                        
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
@end

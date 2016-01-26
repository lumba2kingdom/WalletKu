//
//  PayHistoryTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "PayHistoryTableViewController.h"
#import "PayHistoryTableViewCell.h"

@interface PayHistoryTableViewController ()

@end

@implementation PayHistoryTableViewController{
    NSArray *paymentID, *paymentStatus, *paymentDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    paymentID = [[NSArray alloc] initWithObjects:@"Pul1099111", @"Pul1099112", @"Pul1099113", @"Pul1099114", @"Pul1099115", @"Pul1099116", @"Pul1099117", @"Pul1099118", @"Pul1099119", @"Pul1099110", nil];
    paymentStatus = [[NSArray alloc] initWithObjects:@"Complete", @"Pending", @"Cancel", @"Complete", @"Pending", @"Cancel", @"Complete", @"Pending", @"Cancel", @"Complete", nil];
    paymentDate = [[NSArray alloc] initWithObjects:@"2 Sep 2015", @"3 Sep 2015", @"4 Sep 2015", @"5 Sep 2015", @"6 Sep 2015", @"7 Sep 2015", @"8 Sep 2015", @"9 Sep 2015", @"10 Sep 2015", @"11 Sep 2015", nil];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return paymentID.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payHistoryCell" forIndexPath:indexPath];
    
    cell.paymentIDLabel.text = paymentID[indexPath.row];
    cell.paymentStatusLabel.text = paymentStatus[indexPath.row];
    cell.paymentDateLabel.text = paymentDate[indexPath.row];
    
    return cell;
}

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

@end

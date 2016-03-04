//
//  TopUpPulsaListTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 3/4/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TopUpPulsaListTableViewController.h"

@interface TopUpPulsaListTableViewController ()

@end

@implementation TopUpPulsaListTableViewController

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

- (void)sendNominal:(NSMutableArray *)nominal
{
    [self.delegate setNominal:nominal];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendProvider:(NSMutableArray *)provider
{
    [self.delegate setProvider:provider];
    [self.delegate setNominal:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.isForNominal) {
        return self.providerList.count;
    }else{
        return [[self.providerList valueForKey:@"nominals"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    
    if (!self.isForNominal) {
        cell.textLabel.text = [[self.providerList valueForKey:@"name"] objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.providerList valueForKeyPath:@"nominals.amount"] objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.isForNominal) {
        NSMutableArray *provider = [NSMutableArray arrayWithObject:self.providerList];
        [self sendProvider:[[provider firstObject] objectAtIndex:indexPath.row]];
    }else{
        NSMutableArray *nominal = [NSMutableArray arrayWithObject:[self.providerList valueForKey:@"nominals"]];
        [self sendNominal:[[nominal firstObject] objectAtIndex:indexPath.row]];
    }
    
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

//
//  TopUpPulsaTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/29/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TopUpPulsaTableViewController.h"
#import "TopUpPulsaListTableViewController.h"
#import "APIClient.h"

@interface TopUpPulsaTableViewController ()

@end

@implementation TopUpPulsaTableViewController {
    NSMutableArray *providerSelected, *nominalSelected;
    int providerId, nominalId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getProviderAPI];
    
//    provider = [[NSArray alloc] initWithObjects:@"Indosat", @"Three", @"Telkomsel", @"XL", @"Smartfren", nil];
//    nominal = [[NSArray alloc] initWithObjects:@"5000", @"10000", @"25000", @"50000", @"100000", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (providerSelected) {
        self.selectProviderTF.text = [providerSelected valueForKey:@"name"];
        providerId = [[providerSelected valueForKey:@"id"] intValue];
    }else{
        self.selectProviderTF.text = @"";
        providerId = 0;
    }
    
    if (nominalSelected) {
        self.nominalTF.text = [NSString stringWithFormat:@"%@", [nominalSelected valueForKey:@"amount"]];
        nominalId = [[nominalSelected valueForKey:@"id"] intValue];
    }else{
        self.nominalTF.text = @"";
        nominalId = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"topUpList"]) {
        
        TopUpPulsaListTableViewController *topUpList = [segue destinationViewController];
        if ([sender isEqualToString:@"provider"]) {
            
            topUpList.providerList = self.providerList;
            topUpList.isForNominal = NO;
            
        }else if ([sender isEqualToString:@"nominal"]) {
            
            topUpList.providerList = providerSelected;
            topUpList.isForNominal = YES;
            
        }
        
        topUpList.delegate = self;
    }
}

#pragma mark - Action Methods
- (IBAction)selectProviderBtn:(UIButton *)sender {
    if (self.providerList) {
        [self performSegueWithIdentifier:@"topUpList" sender:@"provider"];
    }
}

- (IBAction)selectNominalBtn:(UIButton *)sender {
    if (providerSelected) {
        [self performSegueWithIdentifier:@"topUpList" sender:@"nominal"];
    }else{
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Kolom provider kosong"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:nil];
        
        [alert addAction:okBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)setProvider:(NSMutableArray *)provider {
    providerSelected = provider;
}

- (void)setNominal:(NSMutableArray *)nominal {
    nominalSelected = nominal;
}

- (IBAction)beliBtn:(UIButton *)sender {
    if ([self.nominalTF.text  isEqual: @""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Kolom nominal kosong"
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
    else if ([self.nomerHPTF.text  isEqual: @""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Kolom No. HP kosong"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                }];
        
        [alert addAction:okBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        [self topUpPulsaAPI];
        
    }
}

#pragma mark - API methods
- (void)topUpPulsaAPI{

    [APIClient topUpPulsaWithProvider:providerId nominal:nominalId andPhoneNumber:self.nomerHPTF.text withSuccessBlock:^(BOOL success) {
        if (success) {
            
            UIAlertController * alert =   [UIAlertController
                                           alertControllerWithTitle:@"Berhasil"
                                           message:@"Top Up Pulsa berhasil dilakukan"
                                           preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okBtn = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:nil];
            
            [alert addAction:okBtn];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    } andFailureBlock:^(NSString *message) {
        
        UIAlertController * alert =   [UIAlertController
                                       alertControllerWithTitle:@"Error"
                                       message:message
                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:nil];
        
        [alert addAction:okBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}

- (void)getProviderAPI{
    [APIClient getProvidersAndNominalsWithSuccessBlock:^(id responseObject) {
        
        self.providerList = (NSMutableArray *)[responseObject objectForKey:@"providers"];
        
    } andFailureBlock:^(NSString *message) {
        
        UIAlertController * alert =   [UIAlertController
                                       alertControllerWithTitle:@"Error"
                                       message:message
                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:nil];
        
        [alert addAction:okBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

@end

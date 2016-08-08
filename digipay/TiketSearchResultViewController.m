//
//  TiketSearchResultViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TiketSearchResultViewController.h"
#import "DepartTableViewCell.h"
#import "ReturnTableViewCell.h"
#import "FlightSearchResult.h"
#import "DataPemesanTableViewController.h"

@interface TiketSearchResultViewController ()

@end

@implementation TiketSearchResultViewController {
    FlightSearchResult *flightResult;
    NSIndexPath *departSelectedIndexPath, *returnSelectedIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    flightResult = [FlightSearchResult listWithData:self.searchResultObject];
    
    self.fromToDepartLabel.text = [NSString stringWithFormat:@"%@ - %@ (Depart)", flightResult.searchInfo.infoFrom, flightResult.searchInfo.infoTo];
    self.fromToReturnLabel.text = [NSString stringWithFormat:@"%@ - %@ (Return)", flightResult.searchInfo.infoTo, flightResult.searchInfo.infoFrom];
    
    int totalPenumpang = [flightResult.searchInfo.infoAdult intValue] + [flightResult.searchInfo.infoChild intValue] + [flightResult.searchInfo.infoInfant intValue];
    
    self.dateDepartLabel.text = [NSString stringWithFormat:@"%@, %d Penumpang", flightResult.searchInfo.infoDepart, totalPenumpang];
    self.dateReturnLabel.text = [NSString stringWithFormat:@"%@, %d Penumpang", flightResult.searchInfo.infoReturn, totalPenumpang];
    
    if (flightResult.scheduleDepart && flightResult.scheduleDepart.count != 0) {
        self.departHeightConstraint.constant = (flightResult.scheduleDepart.count *100) +200;
    }else {
        self.departHeightConstraint.constant = 0;
    }
    if (flightResult.scheduleReturn && flightResult.scheduleReturn.count != 0) {
        self.returnHeightConstraint.constant = (flightResult.scheduleReturn.count *100) +200;
    }else {
        self.returnHeightConstraint.constant = 0;
    }
    
    [self.departTableView reloadData];
    [self.returnTableView reloadData];
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
    if (tableView.tag == 1) {
        return flightResult.scheduleDepart.count;
    }else {
        return flightResult.scheduleReturn.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        DepartTableViewCell *departCell = [tableView dequeueReusableCellWithIdentifier:@"departCell" forIndexPath:indexPath];
        
        FlightSchedule *flightSchedule = [flightResult.scheduleDepart objectAtIndex:indexPath.row];
        
        departCell.airlineNameLabel.text = flightSchedule.scheduleAirlineName;
        departCell.airlineTypeLabel.text = flightSchedule.scheduleType;
        FlightClass *flightClass = [flightSchedule.scheduleClass firstObject];
        departCell.airlinePriceLabel.text = [NSString stringWithFormat:@"Rp.%@,-/Orang", flightClass.classPrice];
        
        if (flightSchedule.scheduleConnectionFlight && flightSchedule.scheduleConnectionFlight.count != 0) {
            
            FlightConnection *flightConnection = [flightSchedule.scheduleConnectionFlight firstObject];
            
            departCell.airlineTimeLabel.text = [NSString stringWithFormat:@"%@ - %@ (%@ - %@)\n%@ - %@ (%@ - %@)", flightSchedule.scheduleEtd, flightSchedule.scheduleEta, flightSchedule.scheduleFrom, flightSchedule.scheduleTo, flightConnection.connectionEtd, flightConnection.connectionEta, flightConnection.connectionFrom, flightConnection.connectionTo];
        }else{
            
            departCell.airlineTimeLabel.text = [NSString stringWithFormat:@"%@ - %@ (%@ - %@)", flightSchedule.scheduleEtd, flightSchedule.scheduleEta, flightSchedule.scheduleFrom, flightSchedule.scheduleTo];
        }
        
        if ([indexPath isEqual:departSelectedIndexPath]) {
            [departCell.selectButton setTitle:@"Selected" forState:UIControlStateNormal];
        }else{
            [departCell.selectButton setTitle:@"Select" forState:UIControlStateNormal];
        }
        
        return departCell;
    }else{
        ReturnTableViewCell *returnCell = [tableView dequeueReusableCellWithIdentifier:@"returnCell" forIndexPath:indexPath];
        
        FlightSchedule *flightSchedule = [flightResult.scheduleReturn objectAtIndex:indexPath.row];
        
        returnCell.airlineNameLabel.text = flightSchedule.scheduleAirlineName;
        returnCell.airlineTypeLabel.text = flightSchedule.scheduleType;
        FlightClass *flightClass = [flightSchedule.scheduleClass firstObject];
        returnCell.airlinePriceLabel.text = [NSString stringWithFormat:@"Rp.%@,-/Orang", flightClass.classPrice];
        
        if (flightSchedule.scheduleConnectionFlight && flightSchedule.scheduleConnectionFlight.count != 0) {
            
            FlightConnection *flightConnection = [flightSchedule.scheduleConnectionFlight firstObject];
            
            returnCell.airlineTimeLabel.text = [NSString stringWithFormat:@"%@ - %@ (%@ - %@)\n%@ - %@ (%@ - %@)", flightSchedule.scheduleEtd, flightSchedule.scheduleEta, flightSchedule.scheduleFrom, flightSchedule.scheduleTo, flightConnection.connectionEtd, flightConnection.connectionEta, flightConnection.connectionFrom, flightConnection.connectionTo];
        }else{
            
            returnCell.airlineTimeLabel.text = [NSString stringWithFormat:@"%@ - %@ (%@ - %@)", flightSchedule.scheduleEtd, flightSchedule.scheduleEta, flightSchedule.scheduleFrom, flightSchedule.scheduleTo];
        }
        
        if ([indexPath isEqual:returnSelectedIndexPath]) {
            [returnCell.selectButton setTitle:@"Selected" forState:UIControlStateNormal];
        }else{
            [returnCell.selectButton setTitle:@"Select" forState:UIControlStateNormal];
        }
        
        
        return returnCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 1) {
        departSelectedIndexPath = indexPath;
        [self.departTableView reloadData];
    }else{
        returnSelectedIndexPath = indexPath;
        [self.returnTableView reloadData];
    }
}

#pragma mark - Action Methods
- (IBAction)nextButtonAction:(UIButton *)sender {
    if (departSelectedIndexPath) {
        [self performSegueWithIdentifier:@"searchToDataPemesan" sender:nil];
    }else{
        [self showBasicAlertMessageWithTitle:@"" message:@"Silakan pilih jadwal"];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchToDataPemesan"]) {
        DataPemesanTableViewController *dataPemesanController = (DataPemesanTableViewController *)[segue destinationViewController];
        dataPemesanController.totalPassenger = [flightResult.searchInfo.infoAdult intValue] + [flightResult.searchInfo.infoChild intValue] + [flightResult.searchInfo.infoInfant intValue];
        dataPemesanController.sessionId = flightResult.sessionId;
        
    }
}

@end

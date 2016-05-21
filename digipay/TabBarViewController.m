//
//  TabBarViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 5/21/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set tab bar icons
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [self.tabBar.items objectAtIndex:3];
    
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"tab-profile-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.image = [[UIImage imageNamed:@"tab-profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"tab-pay-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"tab-pay"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"tab-mywallet-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"tab-mywallet"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    tabBarItem4.selectedImage = [[UIImage imageNamed:@"tab-payhistory-active"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.image = [[UIImage imageNamed:@"tab-payhistory"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:247.0/255.0 green:234.0/255.0 blue:12.0/255.0 alpha:1.0],
                                                        } forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  DXCSearchCriteriaViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 10/9/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCSearchCriteriaViewController.h"

@interface DXCSearchCriteriaViewController ()

@end

@implementation DXCSearchCriteriaViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchResultsWithFlag:(BOOL)flag {
        self.locationLabel.hidden=!flag;
        self.propertyTypeLabel.hidden=!flag;
        self.priceFromLabel.hidden=!flag;
        self.priceToLabel.hidden=!flag;
        self.bedroomsLabel.hidden=!flag;
        self.bathroomsLabel.hidden=!flag;
        self.parkingLabel.hidden=!flag;
        self.keywordsLabel.hidden=!flag;
}


@end

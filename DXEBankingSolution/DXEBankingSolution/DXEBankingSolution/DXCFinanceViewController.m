//
//  DXCFinanceViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 30/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCFinanceViewController.h"

@interface DXCFinanceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectedSliderValue;
@property (weak, nonatomic) IBOutlet UISlider *selectedSlider;

@end

@implementation DXCFinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    self.selectedSlider.value=50;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:round(self.selectedSlider.value)*1000]];
    
    self.selectedSliderValue.text=[NSString stringWithFormat:@"%@", numberAsString];
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(UISlider *)sender {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:round(sender.value)*1000]];
    
    self.selectedSliderValue.text=[NSString stringWithFormat:@"%@", numberAsString];
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

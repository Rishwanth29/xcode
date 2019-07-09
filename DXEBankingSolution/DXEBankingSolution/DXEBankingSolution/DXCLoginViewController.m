//
//  DXCLoginViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 25/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCLoginViewController.h"
#import "UIColor+HexToRGB.h"

@interface DXCLoginViewController ()

@property (nonatomic)    NSInteger clickNumber;
@property (weak, nonatomic) IBOutlet UILabel *passCodeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *passCodeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *passCodeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *passCodeLabel4;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@end

@implementation DXCLoginViewController
-(void)awakeFromNib {
    self.clickNumber=0;
    [super awakeFromNib];
    [self.deleteButton setImage:[UIImage imageNamed:@"deletebuttonfilled"] forState:UIControlStateSelected | UIControlStateHighlighted];
     [self.deleteButton setImage:[UIImage imageNamed:@"deleteblank"] forState:UIControlStateNormal];
}

- (IBAction)deleteButtonClicked:(UIButton *)sender {
    if (self.clickNumber) {
        switch (self.clickNumber) {
            case 1:
                self.passCodeLabel1.textColor=[UIColor lightGrayColor];
                break;
            case 2:
                self.passCodeLabel2.textColor=[UIColor lightGrayColor];
                break;
            case 3:
                self.passCodeLabel3.textColor=[UIColor lightGrayColor];
                break;
            case 4:
                self.passCodeLabel4.textColor=[UIColor lightGrayColor];
                
                break;
                
        }
        self.clickNumber=self.clickNumber-1;
    }
}
- (IBAction)numberClick:(UIButton *)sender {
    if(self.clickNumber<4)
        self.clickNumber=self.clickNumber+1;
    switch (self.clickNumber) {
        case 1:
            self.passCodeLabel1.textColor=[UIColor colorWithHexString:@"ffed00"];
            break;
        case 2:
            self.passCodeLabel2.textColor=[UIColor colorWithHexString:@"ffed00"];
            break;
        case 3:
            self.passCodeLabel3.textColor=[UIColor colorWithHexString:@"ffed00"];
            break;
        case 4:
            self.passCodeLabel4.textColor=[UIColor colorWithHexString:@"ffed00"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self goToWelcomeScreen];
                
            });
    }
}
-(void)goToWelcomeScreen {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *welcomeController=[storyBoard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    [self presentViewController:welcomeController animated:YES completion:^{
        self.passCodeLabel1.textColor=[UIColor lightGrayColor];
        self.passCodeLabel2.textColor=[UIColor lightGrayColor];
        self.passCodeLabel3.textColor=[UIColor lightGrayColor];
        self.passCodeLabel4.textColor=[UIColor lightGrayColor];
        self.clickNumber=0;
    }];
}
- (IBAction)successfulLogin:(UIButton *)sender {
     self.passCodeLabel1.textColor=[UIColor colorWithHexString:@"ffed00"];
    self.passCodeLabel2.textColor=[UIColor colorWithHexString:@"ffed00"];
    self.passCodeLabel3.textColor=[UIColor colorWithHexString:@"ffed00"];
    self.passCodeLabel4.textColor=[UIColor colorWithHexString:@"ffed00"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self goToWelcomeScreen];
        
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

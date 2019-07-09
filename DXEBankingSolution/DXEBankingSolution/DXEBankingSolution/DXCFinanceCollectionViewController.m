//
//  DXCFinanceCollectionViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 01/10/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCFinanceCollectionViewController.h"
#import "DXCFinanceBankCell.h"
#import "DXCSearchPropertyViewController.h"
#import "DXCApprovalViewController.h"
#import "DXCErrorPopupViewController.h"
#import "DXCPopupOverlayAnimatedTransitioning.h"


@interface DXCFinanceCollectionViewController ()
@property(nonatomic,strong) NSArray * const reuseIdentifier;
@property(nonatomic,strong) NSArray *bankLogos;

@property(nonatomic,strong) NSArray *fixedRateValues;
@property(nonatomic,strong) NSArray *titlesValues;
@property(nonatomic,strong) NSArray *comparisionRateValues;
@property(nonatomic,strong) NSArray *monthlyRepaymentsValues;
@property(nonatomic,strong) NSArray *ongoingFeesValues;
@property(nonatomic,strong) NSArray *monthlyLaonValues;
@property(nonatomic,strong) NSArray *maxloanAmountValues;
@property (strong, nonatomic) UIViewController *errorPopViewController;
@property (nonatomic) id<UIViewControllerTransitioningDelegate> transitioningDelegate;
@property(nonatomic,strong) NSURLSession *session;
@end

@implementation DXCFinanceCollectionViewController



- (void)viewDidLoad {
    self.reuseIdentifier = @[@"Bank",@"Fixedrate",@"Comparisionrate",@"Monthlyrepayments",@"Ongoingfees",@"Maxloanamount"];
    self.bankLogos=@[@"bank",@"bank",@"bank",@"bank"];
    self.titlesValues=@[@"Option 1",@"Option 2",@"Option 3",@"Option 4"];
    self.fixedRateValues=@[@"4.14%",@"4.23%",@"4.19%",@"4.29%"];
    self.comparisionRateValues=@[@"4.62%",@"4.71%",@"4.21%",@"4.26%"];
    self.monthlyRepaymentsValues=@[@"$2,380.00",@"$2,686.00",@"$2,428.00",@"$2,521.00"];
    self.ongoingFeesValues=@[@"Nil",@"$50.09",@"$20.00",@"$16.65"];
    self.maxloanAmountValues=@[@"$490,000.00",@"$520,000.00",@"$500,000.00",@"$510,000.00"];
    _transitioningDelegate = [[DXCPopupOverlayTransitioningDelegate alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.errorPopViewController = [storyboard instantiateViewControllerWithIdentifier:@"ErrorPopupViewController"];
    self.errorPopViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.errorPopViewController setTransitioningDelegate:[self transitioningDelegate]];
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated {
    self.session=nil;
    [super viewDidDisappear:animated];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 6;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = self.collectionView.superview.frame;
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / [self.collectionView numberOfItemsInSection:indexPath.section]; //Replace the divisor with the column count requirement. Make sure to have it in float.
    
    UInt32 height;
    switch (indexPath.section) {
        case 0:
            height=screenRect.size.height-round(screenRect.size.height/7)*5;
            break;
            
        default:
            height=round(screenRect.size.height/7);
            break;
    }
    CGSize size = CGSizeMake(cellWidth, height);
    
    return size;
}
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
{
    
    
    if (!path) {
        path = @"";
    }
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:method];
    if (parameters) {
        
           
        NSError *error = nil;
        
        NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        [request setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"Keep-Alive"] forHTTPHeaderField:@"Connection"];
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:(NSJSONWritingOptions)0 error:&error]];
        
        
        if (error) {
            NSLog(@"%@ %@: %@", [self class], NSStringFromSelector(_cmd), error);
        }
        
    }
    
    return request;
}
-(void)postMessage{
    
    self.session = [NSURLSession sharedSession];
    NSDictionary *parameters=@{@"buyer":@"Fay Flevaras",@"seller":@"Adam Smith",@"preapproved":@"500000",@"cash":@"50000",@"propertyId":@"65AA2X1",@"bank":@"CBA"};
    NSURLRequest *request = [self requestWithMethod:@"POST" path:@"https://api.bloxapi.co/party1/api/property/initiate" parameters:parameters];
    [[NSUserDefaults standardUserDefaults] setObject:@"500000" forKey:@"preapproved"];
     DXCApprovalViewController *approvalViewController=(DXCApprovalViewController *)self.tabBarController.viewControllers[3];
    approvalViewController.joinAuctionButton.enabled=NO;
    [approvalViewController.activityIndicator startAnimating];
    [approvalViewController.activityIndicator setHidden:NO];
    
    dispatch_async(dispatch_queue_create("SessionQ", DISPATCH_QUEUE_SERIAL), ^{
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [approvalViewController.activityIndicator stopAnimating];
            [approvalViewController.activityIndicator setHidden:YES];
            
        });
        
        if (!error) {
            NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json dict is %@",jsonDict);
            if (!jsonDict) {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Block chain Server response" message:[NSString stringWithFormat:@"Received NULL JSON response"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }]];
                
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
                return;
            }
            NSDictionary *bankToken=jsonDict[@"bankToken"];
            NSString *bankTokenID=bankToken[@"bankTokenId"];
            NSString *preapproved=bankToken[@"preapproved"];
            NSString *ownerPublicKey=bankToken[@"ownerPublicKey"];
            NSString *borrowerPublicKey=bankToken[@"borrowerPubKey"];
            NSString *bank=bankToken[@"bank"];
            NSString *propertyId=bankToken[@"propertyId"];
            NSString *buyerPubKey=jsonDict[@"buyerPubKey"];
            NSString *sellerPubKey=jsonDict[@"sellerPubKey"];
            NSLog(@"bankToken=%@,bankTokenID=%@,preapproved=%@,ownerPublicKey=%@,borrowerPublicKey=%@,bank=%@,propertyId=%@,buyerPubKey=%@,sellerPubKey=%@",bankToken,bankTokenID,preapproved,ownerPublicKey,borrowerPublicKey,bank,propertyId,buyerPubKey,sellerPubKey);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    approvalViewController.joinAuctionButton.enabled=YES;
                   // [self.tabBarController setSelectedIndex:3];
                    approvalViewController.buyerNameValueLabel.text=parameters[@"buyer"];
                    approvalViewController.buyerPublicKeyValueLabel.text=buyerPubKey;
                    approvalViewController.amountDepositedLabel.text=[NSString stringWithFormat:@"$ 50,000"];
                    
                    approvalViewController.bankTokenIDLabel.text=bankTokenID;
                    [[NSUserDefaults standardUserDefaults] setObject:bankTokenID forKey:@"bankTokenID"];
                     [[NSUserDefaults standardUserDefaults] setObject:buyerPubKey forKey:@"buyerPubKey"];
                    [[NSUserDefaults standardUserDefaults] setObject:sellerPubKey forKey:@"sellerPubKey"];
                    
                   approvalViewController.bankTokenLenderAmount.text=@"$500,000.00";
                    approvalViewController.sellerNameValueLabel.text=parameters[@"seller"];
                    approvalViewController.sellerPublicKeyValueLabel.text=sellerPubKey;
                    approvalViewController.sellerAddressLabel.text=@"1/10 Derby St, Brighton, SA 5048";
                    approvalViewController.sellerIDLabel.text=propertyId;
                });
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
//            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Block chain server not reachable" message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [alertController dismissViewControllerAnimated:YES completion:^{
//
//            }];
//        }]];
//            [self presentViewController:alertController animated:YES completion:^{
//
//            }];
                [self presentViewController:self.errorPopViewController animated:YES completion:nil];
                });
        
        
        
    }
    }] resume];
    });
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DXCFinanceBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier[indexPath.section] forIndexPath:indexPath];
    
    cell.layer.borderColor=[UIColor blackColor].CGColor;
    cell.layer.borderWidth=0.25;
    
    switch (indexPath.section) {
        case 0:
        {
            UIImageView *bankImageView=(UIImageView *)[cell viewWithTag:1];
            bankImageView.image=[UIImage imageNamed:self.bankLogos[indexPath.row]];
            
            UILabel *bankLabel=(UILabel *)[cell viewWithTag:2];
            bankLabel.text=self.titlesValues[indexPath.row];
            
            [cell setGetApprovalButtonClicked:^(BOOL flag) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    DXCApprovalViewController *approvalViewController=(DXCApprovalViewController *)self.tabBarController.viewControllers[3];
                    
                    [self.tabBarController setSelectedIndex:3];
                   // DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
                   
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        approvalViewController.buyerNameValueLabel.text=@"Fay Flevaras";
//                        approvalViewController.buyerPublicKeyValueLabel.text=@"mQMuBExtIfMRCACe8xHPWBciPfCkdN+4TNUPW04ahD";
//                        approvalViewController.amountDepositedLabel.text=@"$ 50,000.00";
//                        approvalViewController.bankTokenIDLabel.text=@"Q2zI41R3m4Ao64XU0DtIYwHUo+6JcKi4d7aIiObA8mmdLQesyam";
//                        approvalViewController.bankTokenLenderLabel.text=@"CBA";
//                        approvalViewController.bankTokenLenderAmount.text=@"$ 450,000.00";
//                        approvalViewController.sellerNameValueLabel.text=@"Adam Smith";
//                        approvalViewController.sellerPublicKeyValueLabel.text=@"OQtOeoOP5inr9DIPzQ4Ejz744DSSR5SANAuYhFqN6";
//                        approvalViewController.sellerAddressLabel.text=@"8 Main Road,Port Melbourne VIC 3207";
//                        approvalViewController.sellerIDLabel.text=@"65AA2X1";
//                    });
                });
                

                    [self postMessage];
                
            }];
            break;
        }
        case 1:
        {
            UILabel *fixedRateValueLabel=(UILabel *)[cell viewWithTag:2];
            [fixedRateValueLabel setText:self.fixedRateValues[indexPath.row]];
            break;
        }
        case 2:
        {
            UILabel *comparisionRateValueLabel=(UILabel *)[cell viewWithTag:2];
            [comparisionRateValueLabel setText:self.comparisionRateValues[indexPath.row]];
            break;
        }
        case 3:
        {
            UILabel *ongoingFeesValuesLabel=(UILabel *)[cell viewWithTag:2];
            [ongoingFeesValuesLabel setText:self.monthlyRepaymentsValues[indexPath.row]];
            break;
        }
        case 4:
        {
            UILabel *monthlyValueLoanLabel=(UILabel *)[cell viewWithTag:2];
            [monthlyValueLoanLabel setText:self.ongoingFeesValues[indexPath.row]];
            break;
        }
        case 5:
        {
            UILabel *maxloanAmountLabel=(UILabel *)[cell viewWithTag:2];
            [maxloanAmountLabel setText:self.maxloanAmountValues[indexPath.row]];
            break;
        }
        default:
            break;
    }
    
    
    // Configure the cell
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}





@end

//
//  DXCAuctionTableViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 08/10/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCAuctionTableViewController.h"
#import "DXCSearchPropertyViewController.h"
#import "DXCAuctionViewController.h"
#import "DXCSettlementViewController.h"
#import "DXCSearchPropertyViewController.h"

@interface DXCAuctionTableViewController ()
@property (nonatomic,strong) NSArray *cellIdentifierArray;
@property (nonatomic,strong) NSMutableArray *bidRecordArray;
@property (nonatomic,strong) NSTimer *bidRecordTimer;

@property (weak, nonatomic)  UILabel *selectedSliderValue;
@property (nonatomic,strong) DXCAuctionViewController *auctionViewController;
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic) NSInteger remainingTime;
@property(nonatomic) NSInteger originalTime;
@end
typedef NS_ENUM(NSUInteger, DXEAuctionState) {
    DXEAuctionStateStart,
    DXEAuctionStateInProgress,
    DXEAuctionStateWon,
};
@implementation DXCAuctionTableViewController
-(void)initializeAuctionViewControllerState:(DXEAuctionState)state {
    switch (state) {
        case DXEAuctionStateStart:
            self.auctionViewController.secondFieldImage.image=[UIImage imageNamed:@"money"];
            self.auctionViewController.secondFieldTitle.text=@"Approval Amount";
            self.auctionViewController.secondFieldValue.text=@"$500,000";
            self.auctionViewController.timeRemaining.text=@"Not Started yet";
            break;
        case DXEAuctionStateInProgress:
            self.auctionViewController.secondFieldImage.image=[UIImage imageNamed:@"money"];
            self.auctionViewController.secondFieldTitle.text=@"Bid limit";
            self.auctionViewController.secondFieldValue.text=@"$550,000";
            self.auctionViewController.timeRemaining.text=@"00:15";
            self.originalTime=60;
            self.remainingTime=self.originalTime;
            break;
            
        case DXEAuctionStateWon:
            self.auctionViewController.secondFieldImage.image=[UIImage imageNamed:@"money"];
            self.auctionViewController.secondFieldTitle.text=@"Bid limit";
            self.auctionViewController.secondFieldValue.text=@"$550,000";
            
        default:
            break;
    }
}
-(NSString *)dollarFormatFromString:(CGFloat)value {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    
    self.selectedSliderValue.text=[NSString stringWithFormat:@"%@", [self dollarFormatFromString:round(sender.value)*10000]];
}

-(void)initiateTableForAuctionState:(DXEAuctionState)state {
    
    switch (state) {
        case DXEAuctionStateStart:
            self.cellIdentifierArray=@[@"AuctionStart",@"BidderHeader",@"AuctionTime"];
            self.bidRecordArray=nil;
            
            break;
        case DXEAuctionStateInProgress:
        {
            [self initializeAuctionViewControllerState:state];
            self.cellIdentifierArray=@[@"AuctionInProgress",@"BidderHeader",@"BidRecord"];
            self.bidRecordArray=[NSMutableArray arrayWithArray:@[[NSMutableDictionary dictionaryWithDictionary:@{@"Image":@"avatar1",@"Bidder":@"You",@"Time":@"10:10:15 AM",@"Bid":@"$450,000.00",@"isSelected":@"NO"}]]];
            DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
            searchPropertyViewController.backButton.enabled=NO;
            searchPropertyViewController.homeButton.enabled=NO;
            searchPropertyViewController.logoutButton.enabled=NO;
            break;
        }
        case DXEAuctionStateWon:
            [self initializeAuctionViewControllerState:state];
            self.cellIdentifierArray=@[@"AuctionWon",@"BidderHeader",@"BidRecord"];
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight=0;
    self.tableView.translatesAutoresizingMaskIntoConstraints=NO;

     [self initiateTableForAuctionState:DXEAuctionStateStart];
   
   
    
}
-(void)viewDidAppear:(BOOL)animated {
    self.auctionViewController=(DXCAuctionViewController *)self.parentViewController;
    [self initializeAuctionViewControllerState:DXEAuctionStateStart];
    DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
    searchPropertyViewController.backButton.enabled=YES;
    searchPropertyViewController.homeButton.enabled=YES;
    [super viewDidAppear:animated];
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
    NSString *bankToken=nil;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"bankTokenID"]) {
        bankToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"bankTokenID"];
    }
    NSString *buyerPubKey=nil;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"buyerPubKey"]) {
        buyerPubKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"buyerPubKey"];
    }
    NSString *sellerPubKey=nil;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"sellerPubKey"]) {
        sellerPubKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"sellerPubKey"];
    }
    NSString *preapprovedValue=nil;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"preapproved"]) {
        preapprovedValue=[[NSUserDefaults standardUserDefaults] objectForKey:@"preapproved"];
    }
    
    if (bankToken==nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Bank Token Not received From Approval screen" message:@"please go back to Finance screen and get the approval" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }]];
            
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        });
    } else {
    NSDictionary *parameters=@{@"propertyId":@"65AA2X1",@"salePrice":@"550000.00",@"buyer":@"Fay Flevaras",@"bankTokenId":bankToken};
    NSURLRequest *request = [self requestWithMethod:@"POST" path:@"https://api.bloxapi.co/party2/api/property/exchange" parameters:parameters];
    DXCSettlementViewController *settlementViewController=(DXCSettlementViewController *)self.tabBarController.viewControllers[5];
    settlementViewController.returnToHomeButton.enabled=NO;
    [settlementViewController.activityIndicator startAnimating];
    [settlementViewController.activityIndicator setHidden:NO];
    
    dispatch_async(dispatch_queue_create("SessionQ", DISPATCH_QUEUE_SERIAL), ^{
        [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [settlementViewController.activityIndicator stopAnimating];
                [settlementViewController.activityIndicator setHidden:YES];
                
            });
            
            if (!error) {
                NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
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
                NSLog(@"json dict is %@",jsonDict);
                NSString *txHash=jsonDict[@"txHash"];
                NSDictionary *bankToken=jsonDict[@"bankToken"];
                NSString *bankTokenID=bankToken[@"bankTokenId"];
                NSString *preapproved=bankToken[@"preapproved"];
                NSString *ownerPublicKey=bankToken[@"ownerPublicKey"];
                NSString *borrowerPublicKey=bankToken[@"borrowerPubKey"];
                
                NSString *bankPropertyId=bankToken[@"propertyId"];
                NSString *bankCash=bankToken[@"cash"];
                
                
                NSString *sellerCash=jsonDict[@"sellerCash"];
                NSString *buyerCash=jsonDict[@"buyerCash"];
               NSDictionary *propertyToken=jsonDict[@"propertyToken"];
               NSString *propertyTokenId=propertyToken[@"propertyTokenId"];
                
                NSString *ownerPubKey=propertyToken[@"ownerPubKey"];
                NSString *propertyId=propertyToken[@"propertyId"];
                NSString *salePrice=propertyToken[@"salePrice"];
                NSLog(@"txHash=%@,bankToken=%@,bankTokenId=%@,preapproved=%@,ownerPublicKey=%@,borrowerPubKey=%@,propertyTokenPropertyId=%@,cash=%@",txHash,bankToken,bankTokenID,preapproved,ownerPublicKey,borrowerPublicKey,bankPropertyId,bankCash);
                
                NSLog(@"sellerCash=%@,buyerCash=%@,propertyToken=%@,propertyTokenId=%@,ownerPubKey=%@,propertyId=%@,salePrice=%@",sellerCash,buyerCash,propertyToken,propertyTokenId,ownerPubKey,propertyId,salePrice);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    
                    DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
                    searchPropertyViewController.financingImageView.image=[UIImage imageNamed:@"greenbar"];
                    searchPropertyViewController.settlementImageView.image=[UIImage imageNamed:@"greenbar"];
                     searchPropertyViewController.logoutButton.enabled=YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        settlementViewController.returnToHomeButton.enabled=YES;
                        settlementViewController.transactionHash.text=[NSString stringWithFormat:@"Transaction hash is created: %@",txHash];
                        settlementViewController.bankPropertyId.text=propertyTokenId;
                        //[self.tabBarController setSelectedIndex:5];
                        settlementViewController.buyerNameValueLabel.text=parameters[@"buyer"];
                        settlementViewController.buyerPublicKeyValueLabel.text=buyerPubKey;
                        settlementViewController.buyerAddressLabel.text=@"1/10 Derby St, Brighton, SA 5048";
                        settlementViewController.buyerIDLabel.text=propertyId;
                        
                        settlementViewController.sellerNameValueLabel.text=@"Adam Smith";
                        settlementViewController.sellerPublicKeyValueLabel.text=sellerPubKey;
                        settlementViewController.amountDepositedLabel.text=[self dollarFormatFromString:bankCash.floatValue];
                        settlementViewController.bankTokenIDLabel.text=bankTokenID;
                       
                       settlementViewController.bankTokenLenderAmount.text=[self dollarFormatFromString:preapprovedValue.floatValue];
                        
                        
                        
                    });
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Block chain server not reachable" message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [alertController dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                    }]];
                    [self presentViewController:alertController animated:YES completion:^{
                        
                    }];
                });
                
                
                
            }
        }] resume];
    });
    }
    
}
-(IBAction)viewSettlement:(id)sender {
    [self.tabBarController setSelectedIndex:5];
    DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
    searchPropertyViewController.auctionImageView.image=[UIImage imageNamed:@"greenbar"];
    searchPropertyViewController.settlementImageView.image=[UIImage imageNamed:@"blackbar"];
    [self postMessage];
}

-(IBAction)moveToInProgress:(id)sender {
     [self initiateTableForAuctionState:DXEAuctionStateInProgress];
    if (self.bidRecordTimer) {
        [self.bidRecordTimer invalidate];
    }
    self.bidRecordTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.remainingTime=self.remainingTime-1;
        self.auctionViewController.timeRemaining.text=[NSString stringWithFormat:@"00:%02ld",(long)(self.remainingTime%15)];
        if (self.remainingTime<=0) {
            [self.bidRecordTimer invalidate];
            self.bidRecordTimer=nil;
            NSMutableDictionary *bidRecordDictionary=self.bidRecordArray[0];
            [bidRecordDictionary setValue:@"YES" forKey:@"isSelected"];
            [self initiateTableForAuctionState:DXEAuctionStateWon];
           
            self.auctionViewController.timeRemaining.text=@"00:00";
            [self.tableView reloadData];
            return;
        }
        if (self.remainingTime==(self.originalTime-15)) {
             self.auctionViewController.timeRemaining.text=[NSString stringWithFormat:@"00:15"];
            [self.bidRecordArray insertObject:[NSMutableDictionary dictionaryWithDictionary:@{@"Image":@"Danis",@"Bidder":@"Danis",@"Time":@"10:10:30 AM",@"Bid":@"$480,000.00",@"isSelected":@"NO"}] atIndex:0];
           
        }
        if (self.remainingTime==(self.originalTime-30)) {
             self.auctionViewController.timeRemaining.text=[NSString stringWithFormat:@"00:15"];
            [self.bidRecordArray insertObject:[NSMutableDictionary dictionaryWithDictionary:@{@"Image":@"Adam",@"Bidder":@"Adam",@"Time":@"10:10:45 AM",@"Bid":@"$520,000.00",@"isSelected":@"NO"}] atIndex:0];
            
        }
        if (self.remainingTime==(self.originalTime-45)) {
             self.auctionViewController.timeRemaining.text=[NSString stringWithFormat:@"00:15"];
            [self.bidRecordArray insertObject:[NSMutableDictionary dictionaryWithDictionary:@{@"Image":@"avatar1",@"Bidder":@"You",@"Time":@"10:11:00 AM",@"Bid":@"$550,000.00",@"isSelected":@"NO"}] atIndex:0];
            
        }
        
        [self.tableView reloadData];
    }];
   
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.cellIdentifierArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.cellIdentifierArray[section] isEqualToString:@"BidRecord"]) {
        return self.bidRecordArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cellIdentifierArray[indexPath.section] isEqualToString:@"AuctionStart"]) {
        return 420;
    }
    if ([self.cellIdentifierArray[indexPath.section] isEqualToString:@"BidRecord"]) {
        return 100;
    }
    if ([self.cellIdentifierArray[indexPath.section] isEqualToString:@"AuctionWon"]||[self.cellIdentifierArray[indexPath.section] isEqualToString:@"AuctionInProgress"]) {
        return 200;
    }
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifierArray[indexPath.section] forIndexPath:indexPath];
    if ([self.cellIdentifierArray[indexPath.section] isEqualToString:@"AuctionStart"]) {
        UILabel *label=[cell viewWithTag:100];
        self.selectedSliderValue=label;
    }
    if ([self.cellIdentifierArray[indexPath.section] isEqualToString:@"BidRecord"]) {
        NSDictionary *recordDict=self.bidRecordArray[indexPath.row];
        UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
        [imageView setImage:[UIImage imageNamed:recordDict[@"Image"]]];
        UILabel *nameLabel=(UILabel *)[cell viewWithTag:2];
        [nameLabel setText:recordDict[@"Bidder"]];
        UILabel *timeLabel=(UILabel *)[cell viewWithTag:3];
        [timeLabel setText:recordDict[@"Time"]];
        UILabel *priceLabel=(UILabel *)[cell viewWithTag:4];
        [priceLabel setText:recordDict[@"Bid"]];
        UIImageView *greenCheckBox=(UIImageView *)[cell viewWithTag:6];
        if ([(NSString *)recordDict[@"isSelected"] isEqualToString:@"YES"]) {
            [greenCheckBox setImage:[UIImage imageNamed:@"smallGreenCheck"]];
        } else
              [greenCheckBox setImage:[UIImage imageNamed:@""]];
        [priceLabel setText:recordDict[@"Bid"]];
        
        
    }
    // Configure the cell...
    
    return cell;
}




@end

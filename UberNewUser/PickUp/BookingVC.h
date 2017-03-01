//
//  BookingVC.h
//  TaxiNow
//
//  Carl's Mac on 04/11/15.
//  Copyright (c) 2015 Kc Tecnologies All rights reserved.
//

#import "BaseVC.h"

@interface BookingVC : BaseVC <UITableViewDelegate,UITableViewDataSource>
{

}
@property (weak, nonatomic) IBOutlet UITableView *tableForBooking;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)BackBtnPressed:(id)sender;

@end

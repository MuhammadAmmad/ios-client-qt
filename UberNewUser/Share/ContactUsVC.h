//
//  ShareVC.h
//  UberNew
//
//  Carl's Mac - macbook on 26/09/14.
//  Copyright (c) 2014 Kc Tecnologies All rights reserved.
//

#import "BaseVC.h"

@interface ContactUsVC : BaseVC
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSMutableArray *arrInformation;
@property (nonatomic,strong) NSDictionary *dictContent;
@property (weak, nonatomic) IBOutlet UIButton *btnNavigation;

- (IBAction)backbtnPressed:(id)sender;
@end

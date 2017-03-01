//
//  AboutVC.h
//  UberNew
//
//  Carl's Mac - macbook on 26/09/14.
//  Copyright (c) 2014 Kc Tecnologies All rights reserved.
//

#import "BaseVC.h"

@interface AboutVC : BaseVC
@property (nonatomic,strong) NSMutableArray *arrInformation;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIButton *btnNavigation;
@end

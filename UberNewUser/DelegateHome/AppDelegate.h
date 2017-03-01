//
//  AppDelegate.h
//  UberNewUser
//
//  Carl's Mac - macbook on 27/09/14.
//  Copyright (c) 2014 Kc Tecnologies All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <UserNotifications/UserNotifications.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@class MBProgressHUD,ProviderDetailsVC;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>
{
    MBProgressHUD *HUD;
    UIView *viewLoading;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ProviderDetailsVC *vcProvider;
+(AppDelegate *)sharedAppDelegate;

-(void) showHUDLoadingView:(NSString *)strTitle;
-(void) hideHUDLoadingView;
-(void)showToastMessage:(NSString *)message;

-(void)showLoadingWithTitle:(NSString *)title;
-(void)hideLoadingView;
-(id)setBoldFontDiscriptor:(id)objc;

- (void)userLoggedIn;
- (NSString *)applicationCacheDirectoryString;
- (BOOL)connected;

@end

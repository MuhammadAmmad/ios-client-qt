//
//  LoginVC.m
//  Uber
//
//  Carl's Mac - macbook on 21/06/14.
//  Copyright (c) 2014 carl MacBook Pro 1. All rights reserved.

#import "LoginVC.h"
#import "AppDelegate.h"
#import "AFNHelper.h"
#import "Constants.h"
#import "UtilityClass.h"
#import "UberStyleGuide.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

static NSString *const kKeychainItemName = @"Google OAuth2 For gglplustest";
//static NSString *const kClientID = GOOGLE_PLUS_CLIENT_ID;
//static NSString *const kClientSecret = @"aUerqYEidSMauUa1hCPVUi9A";

@interface LoginVC ()
{
    NSString *strForSocialId,*strLoginType,*strForEmail;
    AppDelegate *appDelegate;
    int reTrive;
}

@end

@implementation LoginVC

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    reTrive=0;
    [super viewDidLoad];
    [self setLocalization];
	[self.viewForBG setBackgroundColor:ProfileViewColor];
	
    [super setNavBarTitle:NSLocalizedString(@"SIGN IN", nil)];
    [super setBackBarItem];
	
	[self.btnSignIn setBackgroundColor:LightBtnColor];
	[self.backBtn setBackgroundColor:DarkBtnColor];
    strLoginType=@"manual";
    
    self.txtEmail.font=[UberStyleGuide fontRegularLight];
    self.txtPsw.font=[UberStyleGuide fontRegularLight];

    //self.btnSignIn=[APPDELEGATE setBoldFontDiscriptor:self.btnSignIn];
    self.btnForgotPsw=[APPDELEGATE setBoldFontDiscriptor:self.btnForgotPsw];
    self.btnSignUp=[APPDELEGATE setBoldFontDiscriptor:self.btnSignUp];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    [self.backBtn setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [self.backBtn setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateSelected];
   self.lblSignInWith.text = NSLocalizedString(@"SIGN IN WITH", nil);
    self.lblUsername.text = NSLocalizedString(@"USERNAME", nil);
    self.lblPassword.text = NSLocalizedString(@"PASSWORD*", nil);
    [self.btnDontHaveAccount setTitle:NSLocalizedString(@"don't account register", nil) forState:UIControlStateNormal];
    [self.btnDontHaveAccount setTitle:NSLocalizedString(@"don't account register", nil) forState:UIControlStateSelected];
}

-(void)viewWillAppear:(BOOL)animated
{
    FBSDKLoginManager *logout = [[FBSDKLoginManager alloc] init];
    [logout logOut];
    self.navigationController.navigationBarHidden=YES;
}

-(void)setLocalization
{
    self.txtEmail.placeholder=NSLocalizedString(@"Email", nil);
    self.txtPsw.placeholder=NSLocalizedString(@"Password", nil);
    [self.btnForgotPsw setTitle:NSLocalizedString(@"Forgot Password", nil) forState:UIControlStateNormal];
    [self.btnSignIn setTitle:NSLocalizedString(@"SIGN IN", nil) forState:UIControlStateNormal];
}
- (void)viewDidAppear:(BOOL)animated
{
     [self.btnSignUp setTitle:NSLocalizedString(@"SIGN IN", nil) forState:UIControlStateNormal];
}

#pragma mark -back 


- (IBAction)onClickForback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -move to direct register :

- (IBAction)onclickForMoveRegtister:(id)sender {
    
    [self performSegueWithIdentifier:SEGUE_TO_DIRCET_REGI sender:self];
    
}

#pragma mark -
#pragma mark - Actions

- (IBAction)onClickGooglePlus:(id)sender
{
	[self.navigationController setNavigationBarHidden:NO];
    /*[[AppDelegate sharedAppDelegate]showLoadingWithTitle:NSLocalizedString(@"LOGIN", nil)];
    
    if ([[GooglePlusUtility sharedObject]isLogin])
    {
        [[GooglePlusUtility sharedObject]loginWithBlock:^(id response, NSError *error)
         {
             [APPDELEGATE hideLoadingView];
             if (response) {
                 strLoginType=@"google";
                 NSLog(@"Gmail Response ->%@ ",response);
                 strForSocialId=[response valueForKey:@"userid"];
                 strForEmail=[response valueForKey:@"email"];
                 self.txtEmail.text=strForEmail;
                 [[AppDelegate sharedAppDelegate]hideLoadingView];
                 
                 [self onClickLogin:nil];
                 
             }
         }];
    }
    else
    {
        [[GooglePlusUtility sharedObject]loginWithBlock:^(id response, NSError *error)
         {
             [APPDELEGATE hideLoadingView];
             if (response) {
                 NSLog(@"Gmail Response ->%@ ",response);
                 strForSocialId=[response valueForKey:@"userid"];
                 strForEmail=[response valueForKey:@"email"];
                 self.txtEmail.text=strForEmail;
                 [[AppDelegate sharedAppDelegate]hideLoadingView];
                 
                 [self onClickLogin:nil];
                 
             }
         }];
    }*/

    strLoginType=@"google";
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"google"];
    
    NSString *scope = kGTLAuthScopePlusLogin;
    GTMOAuth2Authentication * auth = [GTMOAuth2ViewControllerTouch
                                      authForGoogleFromKeychainForName:kKeychainItemName
                                      clientID:strForGooglePlusClientId
                                      clientSecret:strForGooglePlusClientSecret];
    GTMOAuth2ViewControllerTouch *authController;
    authController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:scope
                      clientID:strForGooglePlusClientId
                      clientSecret:strForGooglePlusClientSecret
                      keychainItemName:kKeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    [[self navigationController] pushViewController:authController animated:YES];
    [auth beginTokenFetchWithDelegate:self didFinishSelector:@selector(auth:finishedRefreshWithFetcher:error:)];
}

- (void)auth:(GTMOAuth2Authentication *)auth finishedRefreshWithFetcher:(GTMHTTPFetcher *)fetcher error:(NSError *)error
{
    [self viewController:nil finishedWithAuth:auth error:error];
    if (error != nil)
    {
        NSLog(@"self .auth :%@",self.auth);
        
        NSLog(@"Authentication Error %@", error.localizedDescription);
        
        self.auth=nil;
        return;
    }
    self.auth=auth;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (error != nil)
    {
        //UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Could not login" message:[NSString stringWithFormat:@"%@",error.localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        //[alert show];
        NSLog(@"Authentication Error %@", error.localizedDescription);
        self.auth=nil;
        self.txtEmail.text = @"";
        self.txtPsw.text = @"";
        self.txtPsw.userInteractionEnabled = YES;
        [[GPPSignIn sharedInstance] signOut];
        [[GPPSignIn sharedInstance] disconnect];
        return;
    }
    else
    {
        [APPDELEGATE showLoadingWithTitle:@"Wait..."];
        self.auth=auth;
        auth.shouldAuthorizeAllRequests = YES;
        NSLog(@"login in");
        [self ForRetrive];
    }
}

-(void)ForRetrive
{
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    
    [plusService setAuthorizer:self.auth];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPerson *person,
                                NSError *error)
     {
         if (error)
         {
             GTMLoggerError(@"Error: %@", error);
         }
         else
         {
             reTrive++;
             [APPDELEGATE hideLoadingView];
             NSString *description = [NSString stringWithFormat:
                                      @"%@\n%@\n%@\n%@ Birthdate :%@ %@ %@", person.displayName,
                                      person.aboutMe,person.emails,person.birthday,person.image,person.name,person.gender];
             
             NSLog(@"response :%@",description);
             NSDictionary *dict=person.JSON;
             NSLog(@"Dict :%@",[dict valueForKey:@"emails"]);
             self.txtPsw.userInteractionEnabled = NO;
             NSMutableArray *arr=[[NSMutableArray alloc]init];
             arr=[dict valueForKey:@"emails"];
             NSDictionary *dictMain=[arr objectAtIndex:0];
             strForSocialId=[dict valueForKey:@"id"];
             strLoginType = @"google";
             NSLog(@"array  :%@",[dictMain valueForKey:@"value"]);
             strForEmail = [dictMain valueForKey:@"value"];
             NSLog(@"log for self auth :%@",self.auth);
             NSLog(@"new image :%@",person.image.url);
             if(reTrive==2)
             {
                 [appDelegate showLoadingWithTitle:NSLocalizedString(@"ALREADY_LOGIN", nil)];
				self.txtEmail.text = strForEmail;
                 [self onClickLogin:nil];
             }
         }
     }];
}
    
- (IBAction)onClickFacebook:(id)sender
{
    strLoginType=@"facebook";
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"google"];
    
    if ([APPDELEGATE connected])
    {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        
        [loginManager
         logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 [APPDELEGATE showLoadingWithTitle:@"Please wait"];
                 
                 if ([FBSDKAccessToken currentAccessToken]) {
                     
                     FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                                   initWithGraphPath:@"me"
                                                   parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}
                                                   HTTPMethod:@"GET"];
                     [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                           id result,
                                                           NSError *error) {
                         NSLog(@"%@",result);
                         // Handle the result
                         [APPDELEGATE hideLoadingView];
                         
                         self.txtEmail.text=[result valueForKey:@"email"];
                         
                         strForSocialId=[result valueForKey:@"id"];
                         strForEmail=[result valueForKey:@"email"];
                         self.txtEmail.text=strForEmail;
                         [[AppDelegate sharedAppDelegate]hideLoadingView];
                         
                         [self onClickLogin:nil];
                     }];
                 }
             }
         }];
        
        [loginManager logOut];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NO_INTERNET_TITLE", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

-(IBAction)onClickLogin:(id)sender
{
    if([[AppDelegate sharedAppDelegate]connected])
    {
        if(self.txtEmail.text.length>0)
        {
            [[AppDelegate sharedAppDelegate]showLoadingWithTitle:NSLocalizedString(@"LOGIN", nil)];
            
            NSString *strDeviceId=[PREF objectForKey:PREF_DEVICE_TOKEN];
            
            if (strDeviceId==nil || [strDeviceId isEqualToString:@""] || [strDeviceId isKindOfClass:[NSNull class]] || strDeviceId.length < 1)
            {
                strDeviceId=@"11111";
            }
            
            NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
            [dictParam setValue:@"ios" forKey:PARAM_DEVICE_TYPE];
            [dictParam setValue:strDeviceId forKey:PARAM_DEVICE_TOKEN];
            if([strLoginType isEqualToString:@"manual"])
                [dictParam setValue:self.txtEmail.text forKey:PARAM_EMAIL];
             else
                 [dictParam setValue:strForEmail forKey:PARAM_EMAIL];
            
            [dictParam setValue:strLoginType forKey:PARAM_LOGIN_BY];
            
            if([strLoginType isEqualToString:@"facebook"])
                [dictParam setValue:strForSocialId forKey:PARAM_SOCIAL_UNIQUE_ID];
            else if ([strLoginType isEqualToString:@"google"])
                [dictParam setValue:strForSocialId forKey:PARAM_SOCIAL_UNIQUE_ID];
            else
                [dictParam setValue:self.txtPsw.text forKey:PARAM_PASSWORD];
            
            AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
            [afn getDataFromPath:FILE_LOGIN withParamData:dictParam withBlock:^(id response, NSError *error)
             {
                 [[AppDelegate sharedAppDelegate]hideLoadingView];
                 
                 NSLog(@"Login Response ---> %@",response);
                 if (response)
                 {
                     if([[response valueForKey:@"success"]boolValue])
                     {
                         NSString *strLog=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"LOGIN_SUCCESS", nil),[response valueForKey:@"first_name"]];
                         
                         [APPDELEGATE showToastMessage:strLog];
                         
                         stripePublishableKey = [NSString stringWithFormat:@"%@",[response valueForKey:@"stripe_publishable_key"]];
                         
                         [PREF setObject:response forKey:PREF_LOGIN_OBJECT];
                         [PREF setObject:[response valueForKey:@"token"] forKey:PREF_USER_TOKEN];
                         [PREF setObject:[response valueForKey:@"id"] forKey:PREF_USER_ID];
                         [PREF setObject:[response valueForKey:@"is_referee"] forKey:PREF_IS_REFEREE];
                         [PREF setObject:stripePublishableKey forKey:@"stripe_key"];
                         [PREF setBool:YES forKey:PREF_IS_LOGIN];
                         
                         [PREF synchronize];
                         
                         [self performSegueWithIdentifier:SEGUE_SUCCESS_LOGIN sender:self];
                     }
                     else
                     {
						strLoginType = @"manual";
						self.txtEmail.text = @"";
						self.txtPsw.text = @"";
						self.txtPsw.userInteractionEnabled = YES;
						for (NSArray *arr in [response valueForKey:@"error_messages"]) {
							NSString *str=[NSString stringWithFormat:@"%@",arr];
							UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[afn getErrorMessage:str] delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
							[alert show];
							break;
						}
					 reTrive-- ;
					 }
                 }
             }];
        }
        else
        {
            if(self.txtEmail.text.length==0)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"PLEASE_EMAIL", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"PLEASE_PASSWORD", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Network Status", nil) message:NSLocalizedString(@"NO_INTERNET", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [alert show];
    }
}

-(IBAction)onClickForgotPsw:(id)sender
{
    [self textFieldShouldReturn:self.txtPsw];
    /*
    if (self.txtEmail.text.length==0)
    {
        [[UtilityClass sharedObject]showAlertWithTitle:@"" andMessage:@"Enter your email id."];
        return;
    }
    else if (![[UtilityClass sharedObject]isValidEmailAddress:self.txtEmail.text])
    {
        [[UtilityClass sharedObject]showAlertWithTitle:@"" andMessage:@"Enter valid email id."];
        return;
    }
     */
}

#pragma mark -
#pragma mark - TextField Delegate
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;
{
    [self.txtEmail resignFirstResponder];
    [self.txtPsw resignFirstResponder];
	[self.scrLogin setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    int y=0;
    if (textField==self.txtEmail)
    {
        y=140;
    }
    else if (textField==self.txtPsw){
        y=160;
    }
    [self.scrLogin setContentOffset:CGPointMake(0, y) animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtEmail)
    {
        [self.txtPsw becomeFirstResponder];
    }
    else if (textField==self.txtPsw){
        [textField resignFirstResponder];
        [self.scrLogin setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

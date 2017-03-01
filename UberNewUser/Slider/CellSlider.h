//
//  CellSlider.h
//  UberNewUser
//
//  Carl's Mac - macbook on 30/09/14.
//  Copyright (c) 2014 Kc Tecnologies All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellSlider : UITableViewCell
{
    id cellData;
    id cellParent;
}
@property(nonatomic,weak)IBOutlet UIImageView *imgIcon;
@property(nonatomic,weak)IBOutlet UILabel *lblName;

-(void)setCellData:(id)data withParent:(id)parent;

@end

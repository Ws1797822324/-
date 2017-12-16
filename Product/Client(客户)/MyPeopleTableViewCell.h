//
//  MyPeopleTableViewCell.h
//  Product
//
//  Created by HJ on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPeopleTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *addressLabel;
    @property (weak, nonatomic) IBOutlet UILabel *telLabel;
    
@end

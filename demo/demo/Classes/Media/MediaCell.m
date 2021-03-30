//
//  MediaCell.m
//  demo
//
//  Created by irons on 2021/3/30.
//

#import "MediaCell.h"

@interface MediaCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation MediaCell

- (void)configureWithTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end

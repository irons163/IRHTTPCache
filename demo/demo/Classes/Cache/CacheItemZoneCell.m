//
//  CacheItemZoneCell.m
//  demo
//
//  Created by irons on 2021/3/30.
//

#import "CacheItemZoneCell.h"

@interface CacheItemZoneCell ()

@property (nonatomic, weak) IBOutlet UILabel *offsetLabel;
@property (nonatomic, weak) IBOutlet UILabel *lengthLabel;

@end

@implementation CacheItemZoneCell

- (void)configureWithOffset:(long long)offset length:(long long)length
{
    self.offsetLabel.text = [NSString stringWithFormat:@"Offset : %lld", offset];
    self.lengthLabel.text = [NSString stringWithFormat:@"Length : %lld", length];
}

@end

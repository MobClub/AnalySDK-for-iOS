//
//  MLDShoppingCollectionViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDShoppingCollectionViewCell.h"
#import "UILabel+MLDLabel.h"

@interface MLDShoppingCollectionViewCell()

@property (assign, nonatomic) CGRect frame;
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *priceLabel;
@property (weak, nonatomic) UILabel *countLabel;

@end

@implementation MLDShoppingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = frame;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageV = imageV;
        [self.contentView addSubview:imageV];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.numberOfLines = 1;
        [self.contentView addSubview:titleLabel];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        self.priceLabel = priceLabel;
        CGFloat b = (0xEC6159 & 0xff) / 255.0;
        CGFloat g = (0xEC6159 >> 8 & 0xff) / 255.0;
        CGFloat r = (0xEC6159 >> 16 & 0xff) / 255.0;
        
        priceLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        priceLabel.font = [UIFont systemFontOfSize:13];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:priceLabel];
        
        UILabel *countLabel = [[UILabel alloc] init];
        self.countLabel = countLabel;
        CGFloat b1 = (0xA4A4A4 & 0xff) / 255.0;
        CGFloat g1 = (0xA4A4A4 >> 8 & 0xff) / 255.0;
        CGFloat r1 = (0xA4A4A4 >> 16 & 0xff) / 255.0;
        countLabel.textColor = [UIColor colorWithRed:r1 green:g1 blue:b1 alpha:1];
        countLabel.font = [UIFont systemFontOfSize:11];
        countLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:countLabel];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    NSString *imageName = dict[@"image"];
    self.imageV.image = FileImage(imageName);
    self.imageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 50);
    
    NSString *title = dict[@"title"];
    self.titleLabel.text = title;
    CGFloat titleH = [UILabel getHeightByWidth:self.frame.size.width title:@"测试" font:[UIFont systemFontOfSize:13]];
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame) + 10, self.frame.size.width, titleH);
    
    NSString *price = dict[@"price"];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", price];
    self.priceLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, self.frame.size.width, 0);
    [self.priceLabel sizeToFit];
    
    NSString *count = dict[@"count"];
    self.countLabel.text = [NSString stringWithFormat:@"月销%@", count];
    self.countLabel.frame = CGRectMake(0, self.priceLabel.frame.origin.y, self.frame.size.width, self.priceLabel.frame.size.height);
}

@end

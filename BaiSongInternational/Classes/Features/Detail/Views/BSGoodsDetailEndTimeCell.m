//
//  BSGoodsDetailEndTimeCell.m
//  BaiSongInternational
//
//  Created by 马启晗 on 2017/8/31.
//  Copyright © 2017年 maqihan. All rights reserved.
//

#import "BSGoodsDetailEndTimeCell.h"

@interface BSGoodsDetailEndTimeCell()
{
    int hours;         //时
    int minutes;       //分
    float seconds;     //秒
}

@property (strong , nonatomic) UIImageView *timeImage;
@property (strong , nonatomic) UILabel     *time;
@property (strong , nonatomic) UIView      *line;

@property (strong , nonatomic) NSTimer *timer;

@end
@implementation BSGoodsDetailEndTimeCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * cellId = @"BSGoodsDetailEndTimeCellID";
    BSGoodsDetailEndTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[BSGoodsDetailEndTimeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self.contentView addSubview:self.timeImage];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.line];
        
        [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@12);
            make.width.equalTo(@12);
        }];
        
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeImage.mas_right).offset(8);
            make.centerY.equalTo(self.timeImage.mas_centerY);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.left.equalTo(self.contentView.mas_left).offset(17);
        }];
        
    }
    return self;
}

- (void)removeFromSuperview
{
    //取消定时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [super removeFromSuperview];
    
}

- (void)setGoods:(BSGoods *)goods
{
    _goods = goods;
    
    if (goods.modetype.intValue == PublishType_Oneoff) {
        //一口价不需要倒计时
        self.time.hidden = YES;
        self.timeImage.hidden = YES;
        self.line.hidden = YES;
        return;
    }
    
    
    if (goods.is_sale.intValue == 0) {
        //商品已经结束
        [self stopTimer];
    }else{
        //将时间戳转化为整数
        [self timeTransformTimeStr:goods.down_time];
        //开启跑秒
        [self startTimer];
    }
}

//开启计时器
- (void)startTimer
{
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(clockCounterRunning:) userInfo:nil repeats:YES];
        //有他能够使倒计时忽略界面滑动的影响
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

//停止计时器
- (void)stopTimer
{
    //取消定时器
    [self.timer invalidate];
    self.timer = nil;
    
    self.time.text = [BSLocalizedString(@"time.left") stringByAppendingString:@":00 00' 00‘’"];
}

- (void)clockCounterRunning:(NSTimer *)timer
{
    seconds = seconds - 0.1;
    
    if (seconds < 0) {
        seconds = 60;
        minutes = minutes - 1;
        
        if (minutes < 0) {
            minutes = 60;
            hours = hours - 1;
            
            if (hours < 0) {
                [self stopTimer];
                return;
            }
        }
    }
    
    self.time.text = [NSString stringWithFormat:@"%@：%02d %02d' %04.1f''",BSLocalizedString(@"time.left"),hours,minutes,seconds];
}

//将时间戳转化
- (void)timeTransformTimeStr:(NSString *)timeStr
{
    NSDate *endDate     = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    //时间间隔
    NSTimeInterval elapsedTime = [endDate timeIntervalSinceNow];
    
    div_t h = div(elapsedTime, 3600);
    div_t m = div(h.rem, 60);//rem余数
    
    hours = h.quot;//quot 商
    minutes = m.quot;
    seconds = (float)m.rem;
}


-(UIImageView *)timeImage
{
    if (!_timeImage) {
        _timeImage = [[UIImageView alloc] init];
        _timeImage.contentMode = UIViewContentModeScaleAspectFit;
        _timeImage.image = [UIImage imageNamed:@"goods_detail_time"];
    }
    return _timeImage;
}

- (UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor colorWithHexString:@"4b4b4b"];
        _time.font = [UIFont systemFontOfSize:14];
    }
    return _time;
}


- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BSCOLOR_F3F3F3;
    }
    return _line;
}

@end

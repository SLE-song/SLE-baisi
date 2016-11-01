//
//  SLETopicVoiceView.m
//  百思不得姐
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLETopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "SLETopic.h"
#import "SLEShowPictureController.h"


@class DOUAudioFile;
@interface SLETopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;

@end

@implementation SLETopicVoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)sle_voiceView
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
    
}

- (void)setTopic:(SLETopic *)topic
{

    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger second = topic.voicetime % 60;
    NSInteger minute = topic.voicetime / 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}


- (void)awakeFromNib
{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    SLEShowPictureController *showPicture = [[SLEShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
    
    
}





- (IBAction)playVoice:(UIButton *)button {
    
//    button.selected = !button.selected;
//    
//    if (button.selected) {
////        self.player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.topic.voiceuri]] error:nil];
//        [self.player play];
//        
//    }else{
//        
//        [self.player pause];
//    }
//    
}



@end

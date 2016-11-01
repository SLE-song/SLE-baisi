//
//  SLETopicVideoView.m
//  
//
//  Created by apple on 16/7/30.
//
//

#import "SLETopicVideoView.h"
#import "SLETopic.h"
#import <UIImageView+WebCache.h>
#import "SLEShowPictureController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SLETopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;


@end


@implementation SLETopicVideoView


+ (instancetype)sle_videoView
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
    
}

- (void)setTopic:(SLETopic *)topic
{
    
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger second = topic.videotime % 60;
    NSInteger minute = topic.videotime / 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
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


- (IBAction)play:(id)sender {
    
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}


@end

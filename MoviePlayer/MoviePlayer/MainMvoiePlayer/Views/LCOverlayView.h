//
//  LCOverlayView.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "LCTransport.h"
#import "LCFilmstripView.h"

@interface LCOverlayView : UIView<LCTransport>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *filmstripToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *togglePlaybackButton;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *scrubberSlider;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *scrubbingTimeLabel;

@property (weak, nonatomic) IBOutlet LCFilmstripView *filmStripView;

@property (weak, nonatomic) id <LCTransportDelegate> delegate;

- (IBAction)toggleFilmstrip:(id)sender;
- (IBAction)toggleControls:(id)sender;
- (IBAction)togglePlayback:(UIButton *)sender;
- (IBAction)closeWindow:(id)sender;
- (void)setCurrentTime:(NSTimeInterval)time;

@end

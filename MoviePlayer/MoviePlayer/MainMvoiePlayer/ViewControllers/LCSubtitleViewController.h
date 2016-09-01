//
//  LCSubtitleViewController.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCSubtitleViewControllerDelegate <NSObject>
- (void)subtitleSelected:(NSString *)subtitle;
@end

@interface LCSubtitleViewController : UIViewController

- (id)initWithSubtitles:(NSArray *)subtitles;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *selectedSubtitle;
@property (weak, nonatomic) id<LCSubtitleViewControllerDelegate> delegate;
- (IBAction)close:(id)sender;


@end

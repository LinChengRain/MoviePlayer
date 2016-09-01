//
//  LCSubtitleViewController.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "LCSubtitleViewController.h"

@interface LCSubtitleViewController ()
@property (strong, nonatomic) NSArray *subtitles;
@end

@implementation LCSubtitleViewController

-(id)initWithSubtitles:(NSArray *)subtitles
{
    self = [super initWithNibName:@"THSubtitleView" bundle:nil];
    if (self) {
        _subtitles = subtitles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subtitles.count;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *subtitle = self.subtitles[indexPath.row];
    cell.textLabel.text = subtitle;
    if ([subtitle isEqualToString:self.selectedSubtitle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedSubtitle = self.subtitles[indexPath.row];
    [self.tableView reloadData];
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)close:(id)sender {
    [self.delegate subtitleSelected:self.selectedSubtitle];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

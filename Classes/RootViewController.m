//
//  RootViewController.m
//  aurioTouch2
//
//  Created by Littlebox222 on 13-11-22.
//
//

#import "RootViewController.h"
#import <stdio.h>
#import "PCMRender.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize audioPlayer = _audioPlayer;

- (void)dealloc {
    
    [_audioPlayer release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
#ifdef __IPHONE_7_0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playButton.frame = CGRectMake(150, 350, 80, 40);
    playButton.backgroundColor = [UIColor redColor];
    playButton.titleLabel.text = @"play";
    [playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:playButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playAction:(id)sender
{
    NSData *pcmData = [PCMRender renderChirpData:@"abcdefghijklmnopqrstuv"];
    
    NSError *error;
    self.audioPlayer = [[[AVAudioPlayer alloc] initWithData:pcmData
                                                     error:&error] autorelease];
    
    if (error) {
        NSLog(@"error....%@",[error localizedDescription]);
    }else{
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
    }
    
    [self.audioPlayer play];
}

#pragma mark - AVAudioPlayerDelegate <NSObject>

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

/* audioPlayerBeginInterruption: is called when the audio session has been interrupted while the player was playing. The player will have been paused. */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    
}

/* audioPlayerEndInterruption: is called when the preferred method, audioPlayerEndInterruption:withFlags:, is not implemented. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    
}

@end
//
//  ViewController.h
//  iAlfa
//
//  Created by Sasko Ristov on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

UIImageView * ryuJump;

@interface ViewController : UIViewController <CLLocationManagerDelegate,UITextFieldDelegate,UIAccelerometerDelegate>
{
    AVAudioPlayer *audioPlayer;
    IBOutlet UILabel *label;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    IBOutlet UIButton *dugme;
    IBOutlet UITextField *fild;
    IBOutlet UITextField *fild2;
    IBOutlet UITextField *fild3;
    IBOutlet UIImageView *staticnaSlika;
    IBOutlet UIButton *btnReset;
    
}
    
@property (weak, nonatomic) IBOutlet UIButton *Button;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * text2;
@property (nonatomic,retain) CLLocationManager *myLocation;
@property (nonatomic, retain) UIAccelerometer *speed;
@property (nonatomic) float velX;
@property (nonatomic) float velY;
@property (nonatomic) float velZ;
@property (nonatomic) float distX;
@property (nonatomic) float distY;
@property (nonatomic) float distZ;
@property (nonatomic) int intervalDate;
@property (nonatomic) double distance;
@property (nonatomic) float x,y;
@property (nonatomic) BOOL isFirst,isStart;
@property (nonatomic) float distanceGPS,brzina;
@property (nonatomic, retain) NSTimer *timer; 
@property (strong, nonatomic) IBOutlet UIImageView *slika;




- (IBAction)neDiraj:(id)sender;

- (IBAction)Start:(id)sender;
- (IBAction)polje:(id)sender;
- (IBAction)restartKopce:(id)sender;


@end

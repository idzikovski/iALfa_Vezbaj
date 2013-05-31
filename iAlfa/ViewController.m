//
//  ViewController.m
//  iAlfa
//
//  Created by Sasko Ristov on 12/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize slika;
@synthesize Button;
@synthesize text;
@synthesize text2;
@synthesize myLocation;
@synthesize  velX,velY,velZ,distX,distY,distZ,intervalDate,distance;
@synthesize x,y,isFirst;
@synthesize distanceGPS;
@synthesize timer,speed;
@synthesize brzina;
@synthesize isStart;




- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIAccelerometer sharedAccelerometer].delegate=self;
    intervalDate=1;
    isFirst=YES;
    isStart=NO;
    distanceGPS=0;
    brzina=0;
    [label3 setText:[NSString stringWithFormat:@"%f m",distanceGPS]];
    [label setText: [NSString stringWithFormat:@"%f m/s", brzina]];
    [label2 setText:[NSString stringWithFormat:@"0.000000 0.000000"]];
    [staticnaSlika setHidden:NO];
    
    //   timer= [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector) userInfo:<#(id)#> repeats:<#(BOOL)#>
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setButton:nil];
    [self setSlika:nil];
    [super viewDidUnload];
    
    [self.navigationItem setTitle:@"adads"];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    velX += (acceleration.x * intervalDate);

    distX += (velX * intervalDate);
    
    
    velY += (acceleration.y * intervalDate);
    distY += (velY * intervalDate);
    
    velZ += (acceleration.z * intervalDate);
    distZ += (velZ * intervalDate);
    distance = sqrt( distX*distX + distY*distY + distZ*distZ );
    
    NSLog(@"%f",distance);
  //  [label setText:[NSString stringWithFormat:@"%.2f", distance]];
 
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    x=newLocation.coordinate.latitude;
    y=newLocation.coordinate.longitude;
    if(isFirst){
        isFirst=NO;
    }
    else {
        //distanceGPS+=sqrt( (pow((x-y), 2) + pow((newLocation.coordinate.latitude-newLocation.coordinate.longitude), 2)))/1000;
        
        distanceGPS+=[newLocation distanceFromLocation:oldLocation];
        
        brzina=newLocation.speed;
        [label3 setText:[NSString stringWithFormat:@"%f m",distanceGPS]];
        [label setText: [NSString stringWithFormat:@"%f m/s", brzina]];
        [label2 setText:[NSString stringWithFormat:@"%f %f", newLocation.coordinate.latitude,newLocation.coordinate.longitude]];
        
    }
    
    
    
    NSLog(@"%f %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
       
}
- (IBAction)text:(id)sender {
   // NSArray *niza = [[NSArray alloc] initWithObjects:[NSDate date], nil];
   // NSDate *date = [niza objectAtIndex:0];
    
    
}
- (void)neDiraj:(id)sender{
    //[label setText:@"Ti rekoh da ne diras"];
    
    
    [staticnaSlika setHidden:NO];
    [slika stopAnimating];    
    [myLocation stopUpdatingLocation];
    [dugme setEnabled:YES];
    [audioPlayer pause];

}

-(void)restart
{
    //myLocation=nil;
    [myLocation stopUpdatingLocation];
    [staticnaSlika setHidden:NO];
    [slika stopAnimating];
    [dugme setEnabled:YES];
    
    [audioPlayer stop];
    
    
    [self viewDidLoad];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)Start:(id)sender
{
    //[label setText:@"Neki tekst"];}
    
//    isStart=YES;
    
    [dugme setEnabled:NO];
    
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/I get knocked down.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.numberOfLoops = -1;
	
	if (audioPlayer != nil)
				[audioPlayer play];
    
    
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
    
    
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"1.png"],
                             [UIImage imageNamed:@"2.png"],
                             [UIImage imageNamed:@"3.png"],
                             [UIImage imageNamed:@"4.png"],
                             [UIImage imageNamed:@"5.png"],
                             [UIImage imageNamed:@"6.png"],
                             [UIImage imageNamed:@"7.png"],
                             [UIImage imageNamed:@"8.png"],
                             [UIImage imageNamed:@"9.png"],
                             [UIImage imageNamed:@"10.png"],
                             [UIImage imageNamed:@"11.png"],
                             [UIImage imageNamed:@"12.png"],
                             [UIImage imageNamed:@"13.png"],
                             [UIImage imageNamed:@"14.png"],
                             [UIImage imageNamed:@"15.png"],
                             [UIImage imageNamed:@"16.png"],
                             nil];
    slika = [[UIImageView alloc] initWithFrame:
             CGRectMake(80, 225, 150, 130)];
    slika.animationImages=imageArray;
    slika.animationDuration=1.1;
    slika.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:slika];
    [slika startAnimating];
    
    [staticnaSlika setHidden:YES];   
    
    myLocation=[[CLLocationManager alloc] init];
    [myLocation setDelegate:self];
    [myLocation setDesiredAccuracy:kCLLocationAccuracyBest];
    [myLocation setDistanceFilter:kCLDistanceFilterNone];
    [myLocation startUpdatingLocation];
    
    
}
    
- (void)polje:(id)sender
{
   
    NSString *str=@"Zdravo";
//    NSMutableString
    str=[str stringByAppendingFormat:@" Brate"];
    [fild setText:str];
}

- (IBAction)restartKopce:(id)sender {
    [self restart];
}


@end

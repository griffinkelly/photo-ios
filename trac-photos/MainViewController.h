//
//  MainViewController.h
//  Goldfinch
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "TracPhotoView.h"
#import "TracRaceButton.h"
#import "Trac.h"
#import "TracCreatePhotoView.h"
#import <AVFoundation/AVFoundation.h>

@class MainViewController;
@protocol MainDelegate <NSObject>

@optional
@required
- (void)gotoProfile;

@end

@interface MainViewController : UIViewController <TapDelegate, TracRaceDelegate, UITextFieldDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, TracCreateDelegate>
{
    CGFloat width;
    CGFloat height;
    CGFloat photoSize;
    UIView* header;
    UIScrollView* scroll;
    UIScrollView* raceScroll;
    UIView* filterHeader;
    UITextField* searchField;
    UIView* overlay;
    UIImageView* image;
    Button* closeImage;
    Button* saveImage;
    UIButton* profileButton;
    UIButton* searchButton;
    UIButton* bibSearchButton;
    UIButton* raceButton;
    UILabel* filterLabel;
    
    NSMutableArray* mainPhotoArray;
    NSMutableArray* races;
    NSMutableArray* raceButtons;
    NSString* filter;
    Trac* trac;
    TracRace* race;
    
    UIImage* temp;
    UIImageView* img;
    BOOL posting;
    AVCaptureSession *session;
    UIButton* postImg;
    UIButton* photoLibrary;
    UIButton* cancel;
    UIActivityIndicatorView *spinner;
    TracCreatePhotoView* createPhoto;
    BOOL raceOut;
    BOOL refreshing;
    int photoCount;
    int page;
}

@property (nonatomic, retain) id <MainDelegate> delegate;

- (void)addToMain:(NSMutableArray*) photos;

- (void)addToSecondary:(NSMutableArray*) photos;

- (void)addToRaces:(NSMutableArray*) _races;

-(void)setFilter:(NSString*)_filter;

-(void)injectTrac:(Trac*)_trac;

-(void)profileOut;

@end

//
//  MainViewController.m
//  Goldfinch
//
//  Created by Nick Schulze on 4/22/16.
//  Copyright © 2016 Nick Schulze. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        UIScreen* main = [UIScreen mainScreen];
        width = main.bounds.size.width;
        height = main.bounds.size.height;
        
        self.view.frame = CGRectMake(0, 0, width, height);
        self.view.backgroundColor = [UIColor white];
        
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
        header.backgroundColor = [UIColor white];
        header.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        header.layer.shadowOpacity = .2;
        header.layer.shadowOffset = CGSizeMake(3, 2);
        header.layer.masksToBounds = NO;
        header.clipsToBounds = NO;
        [self.view addSubview:header];
        
        UIView* hline = [[UIView alloc] initWithFrame:CGRectMake(0, 62, width, 2)];
        hline.backgroundColor = [UIColor blue];
        [header addSubview:hline];
    
        raceScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, 44)];
        raceScroll.backgroundColor = [UIColor blue];
        [raceScroll setContentSize:CGSizeMake(width, 44)];
        raceScroll.clipsToBounds = YES;
        [raceScroll setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:raceScroll];
        
        UIView* rline = [[UIView alloc] initWithFrame:CGRectMake(0, 106, width, 2)];
        rline.backgroundColor = [UIColor white];
        [self.view addSubview:rline];
        
        filterHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 64, width, 44)];
        filterHeader.backgroundColor = [UIColor white];
        filterHeader.alpha = 0.0;
        [self.view addSubview:filterHeader];
        
        filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 34)];
        filterLabel.backgroundColor = [UIColor blue];
        filterLabel.layer.cornerRadius = 17;
        [filterLabel setTextAlignment:NSTextAlignmentCenter];
        [filterLabel setTextColor:[UIColor white]];
        [filterLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.0]];

        [filterHeader addSubview:filterLabel];
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, height-64)];
        scroll.backgroundColor = [UIColor lightOrange];
        scroll.clipsToBounds = YES;
        [scroll setShowsVerticalScrollIndicator:NO];
        [scroll setDelegate:self];
        [self.view addSubview:scroll];
        
        UIButton* test = [[UIButton alloc] initWithFrame:CGRectMake((width/2)-32, height-74, 64, 64)];
        test.backgroundColor = [UIColor white];
        test.layer.borderWidth = 1;
        test.layer.borderColor = [UIColor orange].CGColor;
        test.layer.cornerRadius = 32;
        test.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        test.layer.shadowOpacity = .5;
        test.layer.shadowOffset = CGSizeMake(3, 2);
        test.layer.masksToBounds = NO;
        test.clipsToBounds = NO;
        [test addTarget:self action:@selector(setupCaptureSession) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:test];
        
        UIImageView* test_img = [[UIImageView alloc] initWithFrame:CGRectMake(14, 17, 36, 30)];
        [test_img setBackgroundColor:[UIColor clearColor]];
        [test_img setImage:[UIImage imageNamed:@"camera_2.png"]];
        [test addSubview:test_img];
        
        profileButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
        [profileButton setBackgroundColor:[UIColor white]];
        [profileButton addTarget:self action:@selector(profile) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:profileButton];

        UIImageView* profile_img = [[UIImageView alloc] initWithFrame:CGRectMake(12, 18, 26, 26)];
        [profile_img setBackgroundColor:[UIColor clearColor]];
        [profile_img setImage:[UIImage imageNamed:@"hamburger.png"]];
        [profileButton addSubview:profile_img];
        
        searchButton = [[UIButton alloc] initWithFrame:CGRectMake(width-50, 0, 44, 44)];
        [searchButton setBackgroundColor:[UIColor clearColor]];
        [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        searchButton.alpha = 0.0;
        [filterHeader addSubview:searchButton];
        
        UIImageView* search_img = [[UIImageView alloc] initWithFrame:CGRectMake(12, 9, 26, 26)];
        [search_img setBackgroundColor:[UIColor clearColor]];
        [search_img setImage:[UIImage imageNamed:@"search_2.png"]];
        [searchButton addSubview:search_img];
        
        searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
        searchField.backgroundColor = [UIColor lightGray];
        searchField.alpha = 0.0;
        [searchField setDelegate:self];
        [filterHeader addSubview:searchField];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        searchField.leftView = paddingView;
        searchField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView* fline = [[UIView alloc] initWithFrame:CGRectMake(0, 42, width, 2)];
        fline.backgroundColor = [UIColor blue];
        [filterHeader addSubview:fline];
        
        bibSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(width-76, 4, 70, 34)];
        [bibSearchButton setBackgroundColor:[UIColor blue]];
        [bibSearchButton addTarget:self action:@selector(bibSearch) forControlEvents:UIControlEventTouchUpInside];
        [bibSearchButton setTitle:@"Search" forState:UIControlStateNormal];
        bibSearchButton.layer.cornerRadius = 5;
        bibSearchButton.alpha = 0.0;
        [filterHeader addSubview:bibSearchButton];
        
        raceButton = [[UIButton alloc] initWithFrame:CGRectMake(width-50, 10, 50, 50)];
        [raceButton setBackgroundColor:[UIColor white]];
        [raceButton addTarget:self action:@selector(races) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:raceButton];
        
        UIImageView* race_img = [[UIImageView alloc] initWithFrame:CGRectMake(7, 14, 32, 32)];
        [race_img setBackgroundColor:[UIColor clearColor]];
        [race_img setImage:[UIImage imageNamed:@"search_2.png"]];
        [raceButton addSubview:race_img];
        
        CGFloat buttonW = 36*5.89;
        UIImageView* logo_img = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-buttonW/2, 20, buttonW, 36)];
        [logo_img setBackgroundColor:[UIColor clearColor]];
        [logo_img setImage:[UIImage imageNamed:@"flashbanner.png"]];
        [header addSubview:logo_img];
        
        overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        overlay.backgroundColor = [UIColor black];
        overlay.alpha = .0;
        overlay.hidden = YES;
        [self.view addSubview:overlay];
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, width-40, height-40)];
        [image setBackgroundColor:[UIColor clearColor]];
        [image setImage:[UIImage imageNamed:@"tyler.jpg"]];
        image.layer.cornerRadius = 5;
        image.alpha = 0.0;
        image.layer.masksToBounds = YES;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:image];
        
        closeImage = [[Button alloc] initHeaderTextButton:@"Close" atX:width-80 atY:20];
        [closeImage addTarget:self action:@selector(closeImage) forControlEvents:UIControlEventTouchUpInside];
        [closeImage setTitleColor:[UIColor white] forState:UIControlStateNormal];
        closeImage.alpha = 0.0;
        [self.view addSubview:closeImage];
        
        saveImage = [[Button alloc] initMainButton:@"Save Photo" atY:height-74];
        [saveImage addTarget:self action:@selector(closeImage) forControlEvents:UIControlEventTouchUpInside];
        saveImage.alpha = 0.0;
//        [self.view addSubview:saveImage];
        
        img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        img.hidden = YES;
        [self.view addSubview:img];
        
        postImg = [[UIButton alloc] initWithFrame:CGRectMake((width/2)-50, height-110, 100, 100)];
        postImg.backgroundColor = [UIColor blue];
        postImg.layer.cornerRadius = 50;
        [postImg addTarget:self action:@selector(startPostImage) forControlEvents:UIControlEventTouchUpInside];
        postImg.hidden = YES;
        postImg.layer.borderColor = [UIColor white].CGColor;
        postImg.layer.borderWidth = 15;
        [self.view addSubview:postImg];
        
        photoLibrary = [[UIButton alloc] initWithFrame:CGRectMake(10, height-50, 80, 40)];
        photoLibrary.backgroundColor = [UIColor blue];
        photoLibrary.layer.cornerRadius = 5;
        [photoLibrary addTarget:self action:@selector(libraryImage) forControlEvents:UIControlEventTouchUpInside];
        photoLibrary.hidden = YES;
        [photoLibrary setTitle:@"Library" forState:UIControlStateNormal];
        [self.view addSubview:photoLibrary];
        
        cancel = [[Button alloc] initHeaderTextButton:@"Cancel" atX:10 atY:10];
        [cancel addTarget:self action:@selector(cancelCapture) forControlEvents:UIControlEventTouchUpInside];
        [cancel setTitleColor:[UIColor white] forState:UIControlStateNormal];
        cancel.hidden = YES;
        [self.view addSubview:cancel];
        
        photoSize = 0;
        
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame = CGRectMake(width/2-12, 8, 24, 24);
        [scroll addSubview:spinner];
        [spinner startAnimating];
        
        createPhoto = [[TracCreatePhotoView alloc] init];
        [createPhoto setDelegate:self];
        [self.view addSubview:createPhoto];
        
        raceOut = NO;
        page = 0;
    }
    return self;
}

- (void)addToMain:(NSMutableArray*) photos
{
    photoSize = 0;
    page = 0;
    
    mainPhotoArray = photos;
    for (int i = 0; i < [photos count]; i++)
    {
        TracPhoto* _photo = [photos objectAtIndex:i];
        
        if  (_photo != nil && [_photo url] != nil && ![[_photo url] isEqual:[NSNull null]])
        {
            TracPhotoView* photo = [[TracPhotoView alloc] init];
            [photo fillWith:[photos objectAtIndex:i]];
            [photo shift:photoCount];
            [photo setDelegate:self];
            [scroll addSubview:photo];
            
            photoSize += (width-20)+10;
            photoCount++;
        }
    }
    
    [scroll setContentSize:CGSizeMake(width, photoSize+10)];
    [spinner stopAnimating];
}

- (void)addToSecondary:(NSMutableArray*) photos
{
    page ++;
    refreshing = NO;
    if  (photoCount == 0)
    {
        photoSize = 0;
        [[scroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < [photos count]; i++)
    {
        TracPhoto* _photo = [photos objectAtIndex:i];
        if  (_photo != nil && [_photo url] != nil && ![[_photo url] isEqual:[NSNull null]])
        {
            TracPhotoView* photo = [[TracPhotoView alloc] init];
            [photo fillWith:[photos objectAtIndex:i]];
            [photo shift:photoCount];
            [photo setDelegate:self];
            [scroll addSubview:photo];
            
            photoSize += (width-20)+10;
            photoCount++;
        }
    }
    
    [scroll setContentSize:CGSizeMake(width, photoSize+10)];
    [spinner stopAnimating];
}

- (void)addToRaces:(NSMutableArray*) _races
{
    races = _races;
    raceButtons = [[NSMutableArray alloc] initWithCapacity:[races count]];
    
    CGFloat buttonCursor = 10;
    for (int i = 0; i < [races count]; i++)
    {
        TracRace* raceB = [races objectAtIndex:i];

        TracRaceButton* button = [[TracRaceButton alloc] initWithTracRace:raceB];
        [button shift:buttonCursor];
        [raceScroll addSubview:button];
        [raceButtons addObject:button];
        [button setDelegate:self];
        
        buttonCursor+=[button buttonWidth]+10;
    }
    
    raceScroll.contentSize = CGSizeMake(buttonCursor+10, 44);
    [createPhoto addToRaces:races];
}

- (void)setRace:(TracRace*)_race;
{
    race = _race;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:18]};
    CGSize raceName = [[race name] sizeWithAttributes:attributes];
    CGFloat labelWidth = raceName.width+20;
    
    filterLabel.frame = CGRectMake((width-labelWidth)/2, 5, labelWidth, 34);
    [filterLabel setText:[race name]];
    filterLabel.layer.cornerRadius = 17;
    filterLabel.clipsToBounds = YES;
    filterLabel.layer.masksToBounds = YES;

    [UIView animateWithDuration:.4
                     animations:^{
                         filterHeader.alpha = 1.0;
                         searchButton.alpha = 1.0;
                     }];
    searchField.placeholder = [NSString stringWithFormat:@"Search %@ By Bib Number", [race name]];
    
    [trac photosForRace:[[race identifier] intValue] atPage:0];
    page = 0;
    photoCount = 0;
    [spinner startAnimating];
}

-(void)setFilter:(NSString*)_filter
{
    filter = _filter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:18]};
    CGSize raceName = [filter sizeWithAttributes:attributes];
    CGFloat labelWidth = raceName.width+20;
    
    filterLabel.frame = CGRectMake((width-labelWidth)/2, 5, labelWidth, 34);
    [filterLabel setText:[race name]];
    filterLabel.layer.cornerRadius = 17;
    searchButton.alpha = 0.0;
    
    [UIView animateWithDuration:.4
                     animations:^{
                         filterHeader.alpha = 1.0;
                     }];
    [spinner startAnimating];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.4
                     animations:^{
                         bibSearchButton.alpha = 1.0;
                     }];}

-(void)bibSearch
{
    [trac athleteForRace:[[race identifier] intValue] withBib:[[searchField text] intValue] andPage:0];
    photoCount = 0;
    page = 0;
    filter = [NSString stringWithFormat:@"Photos for Bib Number %@ at %@", [searchField text], [race name]];
    [searchField resignFirstResponder];
    [spinner startAnimating];
}


- (void)setupCaptureSession
{
    NSError *error = nil;
    
    // Create the session
    session = [[AVCaptureSession alloc] init];
    
    // Configure the session to produce lower resolution video frames, if your
    // processing algorithm can cope. We'll specify medium quality for the
    // chosen device.
    session.sessionPreset = AVCaptureSessionPresetHigh;
    
    // Find a suitable AVCaptureDevice
    AVCaptureDevice *device = [AVCaptureDevice
                               defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Create a device input with the device and add it to the session.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    if (!input)
    {
        NSLog(@"PANIC: no media input");
    }
    [session addInput:input];
    
    // Create a VideoDataOutput and add it to the session
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:output];
    
    // Configure your output.
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [output setSampleBufferDelegate:self queue:queue];
    
    // Specify the pixel format
    output.videoSettings =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    
    // If you wish to cap the frame rate to a known value, such as 15 fps, set
    // minFrameDuration.
    
    // Start the session running to start the flow of data
    [session startRunning];
    
    [self.view bringSubviewToFront:img];
    [self.view bringSubviewToFront:cancel];
    [self.view bringSubviewToFront:postImg];
    [self.view bringSubviewToFront:photoLibrary];
    
    img.hidden = NO;
    img.backgroundColor = [UIColor whiteColor];
    
    postImg.hidden = NO;
    photoLibrary.hidden = NO;
    cancel.hidden = NO;
    posting = NO;
    capturingPhoto = YES;
}

-(void)races
{
    if (raceOut)
    {
        [self.view bringSubviewToFront:header];
        [UIView animateWithDuration:.4
                         animations:^{
                             raceScroll.center = CGPointMake(width/2, 64-22);
                             scroll.frame = CGRectMake(0, 64, width, height-64);
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:.25 animations:^{
                                 filterHeader.alpha = 0.0;
                                 searchButton.alpha = 0.0;
                                 searchField.alpha = 0.0;
                                 bibSearchButton.alpha = 0.0;
                             }];
                         }];
        raceOut = NO;
    }
    else
    {
        [UIView animateWithDuration:.4
                         animations:^{
                             raceScroll.center = CGPointMake(width/2, 64+22);
                             scroll.frame = CGRectMake(0, 108, width, height-108);
                         }];
        raceOut = YES;
    }
}

-(void)search
{
    [UIView animateWithDuration:.4
                     animations:^{
                         searchField.alpha = 1.0;
                     }];
}

-(void)profile
{
    overlay.hidden = NO;
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = .9;
                     }];
    [[self delegate] gotoProfile];
}

-(void)profileOut
{
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         overlay.hidden = YES;
                     }];
}

-(void)messaging
{
}

-(void)tapImage:(UIImage*)tappedImage
{
    [image setImage:tappedImage];
    overlay.hidden = NO;
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = .95 ;
                         image.alpha = 1.0;
                         closeImage.alpha = 1.0;
                         saveImage.alpha = 1.0;
                     }];
}

-(void)closeImage
{
    [createPhoto moveOut];
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = 0.0;
                         image.alpha = 0.0;
                         closeImage.alpha = 0.0;
                         saveImage.alpha = 0.0;
                         overlay.hidden = YES;
                     }];
}

-(void)libraryImage
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    [createPhoto fillWith:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    overlay.hidden = NO;
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = .9;
                     }];
    
    postImg.hidden = YES;
    photoLibrary.hidden = YES;
    
    img.hidden = YES;
    posting = YES;
    
    [createPhoto setRace:race];
    [createPhoto fillWith:chosenImage];
    [createPhoto moveIn];
    
    dispatch_async(dispatch_queue_create("notifications", 0), ^{
        NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(chosenImage, 1.0)];
        
        float length = (int)[imageData length]*2;
        float ratio = length/7000000.0;
        
        UIImage* scaledImage = [self scaleImage:chosenImage ratio:ratio];
        
        NSString *ver = [[UIDevice currentDevice] systemVersion];
        float ver_float = [ver floatValue];
        if (ver_float < 8.0)
        {
            scaledImage = [self scaleAndRotateImage:chosenImage resolution:280];
        }
        
        imageData = [NSData dataWithData:UIImageJPEGRepresentation(scaledImage, 1.0)];
        
        NSString* imageString = [NSString stringWithFormat:@"%@", imageData];
        imageString = [imageString stringByReplacingOccurrencesOfString:@" " withString:@""];
        imageString = [imageString substringWithRange:NSMakeRange(1, [imageString length]-2)];
        
        NSString* postString = [NSString stringWithFormat:@"{\"image\": \"%@\", \"utf8\": \"✓\"}", imageString];
        
        //encoded json string
        NSData* data = [postString dataUsingEncoding:NSUTF8StringEncoding];
        
        [createPhoto addData:data];
    });
}

-(void)startPostImage
{
    cancel.hidden = NO;
    overlay.hidden = NO;
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = .9;
                     }];
    
    postImg.hidden = YES;
    photoLibrary.hidden = YES;
    
    img.hidden = YES;
    posting = YES;
    capturingPhoto = NO;
    
    [createPhoto setRace:race];
    [createPhoto fillWith:temp];
    [createPhoto moveIn];
    
    UIImage *takenPhoto = [UIImage imageWithCGImage:temp.CGImage];
    
    dispatch_sync(dispatch_queue_create("img", 0), ^{
        NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(takenPhoto, 1.0)];
        
        float length = (int)[imageData length]*2;
        float ratio = length/7000000.0;
        
        UIImage* scaledImage = [self scaleImage:takenPhoto ratio:ratio];
        
        NSString *ver = [[UIDevice currentDevice] systemVersion];
        float ver_float = [ver floatValue];
        if (ver_float < 8.0)
        {
            scaledImage = [self scaleAndRotateImage:takenPhoto resolution:280];
        }
        
        imageData = [NSData dataWithData:UIImageJPEGRepresentation(scaledImage, 1.0)];
        
        NSString* imageString = [NSString stringWithFormat:@"%@", imageData];
        imageString = [imageString stringByReplacingOccurrencesOfString:@" " withString:@""];
        imageString = [imageString substringWithRange:NSMakeRange(1, [imageString length]-2)];
        
        NSString* postString = [NSString stringWithFormat:@"{\"image\": \"%@\", \"utf8\": \"✓\"}", imageString];
        
        //encoded json string
        NSData* data = [postString dataUsingEncoding:NSUTF8StringEncoding];
        
        [createPhoto addData:imageData];
    });
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (capturingPhoto)
    {
        // Create a UIImage from the sample buffer data
        UIImage *bufferImg = [self imageFromSampleBuffer:sampleBuffer];
        @try
        {
            //< Add your code here that uses the image >
            dispatch_sync(dispatch_get_main_queue(), ^{
                temp = bufferImg;

                if (!posting && temp != nil)
                {
                    [img setImage:temp];
                }
                
                [self.view setNeedsDisplay];
            });
        }
        @catch (NSException* e)
        {
            NSLog(@"screen not visible");
        }
    }
}

- (UIImage*) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t swidth = CVPixelBufferGetWidth(imageBuffer);
    size_t sheight = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, swidth, sheight, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *sampleImage = [UIImage imageWithCGImage:quartzImage scale:1.0 orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (sampleImage);
}

-(void)setSession:(AVCaptureSession *)capturesession
{
    session = capturesession;
}

-(void)cancelCapture
{
    img.hidden = YES;
    postImg.hidden = YES;
    photoLibrary.hidden = YES;
    cancel.hidden = YES;
    capturingPhoto = NO;
    [createPhoto moveOut];
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         overlay.hidden = YES;
                     }];
}

-(void)createdPhoto
{
    cancel.hidden = YES;
    [UIView animateWithDuration:.4
                     animations:^{
                         overlay.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         overlay.hidden = YES;
                     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)injectTrac:(Trac*)_trac
{
    trac = _trac;
    [createPhoto injectTrac:trac];
}

-(UIImage*)scaleImage:(UIImage*)selectedImage ratio:(float)ratio
{
    CGImageRef postImage = selectedImage.CGImage;
    
    float imgwidth = CGImageGetWidth(postImage);
    float imgheight = CGImageGetHeight(postImage);
    
    if (ratio > 1)
    {
        imgheight = imgheight/ratio;
        imgwidth = imgwidth/ratio;
    }
    
    float bitsPerComponent = CGImageGetBitsPerComponent(postImage);
    float bytesPerRow = CGImageGetBytesPerRow(postImage);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(postImage);
    float bitmapInfo = CGImageGetBitmapInfo(postImage);
    
    CGContextRef context = CGBitmapContextCreate(nil, imgwidth, imgheight, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imgwidth, imgheight), postImage);
    
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    UIImage* scaledImage = [[UIImage alloc]initWithCGImage:newImage];
    
    CGContextRelease(context);
//    CGImageRelease(postImage);
    CGImageRelease(newImage);
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    scaledImage = [UIImage imageWithCGImage:scaledImage.CGImage
                                          scale:scaledImage.scale
                                    orientation:UIImageOrientationRight];
    return scaledImage;
}

- (UIImage*)scaleAndRotateImage:(UIImage*)pickedImage resolution:(int)resolution
{
    int kMaxResolution = resolution; // Or whatever
    
    CGImageRef imgRef = pickedImage.CGImage;
    
    CGFloat imgwidth = CGImageGetWidth(imgRef);
    CGFloat imgheight = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, imgwidth, imgheight);
    if (imgwidth > kMaxResolution || imgheight > kMaxResolution) {
        CGFloat ratio = imgwidth/imgheight;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / imgwidth;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = pickedImage.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -imgheight, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -imgheight);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, imgwidth, imgheight), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollContentSizeHeight = scroll.contentSize.height;
    float scrollOffset = scroll.contentOffset.y;
        
    if (scrollContentSizeHeight - scrollOffset < 800 && !refreshing)
    {
        refreshing = YES;
        [trac loadMore:page*10];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

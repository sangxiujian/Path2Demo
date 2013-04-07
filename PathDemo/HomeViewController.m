//
//  HomeViewController.m
//  PathDemo
//
//  Created by HsiuJane Sang on 9/5/12.
//  Copyright (c) 2012 JiaYuan. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

#define kBoundaryLeft   -290
#define kBoundaryRight  290

#define kTriggerOffSet 100.0f

@interface HomeViewController ()

@property (nonatomic,assign)CGPoint touchBeganPoint;

@end

@implementation HomeViewController

@synthesize touchBeganPoint = _touchBeganPoint;
@synthesize homeViewPosition = _homeViewPosition;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[self.navigationController setNavigationBarHidden:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self addGestureRecognizersToPiece:[self actionView]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    cell.textLabel.text = @"Home Part";
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - View Move

-(void)addCover{
    
    [self removeCover];
    UIControl *overView = [[UIControl alloc] init];
    overView.tag = 10086;
    overView.backgroundColor = [UIColor clearColor];
    overView.frame = self.navigationController.view.frame;
    [overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [overView addTarget:self action:@selector(dragBegan:withEvent: )
       forControlEvents: UIControlEventTouchDown];
    [overView addTarget:self action:@selector(dragMoving:withEvent: )
       forControlEvents: UIControlEventTouchDragInside];
    [overView addTarget:self action:@selector(dragEnded:withEvent: )
       forControlEvents: UIControlEventTouchUpInside |
     UIControlEventTouchUpOutside];
    [[[UIApplication sharedApplication] keyWindow] addSubview:overView];
    [overView release];
    [overView becomeFirstResponder];
}

-(void)removeCover{
    
    UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:10086];
    [overView removeFromSuperview];
}

-(UIView*)actionView{
    
    return self.navigationController.view;
}

-(void)willMoveToLeftSide{
    
  //  [self addCover];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] makeRightViewVisible];
}

-(void)willMoveToRightSide{
   // [self addCover];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] makeLeftViewVisible];
}

// restore view location
- (void)restoreViewLocation {
    
    _homeViewPosition = SAViewPositionMiddle;
    UIView *showView = [self actionView];
    [UIView animateWithDuration:0.3 
                     animations:^{
                         showView.frame = CGRectMake(0, showView.frame.origin.y,showView.frame.size.width,showView.frame.size.height);
                     } 
                     completion:^(BOOL finished){
                         [self removeCover];
                     }];
}

// move view to left side
- (void)moveToLeftSide {
    _homeViewPosition = SAViewPositionLeft;
    UIView *showView = [self actionView];
    [self animateHomeViewToSide:CGRectMake(kBoundaryLeft, 
                                           showView.frame.origin.y, 
                                           showView.frame.size.width, 
                                           showView.frame.size.height)];
}

// move view to right side
- (void)moveToRightSide {
    _homeViewPosition = SAViewPositionRight;
    UIView *showView = [self actionView];
    [self animateHomeViewToSide:CGRectMake(kBoundaryRight, 
                                           showView.frame.origin.y, 
                                           showView.frame.size.width, 
                                           showView.frame.size.height)];
}

// animate home view to side rect
- (void)animateHomeViewToSide:(CGRect)newViewRect {
    UIView *showView = [self actionView];
    [UIView animateWithDuration:0.2 
                     animations:^{
                         showView.frame = newViewRect;
                     } 
                     completion:^(BOOL finished){
                         [self addCover];
                     }];
}



#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark 



//touchPoint 
-(void) saDragBegin:(CGPoint)touchPoint{
    
}

-(void) saDragMoving:(CGPoint)distancePoint{
    
    CGFloat xOffSet = distancePoint.x;
    
    CGFloat xOrigin = 0.0;
    if (_homeViewPosition ==SAViewPositionLeft) {
        xOrigin = kBoundaryLeft;
    }else if(_homeViewPosition ==SAViewPositionRight){
        xOrigin = kBoundaryRight;
    }else {
        if (xOffSet < 0) {
            [self willMoveToLeftSide];
        }
        else if (xOffSet > 0) {
            [self willMoveToRightSide];
        }
    }
    CGFloat realOffset = xOffSet+xOrigin;
    realOffset = MIN(realOffset, kBoundaryRight);
    realOffset = MAX(realOffset, kBoundaryLeft);
    
    UIView *showView = [self actionView];
    CGRect frame = showView.frame;
    frame.origin.x = realOffset;
    showView.frame = frame;
    
    UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:10086];
    if (overView) {
        overView.frame = frame;
    }
    
}

-(void) saDragEnded:(CGPoint)distancePoint{
    if (distancePoint.x==0&&distancePoint.y==0 && _homeViewPosition) {
        [self restoreViewLocation];
    }
    UIView *showView = [self actionView];
    if (showView.frame.origin.x < -kTriggerOffSet) 
        [self moveToLeftSide];
    // animate to right side
    else if (showView.frame.origin.x > kTriggerOffSet) 
        [self moveToRightSide];
    // reset
    else 
        [self restoreViewLocation];  
}

#pragma mark - Gesture

// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIView *)piece
{    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    [panGesture release];
}

- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        [self saDragBegin:translation];
    }else if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        [self saDragMoving:translation];
    }else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded || [gestureRecognizer state] == UIGestureRecognizerStateCancelled){
        [self saDragEnded:translation];
    }
}



#pragma mark - Drag
- (void)dragBegan:(UIControl *)control withEvent:(UIEvent *)event
{
    NSLog(@"Button  moving bagin ......");
    UITouch *touch=[[event allTouches]  anyObject];
    CGPoint point = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    _touchBeganPoint = point;
    [self saDragBegin:point];
    
}

- (void)dragMoving:(UIControl *)control withEvent:(UIEvent *)event
{
    NSLog(@"Button  is moving ..............");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    CGPoint movePoint = CGPointMake(touchPoint.x-_touchBeganPoint.x, touchPoint.y-_touchBeganPoint.y);
    [self saDragMoving:movePoint];
    
    
}
- (void) dragEnded:(UIControl *)control withEvent:(UIEvent *)event
{
    NSLog(@"Button  moving end..............");

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
     CGPoint movePoint = CGPointMake(touchPoint.x-_touchBeganPoint.x, touchPoint.y-_touchBeganPoint.y);
    [self saDragEnded:movePoint];
}

@end

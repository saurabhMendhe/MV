//
//  ViewController.m
//  MVImage
//
//  Created by Saurabh Mendhe on 01/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "MovieViewController.h"
#import "MVCustomCollectionViewCell.h"
#import "MVMovieModal.h"
#define DEFAULT_CELL_SIZE 0
@interface MovieViewController (){
    NSMutableArray *arrImageUrl;
    int pageNumber;
    BOOL infiniteScroll;
    NSString *baseUrl;
    NSString *movieName;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewObj;

@end

@implementation MovieViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;
    infiniteScroll = NO;
    arrImageUrl = [[NSMutableArray alloc]init];
}

-(void)setMovieName:(NSString *)_movieName{
    self.navigationItem.title = [NSString stringWithFormat:@"Fetching %@ details..",_movieName];
    movieName = _movieName;
    pageNumber = 1;
    _movieName = [_movieName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    baseUrl = [NSString stringWithFormat:@"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=%@",_movieName];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&page=%d",baseUrl,pageNumber]];
    NetworkCompletionBlock networkblock = ^(NSData *respondeData, NSError *error) {
        if (error == nil) {
            [self downloadManagerDidComplete:respondeData];
        }
        else{
            [self downloadManagerDidFail:error];
        }
    };
    [MVDownLoadManager startUrlRequest:url useCache:YES WithCompletionBlock:networkblock];
    self.collectionViewObj.backgroundColor = [UIColor lightGrayColor];
}

-(MVMovieModal *)parseTheData:(NSDictionary *)resultDic{
    MVMovieModal *modal = [[MVMovieModal alloc] init];
    modal.imageurl = [resultDic objectForKey:@"poster_path"];
    modal.title = [resultDic objectForKey:@"title"];
    modal.ratings = [[resultDic objectForKey:@"vote_average"] floatValue];
    modal.overview = [resultDic objectForKey:@"overview"];
    modal.releaseDate = [resultDic objectForKey:@"release_date"];
    return modal;
}

-(void)downloadManagerDidComplete:(NSData *)respondeData{
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:respondeData options:NSJSONReadingMutableContainers error:nil];
    NSArray *arrResults = [dic objectForKey:@"results"];
    if (arrResults.count) {
        if (pageNumber == 1) {
            [self.delegate saveSearchItems:movieName];
        }
        self.navigationItem.title = [NSString stringWithFormat:@"%@",movieName];
        pageNumber ++;
        infiniteScroll = YES;
        for (NSMutableDictionary *resultDic in arrResults) {
            [arrImageUrl addObject:[self parseTheData:resultDic]];
        }
        if ([arrImageUrl count]) {
            [self.collectionViewObj reloadData];
        }
    }else{
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Movie name not found or cannot found more movie name", nil)
                                   };
        NSError *error = [NSError errorWithDomain:@"Movie Name"
                                             code:1001
                                         userInfo:userInfo];
        [self downloadManagerDidFail:error];
    }
    
}
-(void)downloadManagerDidFail:(NSError *)error{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Alert"
                                                                  message:error.localizedDescription
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([arrImageUrl count]) {
        return [arrImageUrl count];
    }
    return DEFAULT_CELL_SIZE;
}


-(UIColor *)randomColor{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    
    return [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:0.7f];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    MVCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"movieIcon"];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    CGRect cellRect = cell.imageView.frame;
    CGSize size =  CGSizeMake((windowRect.size.width/2), (windowRect.size.width/2));
    cell.imageView.frame = CGRectMake(cellRect.origin.x, cellRect.origin.y, size.width, size.height);
    cell.imageView.image = [UIImage imageNamed:@"movieIcon"];
    if ([arrImageUrl count]) {
        MVMovieModal *modal  = (MVMovieModal *)[arrImageUrl objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",modal.imageurl]];
        cell.title.text = modal.title;
        cell.ratings.text = [NSString stringWithFormat:@"Rating : %.1f",modal.ratings];
        cell.releaseDate.text = [NSString stringWithFormat:@"Release Date : %@",modal.releaseDate];
        cell.overview.text = modal.overview;
        cell.tag = indexPath.row+1;
        if (url) {
            [cell setImageWithUrl:url];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect windowRect = self.view.window.frame;
    return CGSizeMake((windowRect.size.width/2)-5, (windowRect.size.height/2)-5);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    if (scrollView_.contentSize.height>0) {
        CGFloat actualPosition = scrollView_.contentOffset.y;
        CGFloat contentHeight = scrollView_.contentSize.height - (3 * self.collectionViewObj.frame.size.height);
        if (actualPosition >= contentHeight && infiniteScroll) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&page=%d",baseUrl,pageNumber]];
            [MVDownLoadManager startUrlRequest:url useCache:YES WithCompletionBlock:^(NSData *respondeData, NSError *error) {
                if (error == nil) {
                    [self downloadManagerDidComplete:respondeData];
                }
                else{
                    [self downloadManagerDidFail:error];
                }
            }];
            infiniteScroll = NO;
        }
    }
}


@end

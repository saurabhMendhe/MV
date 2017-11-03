//
//  ViewController.m
//  MVImage
//
//  Created by Saurabh Mendhe on 01/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "ViewController.h"
#import "MVCustomCollectionViewCell.h"
#import "MVMovieModal.h"
#define DEFAULT_CELL_SIZE 10
#define BASE_URL @"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page="

#define URL1 @"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=2"

#define URL2 @"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=3"

#define URL3 @"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=4"
@interface ViewController (){
    NSMutableArray *arrImageUrl;
    int pageNumber;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewObj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;
    // Do any additional setup after loading the view, typically from a nib.
    arrImageUrl = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d",BASE_URL,pageNumber]];
    [MVDownLoadManager startUrlRequest:url useCache:YES delegate:self];
//    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
//    NSString *key = [NSString stringWithFormat:@"data%d",pageNumber];
//    [self downloadManagerDidComplete:[use objectForKey:key]];
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
    pageNumber ++;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:respondeData options:NSJSONReadingMutableContainers error:nil];
    for (NSMutableDictionary *resultDic in [dic objectForKey:@"results"]) {
         [arrImageUrl addObject:[self parseTheData:resultDic]];
    }
    if ([arrImageUrl count]) {
        [self.collectionViewObj reloadData];
    }
}
-(void)downloadManagerDidFail:(NSError *)error{
    NSLog(@"Error : %@",error);
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
    
    cell.backgroundColor = [self randomColor];
    cell.imageView.image = [UIImage imageNamed:@"movieIcon"];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    CGRect cellRect = cell.imageView.frame;
    CGSize size =  CGSizeMake((windowRect.size.width/2), (windowRect.size.width/2));
    cell.imageView.frame = CGRectMake(cellRect.origin.x, cellRect.origin.y, size.width, size.height);
    if ([arrImageUrl count]) {
        MVMovieModal *modal  = (MVMovieModal *)[arrImageUrl objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",modal.imageurl]];
        cell.title.text = modal.title;
        cell.ratings.text = [NSString stringWithFormat:@"Rating : %.1f",modal.ratings];
        cell.releaseDate.text = modal.releaseDate;
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
        if (actualPosition >= contentHeight) {
//            NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
//            NSString *key = [NSString stringWithFormat:@"data%d",pageNumber];
//            [self downloadManagerDidComplete:[use objectForKey:key]];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d",BASE_URL,pageNumber]];
            [MVDownLoadManager startUrlRequest:url useCache:YES delegate:self];
        }
    }
}


@end
//
//  SearchViewController.m
//  MVImage
//
//  Created by Saurabh Mendhe on 06/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "SearchViewController.h"
#import "NSString+CustomString.h"
#define searchKey @"searchItems"
@interface SearchViewController (){
    NSMutableArray *arrSearchItems;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTxt;
@property (weak, nonatomic) IBOutlet UITableView *searchTable;
@end

@implementation SearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:searchKey]) {
        arrSearchItems = [[NSUserDefaults standardUserDefaults] objectForKey:searchKey];
    }else{
        arrSearchItems = [[NSMutableArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:arrSearchItems forKey:searchKey];
    }
    [self.searchTable setHidden:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSearchAction:(id)sender {
    NSString *movieName  = [NSString trimString:_searchTxt.text];
    [self showMovieVC:movieName];
}

-(void)showMovieVC:(NSString *)movieName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MovieViewController *movieVC = [storyboard instantiateViewControllerWithIdentifier:@"MovieViewController"];
    [movieVC setMovieName:movieName];
    [movieVC setDelegate:self];
    [self.searchTxt resignFirstResponder];
    [self.searchTxt setText:@""];
    [self.navigationController pushViewController:movieVC animated:YES];
}
-(void)saveSearchItems:(NSString *)movieName{
    if (![movieName isEqualToString:@""]) {
        arrSearchItems = [[NSUserDefaults standardUserDefaults] objectForKey:searchKey];
        if (![arrSearchItems containsObject:movieName]) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrSearchItems];
            [arr insertObject:movieName atIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:searchKey];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrSearchItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"searchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [arrSearchItems objectAtIndex:indexPath.row];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-ThinItalic" size:12.0];
    cell.textLabel.font = font;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *movieName = [arrSearchItems objectAtIndex:indexPath.row];
    [self showMovieVC:movieName];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    arrSearchItems = [[NSUserDefaults standardUserDefaults] objectForKey:searchKey];
    if (arrSearchItems.count) {
        [self.searchTable setHidden:NO];
        [self.searchTable reloadData];
    }else{
        [self.searchTable setHidden:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.searchTable setHidden:YES];
}

@end

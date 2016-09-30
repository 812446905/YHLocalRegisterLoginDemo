//
//  ViewController.m
//  5.4CollectionViewSample
//
//  Created by 闫合 on 2016/9/30.
//  Copyright © 2016年 闫合. All rights reserved.
//

#import "ViewController.h"
#import "EventCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    int COL_NUM;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"events.plist" ofType:nil];
    self.events = [[NSArray array]initWithContentsOfFile:filePath];
    COL_NUM = 2;
    [self setupCollectionView];
    
}
-(void)setupCollectionView
{
    //1.创建流式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //2.设置每个单元格的尺寸
    layout.itemSize = CGSizeMake(150, 150);
    //3.设置整个collectionView的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //4.设置每一行之间的间距
    layout.minimumLineSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    //设置可重用单元格标识与单元格类型
    [self.collectionView registerClass:[EventCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int num = self.events.count%COL_NUM;
    if (num==0)
        return self.events.count/COL_NUM;
    else
        return self.events.count/COL_NUM+1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COL_NUM;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    NSDictionary *event = self.events[indexPath.section*COL_NUM+indexPath.row];
    cell.label.text = [event objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:event[@"image"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = self.events[indexPath.section*COL_NUM+indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",event[@"name"]] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"点赞", nil];
    [alert show];
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

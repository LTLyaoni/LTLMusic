//
//  LTLListController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/9.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLListController.h"
#import "LTLMusicDetailCell.h"
#import "LTLReturnArrow.h"
#import "LTLuserInfo.h"

@interface LTLListController ()<SDKDownloadMgrDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong ) NSMutableArray <XMTrack *> *list;

@property(nonatomic,strong) XMSDKDownloadManager *downloadManager;
///提示图
@property(nonatomic,strong)UIView *prompt;
///提示标签
@property(nonatomic,strong)UILabel *promptLabel;
///数据展示图
@property(nonatomic,strong)UITableView *tableView;

@end
static NSString *cellID = @"MusicCell";
@implementation LTLListController
//{
//    BOOL _historyList;
//}

//-(BOOL)isHistoryList
//{
//    if (_historyList) {
//        _historyList = NO;
//    }
//    return NO;
//}
///提示图
-(UIView *)prompt
{
    if (!_prompt) {
        
        _prompt = [[UIView alloc]initWithFrame:self.view.bounds];
        _prompt.backgroundColor = [UIColor whiteColor];
        UIImageView *promptImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"prompt"]];
        promptImage.frame = CGRectMake(0, 0, 222, 222);
        promptImage.contentMode = UIViewContentModeScaleAspectFit;
        promptImage.center = CGPointMake(self.view.center.x, self.view.center.y-88);
        [_prompt addSubview:promptImage];
//        self.view = 
    }
    return _prompt;
}
-(UILabel *)promptLabel
{
    
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc]init];
        
        [self.prompt addSubview:_promptLabel];
    
    }
    
    [_promptLabel sizeToFit];
    
    return _promptLabel;
}
///数据展示图
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[LTLMusicDetailCell class] forCellReuseIdentifier:cellID];
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        [_tableView setEditing:NO animated:YES];
    }
    return _tableView;
}

-(XMSDKDownloadManager *)downloadManager
{
    if (!_downloadManager) {
        _downloadManager = [XMSDKDownloadManager sharedSDKDownloadManager];
        _downloadManager.sdkDownloadMgrDelegate = self;
    }
    return _downloadManager;
}
-(void)setListType:(LTLListType)listType
{
    _listType = listType;
    
    [self myReloadData];
}

-(void)myReloadData
{
    
    switch (self.isListType) {
        case LTLListTypeHistoryList:
            
            
            self.title = @"播放历史";
            self.list = [[LTLDataProcessing getHistoryList] copy];
            self.promptLabel.text = @"播放历史为空,去乐库看看吧";
            break;
            
        case LTLListTypeLikeList:
            
            self.title = @"喜欢列表";
            self.list = [[LTLDataProcessing getLikeList] copy];
            self.promptLabel.text = @"还没有喜欢的音乐?把喜欢的收藏下来吧";
            
            break;
        case LTLListTypeDownloaTrack:
            
            self.list = [self.downloadManager getDownloadedTracks];
            self.promptLabel.text = @"没有下载的音乐呢";
            
            break;
  
    }
    
    self.promptLabel.center = self.view.center;
    if (self.list.count) {
        self.view = self.tableView;
        [self.tableView reloadData];
    }
    else {
        self.view = self.prompt;
    }
    
    

}


-(NSMutableArray<XMTrack *> *)list
{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    
}


-(void)setNav
{
    UIButton *leftBtn = [[UIButton alloc]init];
    
    UIImage *leftBtnImage = [LTLReturnArrow imageOfArtboardWithSize:CGSizeMake(30, 30) resizing:LTLReturnArrowResizingBehaviorAspectFit];
    
    [leftBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [leftBtn setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  
    [leftBtn sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    
    [rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    
    [rightBtn setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(empty:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn sizeToFit];
//    UIImage *rightBtnImage = [LTLshare imageOfArtboardWithSize:CGSizeMake(30, 30) resizing:LTLshareResizingBehaviorAspectFit];
    
//    [rightBtn setImage:rightBtnImage forState:UIControlStateNormal];
    
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

}

-(void)back:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    LTLLog(@"list 销毁");
}

-(void)empty:(UIButton*)btn
{

    switch (self.isListType) {
        case LTLListTypeHistoryList:
             [LTLDataProcessing deleteHistoryList];
            break;
        case LTLListTypeLikeList:
            [LTLDataProcessing deleteLikeList];
            break;
        case LTLListTypeDownloaTrack:
            [self.downloadManager clearAllDownloads];
            break;

    }

    [self myReloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
///#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
///#warning Incomplete implementation, return the number of rows
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTLMusicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.trackData = self.list[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.list removeObjectAtIndex:indexPath.row];
//        [tableView reloadData];
        
        switch (self.isListType) {
            case LTLListTypeHistoryList:
                [LTLDataProcessing deleteObjectById:self.list[indexPath.row]];
                break;
            case LTLListTypeLikeList:
                [LTLDataProcessing deleteHistoryListObjectById:self.list[indexPath.row]];
                break;
            case LTLListTypeDownloaTrack:
                [self.downloadManager clearDownloadAudio:self.list[indexPath.row]];
                break;
            default:
                break;
        }
        
        [self.list removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSRange range = NSMakeRange(indexPath.row, self.list.count - indexPath.row);
    NSArray *arrayL = [self.list subarrayWithRange:range];
    
    [self playNotification:[arrayL copy] serialNumber:0];
    
}
-(void)playNotification:(NSMutableArray *)arrya serialNumber:(NSUInteger)serialNumber
{
    if (arrya.count != 0 ) {
        
        /// 当前播放信息
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        LTLuserInfo *userInfo = [[LTLuserInfo alloc]init];
        userInfo.serialNumber = serialNumber;
        userInfo.songArray = [arrya copy];
        dic[@"Play"] = userInfo;
        ///发送播放通知
        [[NSNotificationCenter defaultCenter] postNotificationName:LTLPlay object:nil userInfo:[dic copy]];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  LTLPlayManager.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/5.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//


#import "LTLPlayManager.h"
#import "XMTrack.h"
#import "XMSDKPlayerDataCollector.h"

#import <MediaPlayer/MediaPlayer.h>

#include <sys/types.h>
#include <sys/sysctl.h>


NSString *const LTLlastPlay =  @"lastPlay";
NSString *const LTLcycle =  @"cycle";
NSString *const LTLplayPercent =  @"playPercent";

NSString *const LTLstatus =  @"status";
NSString *const LTLloadedTimeRanges =  @"loadedTimeRanges";
NSString *const LTLplaybackBufferEmpty =  @"playbackBufferEmpty";
NSString *const LTLplaybackLikelyToKeepUp =  @"playbackLikelyToKeepUp";

@interface LTLPlayManager ()
///用于缓冲播放
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
///喜欢列表
@property (nonatomic, strong) NSMutableArray *favoriteMusic;
///历史列表
@property (nonatomic, strong) NSMutableArray *historyMusic;
///正在播放列表
@property (nonatomic, strong)  NSMutableArray *playlist;
///当前正在播放的
@property (nonatomic,strong) XMTrack *tracksVM;
/////是否播放本地文件
@property (nonatomic,assign) BOOL localVideo; //是否播放本地文件
//@property (nonatomic) BOOL isFinishLoad; //是否下载完毕

@property (nonatomic, strong) NSMutableDictionary *soundIDs;//音效
///当前播放下标
@property (nonatomic,assign) NSInteger indexPathRow;
///列表总数
@property (nonatomic,assign) NSInteger rowNumber;
///播放控件
@property (nonatomic, strong) AVPlayer *player;
///SDK 播放统计
@property (nonatomic, strong) XMSDKPlayerDataCollector *playerData;
@property (nonatomic, strong) XMTrackPlayDataCollectItem *item;

@end



@implementation LTLPlayManager
{
    id _timeObserve;
}
//////懒加载

-(XMSDKPlayerDataCollector *)playerData
{
   if (!_playerData) {
      _playerData = [XMSDKPlayerDataCollector sharedInstance];
   }
   return _playerData;
}
-(XMTrackPlayDataCollectItem *)item
{
   if (!_item) {
      _item = [[XMTrackPlayDataCollectItem alloc]init];
   }
   return _item;
}

-(NSMutableArray *)playlist
{
   if (!_playlist) {
      _playlist = [NSMutableArray array];
   }
   return _playlist;
}

-(void)setIndexPathRow:(NSInteger)indexPathRow
{
   _indexPathRow = indexPathRow;
   
   ///写在偏好设置里
   NSNumber *userCycle = [NSNumber numberWithLong:indexPathRow];
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
   [user setObject:userCycle forKey:LTLlastPlay];
}

/////////////////////单例
+ (instancetype)sharedInstance {
   
    static LTLPlayManager *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}
/////////////////////初始化
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
       ///取出上一次播放的
       self.playlist = [LTLDataProcessing getLastPlayList];
       
       
        ///初始化声效ID 字典
        _soundIDs = [NSMutableDictionary dictionary];
        ///取出偏好设置
        NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
        ///判断是否有播放模式的偏好
       ///给个默认
       _playerCycle = theSong;
        if (defaults[LTLcycle]){
            //有
            NSInteger cycleDefaults = [defaults[LTLcycle] integerValue];
           
            ///赋给属性
            self.playerCycle = cycleDefaults;
           
           LTLLog(@"LTL %ld",self.playerCycle);
        }
       
       ///给个默认
       self.indexPathRow = 0;
       ///判断是否有上次播放的偏好序号
       if (defaults[LTLlastPlay]){
          //有
          NSInteger cycleDefaults = [defaults[LTLlastPlay] integerValue];
         
          LTLLog(@"判断是否有上次播放的偏好序号%ld",cycleDefaults);
          ///赋给属性
          self.indexPathRow = cycleDefaults;
       }
       
       if (self.playlist.count) {
          
          
          _rowNumber = _playlist.count;

          self.tracksVM = self.playlist[self.indexPathRow];
          
          
          NSURL *musicURL = [NSURL URLWithString:self.tracksVM.playUrl64 ] ;
          self.localVideo = NO;;
          if (self.tracksVM.filePath) {
            musicURL = [NSURL URLWithString:self.tracksVM.downloadUrl ] ;
             self.localVideo = YES;
          }
          
          //缓冲播放实现，可自行查找AVAssetResourceLoader资料,或采用AudioQueue实现
          //    NSURL *musicURL = [self.tracksVM playURLForRow:self.indexPathRow];
          
          _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
          _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
          
          [self addMusicMonitor];
          
          _play = NO;
          
          if (defaults[LTLplayPercent]) {
             self.playPercent = [defaults[LTLplayPercent] floatValue];
             [self seekToTime:self.playPercent];
          }
          
       }
       
        // 支持后台播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 激活
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
        //远程控制事件的捕获处理
        [self remoteControlEventHandler];
       
       
    }
    return self;
}
#pragma mark -远程控制事件的捕获处理
///远程控制事件的捕获处理
// 在需要处理远程控制事件的具体控制器或其它类中实现
- (void)remoteControlEventHandler
{
    // 直接使用sharedCommandCenter来获取MPRemoteCommandCenter的shared实例
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    // 启用播放命令 (锁屏界面和上拉快捷功能菜单处的播放按钮触发的命令)
    commandCenter.playCommand.enabled = YES;
    // 为播放命令添加响应事件, 在点击后触发
    [commandCenter.playCommand addTarget:self action:@selector(playAction:)];
    
    // 播放, 暂停, 上下曲的命令默认都是启用状态, 即enabled默认为YES
    // 为暂停, 上一曲, 下一曲分别添加对应的响应事件
//    [commandCenter.pauseCommand addTarget:self action:@selector(pauseAction:)];
    [commandCenter.pauseCommand addTarget:self action:@selector(playAction:)];
    
    [commandCenter.previousTrackCommand addTarget:self action:@selector(previousTrackAction:)];
    [commandCenter.nextTrackCommand addTarget:self action:@selector(nextTrackAction:)];
    
    // 启用耳机的播放/暂停命令 (耳机上的播放按钮触发的命令)
    commandCenter.togglePlayPauseCommand.enabled = YES;
    // 为耳机的按钮操作添加相关的响应事件
//    [commandCenter.togglePlayPauseCommand addTarget:self action:@selector(playOrPauseAction:)];
}
///播放, 暂停
-(void)playAction:(MPRemoteCommand *)Command
{
    LTLLog(@"LTL播放");
    if (self.status ==  AVPlayerStatusReadyToPlay) {

      [self pauseMusic];
        
    }else{
        LTLLog(@"当前没有音乐") ;
    }
}
///// 暂停
//-(void)pauseAction:(MPRemoteCommand *)Command
//{
//    LTLLog(@"LTL暂停");
//}
/// 上一曲
-(void)previousTrackAction:(MPRemoteCommand *)Command
{
    LTLLog(@"LTL上一曲");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        [self previousMusic];
    }else{
        LTLLog(@"等待加载音乐");
    }
}
/// 下一曲
-(void)nextTrackAction:(MPRemoteCommand *)Command
{
    LTLLog(@"LTL下一曲");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        [self nextMusic];
    }else{
        LTLLog(@"等待加载音乐");
    }
}

#pragma mark - 返回数据

///播放器状态
-(AVPlayerStatus)status
{
    return self.player.status;
}
///删除历史列表
- (void)delAllHistoryMusic{
    
   [LTLDataProcessing deleteHistoryList];
}
///删除喜欢列表
- (void)delAllFavoriteMusic{
   [LTLDataProcessing deleteLikeList];
}


#pragma mark - play

/**
 播放

 @param tracks 播放的歌
 @param playlist 播放列表
 */
- (void)playWithModel:(XMTrack *)tracks playlist:(NSArray *)playlist
{
   
   
    [LTLDataProcessing putModelObjectArray:playlist];
   

    if (_currentPlayerItem) {
        ///移除监听
        [self removeMusicMonitor];
    }
    //赋值属性
    _tracksVM = tracks;
   
    [self.playlist removeAllObjects];
   
    [self.playlist addObjectsFromArray:playlist];
    self.indexPathRow = 0;
    _rowNumber = playlist.count;
    //缓冲播放实现，可自行查找AVAssetResourceLoader资料,或采用AudioQueue实现
//    NSURL *musicURL = [self.tracksVM playURLForRow:self.indexPathRow];
    NSURL *musicURL = [NSURL URLWithString:tracks.playUrl64 ] ;
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
    _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
    
    [self addMusicMonitor];
    //正在播放
    _play = YES;
    [_player play];
   [LTLDataProcessing putModelHistoryListObject:self.tracksVM];
    //代理
    if ([self.delegate respondsToSelector:@selector(changeMusic)]) {
        [self.delegate changeMusic];
    }
    ///监听播放结束自动开始一首
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentPlayerItem];
    
}
#pragma mark - KVO方法
///添加监听
-(void)addMusicMonitor
{
    //判断currentPlayerItem是否为空
    if (!self.currentPlayerItem) {
        return;
    }

    [self.currentPlayerItem addObserver:self forKeyPath:LTLstatus options:NSKeyValueObservingOptionNew context:nil];
    [self.currentPlayerItem addObserver:self forKeyPath:LTLloadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];
    [self.currentPlayerItem addObserver:self forKeyPath:LTLplaybackBufferEmpty options:NSKeyValueObservingOptionNew context:nil];
    [self.currentPlayerItem addObserver:self forKeyPath:LTLplaybackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:nil];
    [self addMusicTime];
    
}
///进度监听
-(void)addMusicTime
{
    __weak typeof(self) weakSelf = self;
    _timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        
        NSTimeInterval current=CMTimeGetSeconds(weakSelf.currentPlayerItem.currentTime);
        
        NSTimeInterval duration= CMTimeGetSeconds(weakSelf.currentPlayerItem.duration);
        //计算当前在第几秒
        NSString *timeString = [weakSelf convertTime:current];
        
        CGFloat Percentage = current /duration;
        _playPercent = Percentage;
        if ([weakSelf.delegate respondsToSelector:@selector(playNotifyProcess:currentSecond:)]) {
            [weakSelf.delegate playNotifyProcess:Percentage currentSecond:timeString];
        }
        
    }];

}
- (NSString *)convertTime:(NSTimeInterval)second{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [dateFormatter stringFromDate:date];
    return showtimeNew;
}
///删除音乐监听
-(void)removeMusicMonitor
{
    ///判断currentPlayerItem是否为空
    if (!self.currentPlayerItem) {
        return;
    }
    //移除
    if (_timeObserve) {
        [_player removeTimeObserver:_timeObserve];
    }
    //移除
    [self.currentPlayerItem removeObserver:self forKeyPath:LTLstatus];
    [self.currentPlayerItem removeObserver:self forKeyPath:LTLloadedTimeRanges];
    [self.currentPlayerItem removeObserver:self forKeyPath:LTLplaybackBufferEmpty];
    [self.currentPlayerItem removeObserver:self forKeyPath:LTLplaybackLikelyToKeepUp];

}

#pragma mark - 

//监听获得消息
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        
        if ([keyPath isEqualToString:LTLstatus])
        {
            if ([playerItem status] == AVPlayerStatusReadyToPlay)
            {
                //status 点进去看 有三种状态
                
//                CGFloat duration = playerItem.duration.value / playerItem.duration.timescale; //视频总时间
//                LTLLog(@"准备好播放了，总时间：%.2f", duration);//还可以获得播放的进度，这里可以给播放进度条赋值了
                [self updateLockedScreenMusic];//控制中心

            }
//            else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown)
//            {
////                [_player pause];
//            }
            
        }
        else if ([keyPath isEqualToString:LTLloadedTimeRanges])
        {  //监听播放器的下载进度
            
            NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
            CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
            float startSeconds = CMTimeGetSeconds(timeRange.start);
            float durationSeconds = CMTimeGetSeconds(timeRange.duration);
            NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
            CMTime duration = playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            _playBuffer = timeInterval / totalDuration;
            if ([self.delegate respondsToSelector:@selector(playBufferProcess:)]) {
                [self.delegate playBufferProcess:_playBuffer];
            }
//            LTLLog(@"下载进度：%.2f", timeInterval / totalDuration);
            
//        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
//            
//            LTLLog(@"缓冲不足暂停了");
//            
//            
//        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
//            
//            LTLLog(@"缓冲达到可播放程度了");
//            
//            //由于 AVPlayer 缓存不足就会自动暂停，所以缓存充足了需要手动播放，才能继续播放
////            [_player play];
//            
        }
    
}


#pragma mark - 接收动作
///暂停或播放
- (void)pauseMusic{
   
//   [self iPhoneSysctlbyname];
    ///判断AVPlayerItem是否为空
    if (!self.currentPlayerItem) {
        return;
    }
    ///影音播放器状态是否暂停或播放
    if (_player.rate) {
        _play = NO;
        //暂停
        [_player pause];
        [self updateLockedScreenMusic];
        
    } else {
        //播放
        _play = YES;
        [_player play];
        [self updateLockedScreenMusic];
    }
}

///上一首
- (void)previousMusic{
    //判断模式
    if (_playerCycle == theSong) {
        [self playPreviousMusic];
    }else if(_playerCycle == nextSong){
        [self playPreviousMusic];
    }else if(_playerCycle == isRandom){
        [self randomMusic];
    }

}
///下一首
- (void)nextMusic{
   
    //判断模式
    if (_playerCycle == theSong) {
        [self playNextMusic];
    }else if(_playerCycle == nextSong){
        [self playNextMusic];
    }else if(_playerCycle == isRandom){
        [self randomMusic];
    }
}
//切换模式
- (void)nextCycle:(LTLPlayerCycle)cycle
{
    ///模式写在偏好设置里
    NSNumber *userCycle = [NSNumber numberWithInt:cycle];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:userCycle forKey:LTLcycle];
    
    _playerCycle = cycle;
    
}

-(void)setPlayPercent:(CGFloat)playPercent
{
   _playPercent = playPercent;
   
   ///模式写在偏好设置里
   NSNumber *userCycle = [NSNumber numberWithFloat:playPercent];
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
   [user setObject:userCycle forKey:LTLplayPercent];
   
   
   
   self.item.duration = playPercent;
   self.item.trackID = self.tracksVM.trackId;
   self.item.playType = self.isLocalVideo;
   [self.playerData sendTrackPlayDataWithItem:self.item];
   
}


#pragma mark - 播放动作
///自动下一首播放
-(void)playbackFinished:(NSNotification *)notification{
    //判断模式
    if (_playerCycle == theSong) {
        [self playAgain];
    }else if(_playerCycle == nextSong){
        [self playNextMusic];
    }else if(_playerCycle == isRandom){
        [self randomMusic];
    }
    LTLLog(@"开始下一首");
    if ([self.delegate respondsToSelector:@selector(changeMusic)]) {
        [self.delegate changeMusic];
    }
}
///播放上一首
- (void)playPreviousMusic{
    ///移除监听
   
    if (_currentPlayerItem){
        //防止数组越界
        if (self.indexPathRow > 0) {
            self.indexPathRow--;
        }else{
            self.indexPathRow = _rowNumber-1;
        }
        
       [self playSong];
    }
}
///播放下一首
- (void)playNextMusic{
   
    if (_currentPlayerItem) {
        
        //防止数组越界
        if (self.indexPathRow < _rowNumber-1) {
            self.indexPathRow++;
        }else{
            self.indexPathRow = 0;
        }
       [self playSong];
       
    }

}
///播放
-(void)playSong
{
   [self removeMusicMonitor];
   if (_currentPlayerItem) {
      
      
      _tracksVM  = self.playlist[self.indexPathRow];
      
      NSURL *musicURL = [NSURL URLWithString:self.tracksVM.playUrl64 ] ;
      self.localVideo = NO;
      if (self.tracksVM.filePath) {
         musicURL = [NSURL URLWithString:self.tracksVM.downloadUrl ] ;
         self.localVideo = YES;
      }
      _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
      
      _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
      
      [[NSNotificationCenter defaultCenter] removeObserver:self];
      
      [self addMusicMonitor];
      _play = YES;
      [_player play];
      
      [LTLDataProcessing putModelHistoryListObject:self.tracksVM];
      
      if ([self.delegate respondsToSelector:@selector(changeMusic)]) {
         [self.delegate changeMusic];
      }
      ///监听播放结束自动开始一首
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
   }

}


///随机播放
- (void)randomMusic{
   
    if (_currentPlayerItem) {
        ///取随机数
        self.indexPathRow = arc4random() % _rowNumber;
        
       [self playSong];
    }
}
///再次播放
-(void)playAgain{
    
    [_player seekToTime:CMTimeMake(0, 1)];
    _play = YES;
    [_player play];
    [self updateLockedScreenMusic];
}

- (void)stopMusic
{
    
}
- (void)seekToTime:(CGFloat)percent
{
    //根据值计算时间
    float time = percent * CMTimeGetSeconds(self.player.currentItem.duration);
    //跳转到当前指定时间
    //转换成CMTime才能给player来控制播放进度
    [self.player seekToTime:CMTimeMake(time, 1)];
    
}
#pragma mark - 列表操作
- (void)setNumberOfPlay:(NSUInteger)number
{
   self.indexPathRow = number;
   [self playSong];

}
- (void)removeSong:(NSUInteger)number
{
   if (self.indexPathRow == number) {
      [self nextMusic];
      self.indexPathRow--;
   }
   [self.playlist removeObjectAtIndex:number];
   [LTLDataProcessing putModelObjectArray:self.playlist];
}

-(void)songExchangeAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
{
   [self.playlist exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
   
   [self.playlist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      
      XMTrack *model = obj;
      
      if (model.trackId == self.tracksVM.trackId) {
         self.indexPathRow = idx;
         
//         if ([self.delegate respondsToSelector:@selector(changeMusic)]) {
//            [self.delegate changeMusic];
//         }
         
      }
      
   }];
   
   [LTLDataProcessing putModelObjectArray:self.playlist];
   
}
///收藏
- (BOOL)hasBeenFavoriteMusic
{

   BOOL hasBeen = [LTLDataProcessing hasBeenFavoriteMusic:self.tracksVM];
   
   return hasBeen;

}
///收藏
- (void)delFavoriteMusic
{
   [LTLDataProcessing putModelObject:self.tracksVM];
}
///取消收藏
- (void)setFavoriteMusic
{
   [LTLDataProcessing deleteObjectById:self.tracksVM];
}
#pragma mark - 锁屏时候的设置，效果需要在真机上才可以看到
- (void)updateLockedScreenMusic
{
   
   if ([self.delegate respondsToSelector:@selector(changeMusic)]) {
      [self.delegate changeMusic];
   }
    // 播放信息中心
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    
    // 初始化播放信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    // 专辑名称
    info[MPMediaItemPropertyAlbumTitle] = _tracksVM.subordinatedAlbum.albumTitle;
    // 歌手
    info[MPMediaItemPropertyArtist] = _tracksVM.announcer.nickname;
    // 歌曲名称
    info[MPMediaItemPropertyTitle] = _tracksVM.trackTitle;

//    UIImage *image = [self playCoverImage];
//    if (image != nil) {
//        // 设置图片
//        info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:image];
//    }
    // 设置持续时间（歌曲的总时间）
    [info setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem duration])] forKey:MPMediaItemPropertyPlaybackDuration];
    // 设置当前播放进度
    [info setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem currentTime])] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    //进度光标的速度 （默认是原速播放）
    if (self.isPlay == NO) {
        [info setObject:[NSNumber numberWithFloat:0] forKey:MPNowPlayingInfoPropertyPlaybackRate];
    }
    else
    {
        [info setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];
    }
   
   NSURL *url = [NSURL URLWithString:self.tracksVM.coverUrlLarge];
   
   if (!url) {
      url = [NSURL URLWithString:self.tracksVM.coverUrlSmall];
   }
   
//   UIImage *image = [self playCoverImageUrl:url];
   
//   UIImageView *image = [[UIImageView alloc]init];
//   
   info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"12"]];
    ///下载后图片
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
       
       if (image) {
          // 设置图片
          info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:image];
          // 切换播放信息
          center.nowPlayingInfo = info;
       }
       
    }];

    // 切换播放信息
    center.nowPlayingInfo = info;
    
}

- (UIImage *)playCoverImageUrl:(NSURL *)url
{
    
    UIImageView *imageCoverView = [[UIImageView alloc] init];
    [imageCoverView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"12"]];

    return imageCoverView.image;
}
#pragma mark - 音效
//播放音效
- (void)playSound:(NSString *)filename{
    
    if (!filename){
        return;
    }
    
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url){
            return;
        }
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);

        self.soundIDs[filename] = @(soundID);
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID);
}

//摧毁音效
- (void)disposeSound:(NSString *)filename{
    
    if (!filename){
        return;
    }
    
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [self.soundIDs removeObjectForKey:filename];    //音效被摧毁，那么对应的对象应该从缓存中移除
    }
}
#pragma mark -型号检测
/** 型号检测 */
-(void)iPhoneSysctlbyname {
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    LTLLog(@"iPhone Device%@",[self platformType:platform]);
    free(machine);
}


- (NSString *) platformType:(NSString *)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

@end

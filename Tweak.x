@interface MPResponse : NSObject
@end

@interface MPModelObject : NSObject
@end

@interface MPModelAlbum : MPModelObject
@property (nonatomic,copy) NSString * title;
@end

@interface MPModelSong : MPModelObject
@property (nonatomic,retain) MPModelAlbum * album;
@end

@interface MPModelGenericObject : MPModelObject
@property (nonatomic,retain) MPModelSong * song;
@end

@interface MPCPlayerResponseItem : NSObject
@property (nonatomic,readonly) MPModelGenericObject * metadataObject;
@end

@interface MPCPlayerResponseTracklist : NSObject
@property (nonatomic,readonly) MPCPlayerResponseItem *currentItem;
@end

@interface MPCPlayerResponse : MPResponse
@property (nonatomic,readonly) MPCPlayerResponseTracklist * tracklist;
@end

@interface MusicNowPlayingControlsViewController : UIViewController
@property(retain, nonatomic) MPCPlayerResponse *response;
@property(retain, nonatomic) UIButton *subtitleButton;
@end

%hook MusicNowPlayingControlsViewController

-(void)viewWillLayoutSubviews {
  %orig;
  MPCPlayerResponse *response = self.response;
  MPCPlayerResponseTracklist *tracklist = response.tracklist;
  MPCPlayerResponseItem *item = (MPCPlayerResponseItem *)tracklist.currentItem;
  MPModelGenericObject *object = (MPModelGenericObject *)item.metadataObject;
  MPModelSong * song = (MPModelSong *)object.song;
  MPModelAlbum * album = (MPModelAlbum *)song.album;
  NSString *title = album.title;
  [self.subtitleButton setTitle:title forState:UIControlStateNormal];
}


%end

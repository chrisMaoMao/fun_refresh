class VideoModel {
  var data;
  factory VideoModel(res) => VideoModel.fromJson(res);
  VideoModel.fromJson(res) {
    data = Data.fromJson(res['data']);
  }
}

class Data {
  var playList = [];
  Data.fromJson(res) {
    res['play_list'].forEach((item) => playList.add(Video.fromJson(item)));
  }
}

class Video {
  var title;
  var playUrl;
  Video.fromJson(res) {
    title = res['title'];
    playUrl = res['playUrl'];
  }
}

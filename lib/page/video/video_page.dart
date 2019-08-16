import 'package:flutter/material.dart';
import 'package:fun_refresh/components/video_item.dart';
import 'package:fun_refresh/model/video/player.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class VideoPage extends StatefulWidget {
  @override
  createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  build(context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('视频', textScaleFactor: 1.3),
        ),
        body: RefreshIndicator(
          onRefresh: () => netool.fetchVideoList(),
          child: FutureBuilder<PlayerModel>(
            future: netool.fetchVideoList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 32.0),
                  itemCount: snapshot.data.itemList.length ?? 0,
                  itemBuilder: (context, index) =>
                      snapshot.data.itemList[index].type == 'textCard' ||
                              snapshot.data.itemList[index].type == 'banner'
                          ? Container()
                          : VideoCover(snapshot, index),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
}

class VideoCover extends StatefulWidget {
  VideoCover(this.snapshot, this.index);
  final AsyncSnapshot<PlayerModel> snapshot;
  final int index;

  @override
  _VideoCoverState createState() => _VideoCoverState();
}

class _VideoCoverState extends State<VideoCover> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    InnerData item =
        widget.snapshot.data.itemList[widget.index].data.content.data;
    return Stack(children: [
      VideoItem(
        image: item.cover.detail,
        video: item.playUrl,
      ),
      Positioned(
        top: 12.0,
        right: 64.0,
        child: AnimatedOpacity(
          child: Text(
            item.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          duration: Duration(milliseconds: 500),
          opacity: _visible ? 1.0 : 0.0,
        ),
      ),
      Positioned(
        top: 32.0,
        right: 64.0,
        child: Text(
          item.author.name,
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
      Positioned(
        right: 12.0,
        top: 12.0,
        child: GestureDetector(
          onTap: () {
            print('object');
            return _visible = !_visible;
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _visible ? 1.0 : 0.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(item.author.icon),
            ),
          ),
        ),
      ),
      Positioned(
        right: 8.0,
        bottom: 8.0,
        child: IconButton(
          icon: Icon(Icons.fullscreen),
          onPressed: () {},
          color: Colors.white,
        ),
      ),
    ]);
  }
}

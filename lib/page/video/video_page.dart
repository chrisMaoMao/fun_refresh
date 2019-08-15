import 'package:flutter/material.dart';
import 'package:fun_refresh/components/video_item.dart';
import 'package:fun_refresh/model/video/player.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('视频', textScaleFactor: 1.3),
        ),
        body: FutureBuilder<PlayerModel>(
          future: netool.fetchVideoList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 32.0),
                itemCount: snapshot.data.itemList.length ?? 0,
                itemBuilder: (context, index) =>
                    snapshot.data.itemList[index].type == 'textCard'
                        ? Container()
                        : VideoCover(snapshot, index),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
}

class VideoCover extends StatelessWidget {
  VideoCover(this.snapshot, this.index);
  final AsyncSnapshot<PlayerModel> snapshot;
  final int index;
  @override
  Widget build(BuildContext context) {
    InnerData item = snapshot.data.itemList[index].data.content.data;
    return Stack(children: [
      VideoItem(
        image: item.cover.detail,
        video: item.playUrl,
      ),
      Positioned(
        top: 12.0,
        right: 64.0,
        child: Text(
          item.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
        child: CircleAvatar(
          backgroundImage: NetworkImage(item.author.icon),
        ),
      ),
    ]);
  }
}

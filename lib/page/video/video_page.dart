import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/model/video/featured.dart';

class VideoPage extends StatefulWidget {
  @override
  createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  build(context) {
    return FutureBuilder<FeaturedVideo>(
      future: _fetchVideoData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.itemList[0].data.playUrl);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<FeaturedVideo> _fetchVideoData() async {
    final response = await Dio().get(EYE_HOME);
    print(response.data);
    if (response.statusCode == 200) {
      return FeaturedVideo.fromJson(jsonDecode(response.data));
    } else {
      throw Exception();
    }
  }

/*   RefreshIndicator(
        onRefresh: _fetchData,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _videoList.length ?? 0,
          itemBuilder: (context, index) => Card(
                elevation: 10.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VideoItem(video: _videoList[index].playUrl),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      child: Text(
                        _videoList[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                    )
                  ],
                ),
              ),
        ),
      );
 */

}

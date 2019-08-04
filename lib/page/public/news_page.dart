import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/custom_app_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/data/theme.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:fun_refresh/tools/api.dart';

class NewsPage extends StatefulWidget {
  @override
  createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: newsTabs.length);
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  build(context) => Scaffold(
        appBar: GradientAppBar(
          context: context,
          dy: 3.0,
          showBTN: true,
          bottom: PreferredSize(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 32.0),
                  child: TabBar(
                    controller: _tabController,
                    tabs: newsTabs
                        .map((item) => Tab(text: item.text ?? '出错!'))
                        .toList(),
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.lightBlue,
                    indicator: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.tealAccent.withOpacity(0.5),
                          Colors.lightBlue.withOpacity(0.6),
                        ],
                      ),
                    ),
                    indicatorWeight: 0.0,
                  ),
                ),
                Positioned(
                  right: 0.0,
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.lightBlue[500], boxShadow: [
                      BoxShadow(
                          blurRadius: 8.0,
                          color: Colors.white,
                          spreadRadius: 6.0,
                          offset: Offset.zero),
                    ]),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            preferredSize: null,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: newsTabs.map((item) => item.newsList).toList(),
        ),
      );
}

final List<NewsTab> newsTabs = [
  // 拼音是新闻接口分类的参数值
  NewsTab('头条', NewsList(newsType: 'toutiao')),
  NewsTab('社会', NewsList(newsType: 'shehui')),
  NewsTab('国内', NewsList(newsType: 'guonei')),
  NewsTab('国际', NewsList(newsType: 'guoji')),
  NewsTab('娱乐', NewsList(newsType: 'yule')),
  NewsTab('体育', NewsList(newsType: 'tiyu')),
  NewsTab('军事', NewsList(newsType: 'junshi')),
  NewsTab('科技', NewsList(newsType: 'keji')),
  NewsTab('财经', NewsList(newsType: 'caijing')),
  NewsTab('时尚', NewsList(newsType: 'shishang')),
];

class NewsList extends StatefulWidget {
  // 新闻列表
  @override
  NewsList({this.newsType});
  final String newsType; // 新闻类型
  createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  double width;
  double height;
  Orientation orientation;
  Future<String> requestNews(String type) async {
    var httpClient = HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse('${NEWS}type=$type&key=${newsKey[0]}'));
    var response = await request.close();
    var result = await response.transform(utf8.decoder.cast()).join();
    return result;
  }

  Future<Null> loadData() async {
    await requestNews(widget.newsType);
    if (!mounted) return; // 异步处理,防止报错
    setState(() {}); // 什么都不做,只为触发刷新
  }

  @override
  build(context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
    return RefreshIndicator(
      child: FutureBuilder(
        future: requestNews(widget.newsType),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : createListView(context, snapshot),
      ),
      onRefresh: loadData,
    );
  }

  createListView(BuildContext context, AsyncSnapshot snapshot) {
    List values = jsonDecode(snapshot.data)['result'] != null
        ? jsonDecode(snapshot.data)['result']['data']
        : [''];
    switch (values.length) {
      case 1:
        return Center(child: Text(jsonDecode(snapshot.data)['reason']));
      default:
        return orientation == Orientation.landscape
            ? GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 3,
                children: List.generate(
                    values.length ?? 0,
                    (index) => InkWell(
                          onTap: () => pushNamed(context, '/browser', args: {
                                'title': values[index]['title'],
                                'link': '${values[index]['url']}'
                                    .replaceFirst(r'http', 'https')
                              }),
                          child: _buildCardItem(values, index),
                        )),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: values.length ?? 0,
                itemBuilder: (context, index) => InkWell(
                      onTap: () => pushNamed(context, '/browser', args: {
                            'title': values[index]['title'],
                            'link': '${values[index]['url']}'
                                .replaceFirst(r'http', 'https')
                          }),
                      child: _buildCardItem(values, index),
                    ),
              );
    }
  }

  _buildCardItem(List values, int index) => Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: _buildItem(values[index], index: index));

  // 根据缩略图数切换布局:
  // 三图新闻:横屏A,竖屏B两种布局.
  // 单图新闻:横屏A,
  _buildItem(Map newsInfo, {int index}) =>
      newsInfo['thumbnail_pic_s'] != null &&
              newsInfo['thumbnail_pic_s02'] != null &&
              newsInfo['thumbnail_pic_s03'] != null
          ? orientation == Orientation.landscape
              ? _buildThreePicItemA(newsInfo)
              : _buildThreePicItemB(newsInfo)
          : index % 2 != 0
              ? _buildOnePicItemA(newsInfo)
              : orientation == Orientation.landscape
                  ? _buildOnePicItemA(newsInfo)
                  : _buildOnePicItemB(newsInfo);

  // 单图横屏A
  _buildOnePicItemA(Map newsInfo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Image.network(newsInfo['thumbnail_pic_s'],
                      fit: BoxFit.fitWidth,
                      height: orientation == Orientation.landscape
                          ? height / 2
                          : height / 4))
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              newsInfo['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          orientation == Orientation.landscape
              ? SizedBox(
                  height: newsInfo['title'].toString().length <= 21
                      ? height / 20
                      : 0)
              : Container(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                $Text(newsInfo['author_name']),
                Spacer(),
                $Text('评论 33'),
                Spacer(flex: 12),
                $Text(newsInfo['date'].toString().substring(11)),
                Spacer(),
                xClose
              ],
            ),
          ),
        ],
      );
  // 单图新闻B
  _buildOnePicItemB(Map newsInfo) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.network(newsInfo['thumbnail_pic_s'],
              fit: BoxFit.cover, height: height / 7, width: width / 2.8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: width / 1.68,
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    newsInfo['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              // 对于中文字符数要做出边界限制
              SizedBox(
                  height: newsInfo['title'].toString().length <= 21
                      ? height / 12
                      : height / 15),
              Container(
                width: width / 1.68,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    xClose,
                    $Text(newsInfo['author_name']),
                    Spacer(),
                    $Text('33 评论'),
                    Spacer(flex: 8),
                    $Text(newsInfo['date'].toString().substring(11)),
                  ],
                ),
              ),
            ],
          )
        ],
      );

  // 三图新闻横屏A
  _buildThreePicItemA(Map newsInfo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                newsInfo['title'],
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  child: Image.network(
                    newsInfo['thumbnail_pic_s'],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s02']),
                    ),
                    Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s02']),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s']))),
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s02']))),
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s03'])))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                $Text(newsInfo['author_name']),
                Spacer(),
                $Text('评论 33'),
                Spacer(flex: 12),
                $Text(newsInfo['date'].toString().substring(11)),
                Spacer(),
                xClose
              ],
            ),
          ),
        ],
      );

  // 三图新闻竖屏B
  _buildThreePicItemB(Map newsInfo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                newsInfo['title'],
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          Row(
            children: [
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s']))),
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s02']))),
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: Image.network(newsInfo['thumbnail_pic_s03'])))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                $Text(newsInfo['author_name']),
                Spacer(),
                $Text('评论 33'),
                Spacer(flex: 12),
                $Text(newsInfo['date'].toString().substring(11)),
                Spacer(),
                xClose
              ],
            ),
          ),
        ],
      );
}

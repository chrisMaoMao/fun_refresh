import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:fun_refresh/tools/api.dart';

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  Future<List> getData() async {
    final response = await Dio().get('$MAIN/database/read');
    return jsonDecode(response.data); // php传来的json需要解码一下,否则异步获取的数据是null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  _updateData() async {
    await Dio().get('$MAIN/database/update');
  }

  deleteData(i) async {
    await Dio().post('$MAIN/database/delete', queryParameters: {'id': list[i]['id']});
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: list.length ?? 0,
        itemBuilder: (context, i) {
          _confirm() {
            AlertDialog alertDialog = AlertDialog(
              content: Text(
                '确认删除? ${list[i]['email']}',
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    return deleteData(i);
                  },
                  color: Colors.red,
                  child: Text('确认', style: TextStyle(color: Colors.white)),
                ),
                RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => alertDialog);
          }

          return Container(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () =>
                  pushNamed(context, '/chat', args: {'name': list[i]['email']}),
              child: Card(
                child: Stack(
                  children: [
                    Container(height: 120.0),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Text(list[i]['phone']),
                    ),
                    Positioned(
                      left: 8.0,
                      bottom: 8.0,
                      child: Text(list[i]['email']),
                    ),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.edit, size: 18.0),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return Dialog(
                                  child: Container(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                          labelText: list[i]['email']),
                                    ),
                                    Text(list[i]['phone']),
                                    Row(
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('确认'),
                                          onPressed: () {
                                            _updateData();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        RaisedButton(
                                          child: Text('取消'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ));
                            },
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.delete, size: 18.0),
                        onPressed: () => _confirm(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

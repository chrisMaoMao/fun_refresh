import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/curve_path.dart';
import 'package:fun_refresh/components/swiper.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';

class ExtensionPage extends StatefulWidget {
  @override
  createState() => _ExtensionPageState();
}

class _ExtensionPageState extends State<ExtensionPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.21),
              child: ClipPath(
                child: GridView.extent(
                  childAspectRatio: 16 / 9,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                    Image.network(covers[4], fit: BoxFit.cover),
                  ],
                  maxCrossAxisExtent: 250.0,
                ),
                clipper: TopCurve(38.0),
              ),
            ),
            ClipPath(
              child: AspectRatio(
                aspectRatio:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 3 / 1
                        : 16 / 10,
                child: Swiper.builder(
                  autoStart: true,
                  circular: true,
                  indicator: RectangleSwiperIndicator(
                      padding: EdgeInsets.only(bottom: 26.0),
                      itemColor: Colors.grey[400],
                      itemActiveColor: Colors.lightBlue),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () => pushNamed(context, '/detail', args: {
                            'index': index + 5,
                            'title': coverTitles[index],
                          }),
                      child: Image.network(covers[index], fit: BoxFit.cover)),
                  childCount: covers.length ?? 0,
                ),
              ),
              clipper: BTMCurve(38.0),
            ),
          ],
        ),
      ),
    );
  }
}

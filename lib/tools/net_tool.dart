import 'package:dio/dio.dart';
import 'package:fun_refresh/model/video.dart';
import 'package:fun_refresh/tools/api.dart';

NeTool get netool => NeTool();
Dio dio = Dio();

class NeTool {
  fetchVideoList(Function callBack, {int page}) async => dio
      .get('$NEWS/video')
      .then((response) => callBack(VideoModel(response.data)));
}

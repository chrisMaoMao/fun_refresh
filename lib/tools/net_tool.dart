import 'package:dio/dio.dart';
import 'package:fun_refresh/model/video/player.dart';
import 'package:fun_refresh/tools/api.dart';

NeTool get netool => NeTool();
Dio dio = Dio();

class NeTool {
  Future<PlayerModel> fetchVideoList({String requestUrl = EYE_DAILY}) async {
    final response = await Dio().get(
      requestUrl,
      queryParameters: {'deviceModel': 'GM1910', 'vc': 531, 'num': 100},
      options: Options(headers: {'User-Agent': POST_MAN}),
    );
    if (response.statusCode == 200) {
      print(response);
      return PlayerModel.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}

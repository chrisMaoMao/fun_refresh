import 'package:json_annotation/json_annotation.dart';
part 'featured.g.dart';

@JsonSerializable()
class FeaturedVideo {
  List<Item> itemList;
  FeaturedVideo(this.itemList);
  factory FeaturedVideo.fromJson(Map<String, dynamic> json) =>
      _$FuturedVideoFromJson(json);
  Map<String, dynamic> toJson(FeaturedVideo json) => _$FuturedVideoToJson(json);
}

@JsonSerializable()
class Item {
  Data data;
  Item(this.data);
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson(Item json) => _$ItemToJson(json);
}

@JsonSerializable()
class Data {
  String playUrl;
  Data(this.playUrl);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson(Data json) => _$DataToJson(json);
}

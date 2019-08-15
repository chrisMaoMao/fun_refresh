import 'package:json_annotation/json_annotation.dart';
part 'player.g.dart';

@JsonSerializable()
class PlayerModel {
  PlayerModel(this.itemList);
  final List<Item> itemList;
  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
  Map<String, dynamic> toJson(PlayerModel instance) =>
      _$PlayerModelToJson(instance);
}

@JsonSerializable()
class Item {
  Item(this.data, this.type);
  final Data data;
  final String type;
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson(Item instance) => _$ItemToJson(instance);
}

@JsonSerializable()
class Data {
  Data(this.text, this.content);
  final String text;
  final Content content;
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
}

@JsonSerializable()
class Content {
  Content(this.data);
  final InnerData data;
  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson(Content instance) => _$ContentToJson(instance);
}

@JsonSerializable()
class InnerData {
  InnerData(this.title, this.author, this.cover, this.playUrl);
  final String title;
  final Author author;
  final Cover cover;
  final String playUrl;
  factory InnerData.fromJson(Map<String, dynamic> json) =>
      _$InnerDataFromJson(json);
  Map<String, dynamic> toJson(InnerData instance) =>
      _$InnerDataToJson(instance);
}

@JsonSerializable()
class Author {
  Author(this.icon, this.name);
  final String icon;
  final String name;
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson(Author instance) => _$AuthorToJson(instance);
}

@JsonSerializable()
class Cover {
  Cover(this.detail);
  final String detail;
  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map<String, dynamic> toJson(Cover instance) => _$CoverToJson(instance);
}

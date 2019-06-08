// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedVideo _$FuturedVideoFromJson(Map<String, dynamic> json) {
  return FeaturedVideo((json['itemList'] as List)
      ?.map((e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$FuturedVideoToJson(FeaturedVideo instance) =>
    <String, dynamic>{'itemList': instance.itemList};

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ItemToJson(Item instance) =>
    <String, dynamic>{'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(json['playUrl'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'playUrl': instance.playUrl};

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:fua/services/authServise.dart';

class ImageService {
  Future<List<ImageModel>> getImages() async {
    var response = await http.get(Uri.parse("${BaseUrl().baseUrl}listImage"));

    try {
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        return list.map((e) => ImageModel.fromJson(e)).toList();
      } else {
        return <ImageModel>[];
      }
    } on Exception catch (e) {
      print(e);
      return <ImageModel>[];
    }

    // print(response);
  }
}

List<ImageModel> imageModelFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    required this.id,
    required this.label,
    required this.image,
  });

  int id;
  String label;
  String image;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        label: json["label"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "image": image,
      };
}

// class Images {
//   int id;
//   String label;
//   String imageUrl;
//   Images({
//     required this.id,
//     required this.label,
//     required this.imageUrl,
//   });

//   factory Images.fromJson(map) {
//     return Images(id: map['id'], label: map['label'], imageUrl: map['image']);
//   }
// }

// class ImageList {
//   List<Images> imageList;
//   ImageList({
//     required this.imageList,
//   });

//   factory ImageList.fromList(List list) {
//     List<Images> _images = [];

//     list.forEach((element) {
//       _images.add(Images.fromJson(element));
//     });
//     return ImageList(imageList: _images);
//   }
// }

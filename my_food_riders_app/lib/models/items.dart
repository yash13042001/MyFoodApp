import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? menuID;
  String? sellerUID;
  String? itemID;
  String? title;
  String? shortInfo;
  Timestamp? publishedDate;
  String? thumnbnailURL;
  String? longDescription;
  String? status;
  int? price;

  Items({
    this.menuID,
    this.sellerUID,
    this.itemID,
    this.title,
    this.shortInfo,
    this.publishedDate,
    this.thumnbnailURL,
    this.longDescription,
    this.status,
    this.price,
  });

  Items.fromJson(Map<String, dynamic> json) {
    menuID = json['menuID'];
    sellerUID = json['sellerUID'];
    itemID = json['itemID'];
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumnbnailURL = json['thumnbnailURL'];
    longDescription = json["longDescription"];
    status = json['status'];
    price = json["price"];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["menuID"] = menuID;
    data["sellerUID"] = sellerUID;
    data["itemID"] = itemID;
    data["title"] = title;
    data["shortInfo"] = shortInfo;
    data["publishedDate"] = publishedDate;
    data["thumnbnailURL"] = thumnbnailURL;
    data["longDescription"] = longDescription;
    data["status"] = status;
    data["price"] = price;

    return data;
  }
}

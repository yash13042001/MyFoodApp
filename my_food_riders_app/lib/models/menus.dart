import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumnbnailURL;
  String? status;

  Menus({
    this.menuID,
    this.sellerUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.thumnbnailURL,
    this.status,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    menuID = json['menuID'];
    sellerUID = json['sellerUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    publishedDate = json['publishedDate'];
    thumnbnailURL = json['thumnbnailURL'];
    status = json['status'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["menuID"] = menuID;
    data["sellerUID"] = sellerUID;
    data["menuTitle"] = menuTitle;
    data["menuInfo"] = menuInfo;
    data["publishedDate"] = publishedDate;
    data["thumnbnailURL"] = thumnbnailURL;
    data["status"] = status;

    return data;
  }
}

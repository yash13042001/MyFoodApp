class Sellers {
  String? sellersUID;
  String? sellername;
  String? sellerEmail;
  String? sellerAvatarURL;

  Sellers({
    this.sellersUID,
    this.sellername,
    this.sellerEmail,
    this.sellerAvatarURL,
  });

  Sellers.fromJson(Map<String, dynamic> json) {
    sellersUID = json["sellersUID"];
    sellername = json["sellername"];
    sellerEmail = json["sellerEmail"];
    sellerAvatarURL = json["sellerAvatarURL"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sellesUID"] = sellersUID;
    data["sellername"] = sellername;
    data["sellerEmail"] = sellerEmail;
    data["sellerAvatarURL"] =sellerAvatarURL;

    return data;
  }
}

class Favorite {
  String message;
  String favId;
  String userId;
  String locId;
  String favStatus;

  Favorite({this.message, this.favId, this.userId, this.locId, this.favStatus});

  Favorite.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    favId = json['favId'];
    userId = json['userId'];
    locId = json['locId'];
    favStatus = json['favStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['favId'] = this.favId;
    data['userId'] = this.userId;
    data['locId'] = this.locId;
    data['favStatus'] = this.favStatus;
    return data;
  }
}

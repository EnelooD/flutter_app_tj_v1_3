class Favorite {
  String message;
  String locId;
  String userId;

  Favorite(
      {this.message,
        this.locId,
        this.userId});

  Favorite.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    locId = json['locId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['locId'] = this.locId;
    data['userId'] = this.userId;
    return data;
  }
}
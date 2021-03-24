class Locality {
  String message;
  String locId;
  String userId;
  String locName;
  String locDetails;
  String locPostalcode;
  String locStatus;
  String locImage;
  String imageName;
  String userName;
  String userEmail;
  String locLat;
  String locLong;

  Locality(
      {this.message,
        this.locId,
        this.userId,
        this.locName,
        this.locDetails,
        this.locPostalcode,
        this.locStatus,
        this.locImage,
        this.imageName,
        this.userName,
        this.userEmail,
        this.locLat,
        this.locLong});

  Locality.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    locId = json['locId'];
    userId = json['userId'];
    locName = json['locName'];
    locDetails = json['locDetails'];
    locPostalcode = json['locPostalcode'];
    locStatus = json['locStatus'];
    locImage = json['locImage'];
    imageName = json['imageName'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    locLat = json['locLat'];
    locLong = json['locLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['locId'] = this.locId;
    data['userId'] = this.userId;
    data['locName'] = this.locName;
    data['locDetails'] = this.locDetails;
    data['locPostalcode'] = this.locPostalcode;
    data['locStatus'] = this.locStatus;
    data['locImage'] = this.locImage;
    data['imageName'] = this.imageName;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['locLat'] = this.locLat;
    data['locLong'] = this.locLong;
    return data;
  }
}
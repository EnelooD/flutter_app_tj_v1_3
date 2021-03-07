class Locality {
  String message;
  String locId;
  String userId;
  String locName;
  String locDetails;
  String locPostalcode;
  String locStatus;
  String locDate;
  String locImage;

  Locality(
      {this.message,
        this.locId,
        this.userId,
        this.locName,
        this.locDetails,
        this.locPostalcode,
        this.locStatus,
        this.locDate,
        this.locImage});

  Locality.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    locId = json['locId'];
    userId = json['userId'];
    locName = json['locName'];
    locDetails = json['locDetails'];
    locPostalcode = json['locPostalcode'];
    locStatus = json['locStatus'];
    locDate = json['locDate'];
    locImage = json['locImage'];
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
    data['locDate'] = this.locDate;
    data['locImage'] = this.locImage;
    return data;
  }
}
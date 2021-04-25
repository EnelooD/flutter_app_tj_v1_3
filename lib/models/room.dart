class Room {
  String message;
  String roomId;
  String userId;
  String roomName;
  String roomImage;
  String userId1;
  String userId2;
  String roomStatus;
  String roomName1;
  String roomImage1;
  String roomName2;
  String roomImage2;

  String userLogin;

  Room({
    this.message,
    this.roomId,
    this.userId,
    this.roomName,
    this.roomImage,
    this.userId1,
    this.userId2,
    this.roomStatus,
    this.roomName1,
    this.roomImage1,
    this.roomName2,
    this.roomImage2,

    this.userLogin,
  });

  Room.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    roomId = json['roomId'];
    userId = json['userId'];
    roomName = json['roomName'];
    roomImage = json['roomImage'];
    userId1 = json['userId1'];
    userId2 = json['userId2'];
    roomStatus = json['roomStatus'];
    roomName1 = json['roomName1'];
    roomImage1 = json['roomImage1'];
    roomName2 = json['roomName2'];
    roomImage2 = json['roomImage2'];

    userLogin = json['userLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['roomId'] = this.roomId;
    data['userId'] = this.userId;
    data['roomName'] = this.roomName;
    data['roomImage'] = this.roomImage;
    data['userId1'] = this.userId1;
    data['userId2'] = this.userId2;
    data['roomStatus'] = this.roomStatus;
    data['roomName1'] = this.roomName1;
    data['roomImage1'] = this.roomImage1;
    data['roomName2'] = this.roomName2;
    data['roomImage2'] = this.roomImage2;

    data['userLogin'] = this.userLogin;
    return data;
  }
}

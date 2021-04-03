class Room {
  String message;
  String roomId;
  String userId;
  String roomName;
  String roomImage;

  Room({
    this.message,
    this.roomId,
    this.userId,
    this.roomName,
    this.roomImage,
  });

  Room.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    roomId = json['roomId'];
    userId = json['userId'];
    roomName = json['roomName'];
    roomImage = json['roomImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['roomId'] = this.roomId;
    data['userId'] = this.userId;
    data['roomName'] = this.roomName;
    data['roomImage'] = this.roomImage;
    return data;
  }
}

class Message {
  String message;
  String mgId;
  String roomId;
  String userId;
  String mgStatus;
  String mgText;
  String mgModifyDate;

  Message({
    this.message,
    this.mgId,
    this.roomId,
    this.userId,
    this.mgStatus,
    this.mgText,
    this.mgModifyDate,
  });

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mgId = json['mgId'];
    roomId = json['roomId'];
    userId = json['userId'];
    mgStatus = json['mgStatus'];
    mgText = json['mgText'];
    mgModifyDate = json['mgModifyDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['mgId'] = this.mgId;
    data['roomId'] = this.roomId;
    data['userId'] = this.userId;
    data['mgStatus'] = this.mgStatus;
    data['mgText'] = this.mgText;
    data['mgModifyDate'] = this.mgModifyDate;
    return data;
  }
}

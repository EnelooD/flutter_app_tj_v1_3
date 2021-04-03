class Member {
  String message;
  String userId;
  String userName;
  String userEmail;
  String userPassword;
  String userImage;
  String imageName;

  Member(
      {this.message,
        this.userId,
        this.userName,
        this.userEmail,
        this.userPassword,
        this.userImage,
        this.imageName
      });

  Member.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    data['imageName'] = this.imageName;
    return data;
  }
}

// class Membermem {
//
//   String memId;
//   String memName;
//   String memUsername;
//   String memPassword;
//   String memStatus;
//
//   Membermem(
//       {this.memId,
//         this.memName,
//         this.memUsername,
//         this.memPassword,
//         this.memStatus,
//       });
//
//   Membermem.fromJson(Map<String, dynamic> json) {
//     memId = json['memId'];
//     memName = json['memName'];
//     memUsername = json['memUsername'];
//     memPassword = json['memPassword'];
//     memStatus = json['memStatus'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['memId'] = this.memId;
//     data['memName'] = this.memName;
//     data['memUsername'] = this.memUsername;
//     data['memPassword'] = this.memPassword;
//     data['memStatus'] = this.memStatus;
//     return data;
//   }
// }
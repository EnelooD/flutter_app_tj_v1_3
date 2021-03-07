import 'package:flutter_app_tj_v1_3/models/locality.dart';
import 'package:flutter_app_tj_v1_3/models/member.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


final String URL = "oomhen.000webhostapp.com";
//oomhen.000webhostapp.com
Future<List<Member>> apiLoginService(String userEmail, String userPassword) async {

  Member member = Member(
    userEmail: userEmail,
    userPassword: userPassword,
  );

  final response = await http.post(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/login_services/checkLoginService.php'),
    body: json.encode(member.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    //Map<String,String>.from(oldMap)
    final Member_data = await response_data.map<Member>((json) {
      return Member.fromJson(json);
    }).toList();

    return Member_data;
    //return Member_data;
  } else {
    return null;
    //throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}
//-----------------------------------------------------------------
Future<String> getMember(String userEmail) async {

  Member member = Member(
      userEmail: userEmail
  );

  final response = await http.post(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/login_services/getMemberService.php'),
    body: json.encode(member.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    final Member_data = await json.decode(response.body);

    //return response_data['message'];
    return Member_data;
  } else {
    //return null;
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}
//-----------------------------------------------------------------
Future<String> apiregisterService(String userName, String userEmail, String userPassword, String userStatus) async{
  Member member = Member(userName: userName, userEmail: userEmail, userPassword: userPassword, userStatus: userStatus);
  //insertmember.php
  final response = await http.post(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/register_services/insertmember.php'),
    body: json.encode(member.toJson()),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}
//-----------------------------------------------------------------
Future<List<Locality>> getallLocality() async {
  final response = await http.get(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/locality_services/getalllocality.php'),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    //if (response.statusCode == HttpStatus.ok) {
    //final response_data = json.decode(response.body); หรือ
    final response_data = jsonDecode(response.body);
    //print(response_data.toString());

    final Locality_data = await response_data.map<Locality>((json) {
      return Locality.fromJson(json);
    }).toList();

    return Locality_data;
  } else {
    //print(response.statusCode.toString());
    throw Exception('Fail to load Todo from the Internet');
  }
}
//-----------------------------------------------------------------
Future<List<Locality>> getallFavorite() async {
  final response = await http.get(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/locality_services/getallfavorite.php'),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    //if (response.statusCode == HttpStatus.ok) {
    //final response_data = json.decode(response.body); หรือ
    final response_data = jsonDecode(response.body);
    //print(response_data.toString());

    final Locality_data = await response_data.map<Locality>((json) {
      return Locality.fromJson(json);
    }).toList();

    return Locality_data;
  } else {
    //print(response.statusCode.toString());
    throw Exception('Fail to load Todo from the Internet');
  }
}

//-----------------------------------------------------------------
Future<String> updatefriend(
    String locId, String userId, String locDetails, String locImage, String locName) async {
  Locality locality =
  Locality(locId: locId, userId: userId, locDetails: locDetails, locImage: locImage, locName: locName);

  final response = await http.post(
    Uri.encodeFull('https://${URL}/myfriend/updatefriend.php'),
    body: json.encode(locality.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//-----------------------------------------------------------------
Future<String> deletefriend(String userId) async {
  Member friend = Member(userId: userId);

  final response = await http.post(
    Uri.encodeFull('https://${URL}/myfriend/deletefriend.php'),
    body: json.encode(friend.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}
//-----------------------------------------------------------------

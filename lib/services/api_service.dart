import 'package:flutter_app_tj_v1_3/models/favorite.dart';
import 'package:flutter_app_tj_v1_3/models/locality.dart';
import 'package:flutter_app_tj_v1_3/models/member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String URL = "oomhen.000webhostapp.com";
//oomhen.000webhostapp.com

Future<List<Member>> apiLoginService(
    String userEmail,
    String userPassword) async {
  Member member = Member(
    userEmail: userEmail,
    userPassword: userPassword,
  );

  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/login_services/checkLoginService.php'),
    body: json.encode(member.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    //Map<String,String>.from(oldMap)
    print(response_data);

      final Member_data = await response_data.map<Member>((json) {
        return Member.fromJson(json);
      }).toList();

      return Member_data;

  } else {
    return null;
    //throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//-----------------------------------------------------------------
Future<String> apiRegisterService(
    String userName,
    String userEmail,
    String userPassword,
    String userStatus) async {
  Member member = Member(
      userName: userName,
      userEmail: userEmail,
      userPassword: userPassword,
      userStatus: userStatus);
  //insertmember.php
  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/register_services/insertmember.php'),
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
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/locality_services/getalllocality.php'),
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
Future<String> apiRegisterLocalityService(
    String userId,
    String locName,
    String locDetails,
    String locPostalcode,
    String locStatus,
    String imageName,
    String locImage,
    String locLat,
    String locLong) async {
  Locality locality = Locality(
      userId: userId,
      locName: locName,
      locDetails: locDetails,
      locPostalcode: locPostalcode,
      locStatus: locStatus,
      imageName: imageName,
      locImage: locImage,
      locLat: locLat,
      locLong: locLong);

  //insertmember.php
  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/locality_services/insertlocality.php'),
    body: json.encode(locality.toJson()),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 201) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//-----------------------------------------------------------------
Future<String> apiUpdateLocalityService(
    String locId,
    String locName,
    String locDetails,
    String imageName,
    String locImage) async {
  Locality locality = Locality(
      locId: locId,
      locName: locName,
      locDetails: locDetails,
      imageName: imageName,
      locImage: locImage);

  final response = await http.post(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/locality_services/updatelocality.php'),
    body: json.encode(locality.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 201) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//-----------------------------------------------------------------
Future<String> deletefriend(
    String userId) async {
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
Future<List<Locality>> apigetLocalityManage(
    String userId) async {
  Locality locality = Locality(
    userId: userId,
  );

  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/locality_services/getlocalitymanage.php'),
    body: json.encode(locality.toJson()),
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
Future<List<Locality>> apigetLocalityFavorite(
    String userId) async {
  Locality locality = Locality(
    userId: userId,
  );

  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/locality_services/favorite_services/getlocalityfavorite.php'),
    body: json.encode(locality.toJson()),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    //if (response.statusCode == HttpStatus.ok) {
    //final response_data = json.decode(response.body); หรือ
    final response_data = jsonDecode(response.body);

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
Future<List<Favorite>> apigetIconFavorite(
    String userId,
    String locId) async {

  Favorite favorite = Favorite(
    userId: userId,
    locId: locId,
  );


  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/locality_services/favorite_services/geticonfavorite.php'),
    body: json.encode(favorite.toJson()),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    //if (response.statusCode == HttpStatus.ok) {
    //final response_data = json.decode(response.body); หรือ
    final response_data = jsonDecode(response.body);

    final Favorite_data = await response_data.map<Favorite>((json) {
      return Favorite.fromJson(json);
    }).toList();
    return Favorite_data;
  } else {
    //print(response.statusCode.toString());
    throw Exception('Fail to load Todo from the Internet');
  }
}

//-----------------------------------------------------------------
Future<String> apiUpdateFavorite(
    String favId,
    String favStatus) async {
  Favorite favorite = Favorite(
      favId: favId,
      favStatus: favStatus);

  final response = await http.post(
    Uri.encodeFull('https://${URL}/thaiandjourney_services/locality_services/favorite_services/updatefavorite.php'),
    body: json.encode(favorite.toJson()),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 201) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//-----------------------------------------------------------------
Future<String> apiInsertFavorite(
    String userId,
    String locId,
    String favStatus) async {
  Favorite favorite = Favorite(
      userId: userId,
      locId: locId,
      favStatus: favStatus);

  //insertmember.php
  final response = await http.post(
    Uri.encodeFull(
        'https://${URL}/thaiandjourney_services/locality_services/favorite_services/insertfavorite.php'),
    body: json.encode(favorite.toJson()),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 201) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}
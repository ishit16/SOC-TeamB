import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:adai/model/api_model.dart';

// final String _base = "https://notifyme69.herokuapp.com";
// final String _tokenEndpoint = "/api/login/app/";
//var _tokenURL = "https://notifyme69.herokuapp.com/api/login/app/";

Future<Token> getToken(UserLogin userLogin) async {
  //print(_tokenURL);
  print(Uri.https('adaiapp.herokuapp.com', 'core/verify/'));
  var response = await http.post(
    Uri.https('adaiapp.herokuapp.com', 'core/verify/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
    //'{"phone":"+918587863369","otp":"055283"}',
  );
  print(response.body);
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

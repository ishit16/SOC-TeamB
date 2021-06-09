import 'dart:convert';
import 'package:http/http.dart' as http;

class GetPoster {
  List<String> posters = [];

  Future<void> getPoster() async {
    var response = await http.get(
        Uri.parse('http://13.233.224.41:8000/core/get_posters/'));
    var jsonData = jsonDecode(response.body);
    posters.add(jsonData);
  }
}
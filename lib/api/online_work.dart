import 'dart:convert';
import 'dart:developer';
import '../user/user_model.dart';
import 'package:http/http.dart' as http;
import 'imp_information.dart';

class OnlineWork {
  Future<List<User>> getAllUsers() async {
    List<User> list = [];
    try {
      final http.Response response =
          await http.get(Uri.parse(myurl).replace(queryParameters: m));

      if (response.statusCode == 200) {
        //
        var mydata = jsonDecode(response.body);

        for (var i in mydata) {
          list.add(User.fromJson(i));
        }

        return list;
      } else {
        return list;
      }
    } catch (e) {
      log(e.toString());
      return list;
    }
  }

  Future<bool> createUser(Map<String, String> m) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(myurl), body: m, headers: h);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> updateUser(Map<String, String> m, String id) async {
    try {
      final http.Response response =
          await http.patch(Uri.parse(myurl + "/$id"), body: m, headers: h);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      final http.Response response =
          await http.delete(Uri.parse(myurl + "/$id"), headers: h);

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

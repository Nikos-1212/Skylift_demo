import 'dart:convert';

import 'package:demo/entity/user_model.dart';
import 'package:demo/repository/api_host.dart';
import 'package:http/http.dart' as http;

class UserRpository {
  Future<UserModel> getUserList() async {
    try {
      final response = await http.get(
        Uri.parse(Apis.userend),
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data != []) {
        final List list = data.toList();
        List<Record> typeList = [];
        list.forEach((element) {
          typeList.add(Record.fromMap(element));
        });
        final res = List<Record>.from(typeList);
        if (res.isNotEmpty) {
          return UserModel(records: res);
        } else {
          throw Exception(
              'Request was not successful.'); // Throw an exception for unsuccessful response
        }
      } else {
        throw Exception(
            'Failed to fetch data'); // Throw an exception for non-200 status codes
      }
    } catch (exception) {
      throw Exception(
          'Failed to fetch data'); // Throw an exception for any exceptions
    }
  }
}

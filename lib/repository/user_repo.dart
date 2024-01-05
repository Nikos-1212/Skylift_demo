import 'dart:convert';
import 'package:demo/entity/user_model.dart';
import 'package:demo/repository/api_host.dart';
import 'package:demo/repository/api_services.dart';
import 'package:http/http.dart' as http;

class UserRepository implements ApiService{

  final http.Client client;
  UserRepository(this.client);
  @override
 Future<UserModel> getUserList() async {
  try {
    final response = await client.get(
      Uri.parse(Apis.userend),
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200 && data != null && data is List) {
      final List<Record> recordsList =
          data.map((element) => Record.fromMap(element)).toList();

      if (recordsList.isNotEmpty) {
        return UserModel(records: recordsList);
      } else {
        throw Exception('Request was not successful.');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (exception) {
    throw Exception('Failed to fetch data');
  }
}

}

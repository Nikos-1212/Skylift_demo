import 'package:demo/repository/user_repo.dart';
import 'package:http/http.dart' as http;
import '../entity/user_model.dart';

abstract class ApiService {
  // Define methods for making API requests.
  Future<UserModel> getUserList();
  // Add more methods for different HTTP verbs and API actions.

  // Define a method for initializing the API service.
  factory ApiService() {
    // Implement a factory constructor to create an instance of a concrete API service.
    return UserRepository(http.Client()); // Replace with your concrete API service class.
  }
}



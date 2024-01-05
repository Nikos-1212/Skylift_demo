import 'package:demo/entity/user_model.dart';
import 'package:demo/repository/api_host.dart';
import 'package:demo/repository/user_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client{}
void main() {
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    userRepository =UserRepository(mockHttpClient);

  });
  group('getUsers', () { 

      test('fetch get user function with response code 200', () async{
        //Arrange
          when(()=>mockHttpClient.get(Uri.parse(Apis.userend))).thenAnswer((invocation) async{
            return Response('''
[
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "website": "hildegard.org"
  }]
''', 200);
          });        
        //Act
        final user = await userRepository.getUserList();
        //Assert
        expect(user, isA<UserModel>());
      });
      test('if status code is not 200 then shown relevant exception', () async{

          //arrange 
          when(()=> mockHttpClient.get(Uri.parse(Apis.userend))).thenAnswer((invocation) async=> Response('{}', 500));

            //Act
              final user = userRepository.getUserList();

            //Asser
                  expect(user, throwsException);


      }); 
    });
}
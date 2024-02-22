import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:splat_mobile/constants/api_paths.dart';

import 'auth_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  test('user creating should be success', () {
      final client = MockClient();
      when(client.post(
          Uri.parse(base_url + user_path),
          body: jsonEncode({
            "name": 'Hieu Tran',
            "gender": 0,
            "birth_date": "07/07/1997",
            "email": 'abc@gmail.com',
            "phone": "0354420071",
            "avartar": "",
            "password": "12345"
          }))).thenAnswer((realInvocation) async =>
          http.Response({"data":[{"id_":"604f9a44-5f39-4abc-b415-4ac6defea4ab","name":"hieutran","gender":0,"birth_date":"1997-07-07T00:00:00","email":"hieutran@gmail.com","phone":"","status":true,"avartar":"","in_match":null,"hashed_password":"\$2b\$12\$eb2xH0pITy9LZJwEBVf4Sugbo48d9jsvc8Br.NGre.rFZmfZBQfT2","is_superuser":false,"created_at":"2024-02-22T05:47:45.262200","updated_at":null}],"count":1,"message":null,"error":null,"status_code":201}.toString(),201 ));
  });
}
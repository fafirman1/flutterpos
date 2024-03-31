import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos/core/constants/variables.dart';
import 'package:pos/data/models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(String email, String password) async{
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        "email" : email,
        "password" :password,
      }
    );
    if (response.statusCode==200) {
      // Ubah response.body menjadi Map menggunakan jsonDecode()
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      // Gunakan Map yang sudah di-decode untuk membuat AuthResponseModel
      return right(AuthResponseModel.fromJson(responseBody));
    } else {
      return left(response.body);
    } 
  }
  
}
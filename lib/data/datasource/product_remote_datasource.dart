import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos/core/constants/variables.dart';
import 'package:pos/data/datasource/auth_local_datasource.dart';
import 'package:pos/data/models/response/product_response_model.dart';

class ProductRemoteDatasource{
  Future<Either<String, ProductResponseModel>> getProducts() async{
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get (
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: {
        'Authorization' : 'Bearer ${authData.token}'
      }
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else{
      return left(response.body);
    }
  }
}
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_example/networking/Endpoints.dart';

class ApiBaseHelper {
  final String _baseUrl = Endpoints.base_url;

    var headers = {
      'DeviceId': '12345678',
      'Content-Type': 'application/json',
    };

  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response =
          await Dio().get(_baseUrl + url, options: Options(headers: headers));

      if (response.statusCode == 200) {
       // responseJson = jsonDecode(response.data);
        responseJson = response.data;
       // print(responseJson);
      } else {
        throw Exception('Failed to load featured products');
      }
    } catch (e) {
      print(e);
    }
    return responseJson;
  }
}

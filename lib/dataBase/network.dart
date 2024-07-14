import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/model/project.dart';


class Network {
 static String urlApi = 'https://dummyjson.com';

  static Future<List<Products>?> getProducts() async {
    http.Response response = await http.get(Uri.parse("$urlApi/products"));
    Map<dynamic, dynamic> body = jsonDecode(response.body);
    return Product.fromJson(body).products;
  }

}

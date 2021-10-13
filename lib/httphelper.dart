import 'dart:convert';
import 'package:store_data/pizza.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'rgkrj.mocklab.io';
  final String path = 'pizzalist';

  Future<List<Pizza>> getPizzaList() async {
    Uri url = Uri.https(authority, path);
    http.Response result = await http.get(url);
    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      //provide a type argument to the map method to avoid type error
      List<Pizza> pizzas =
          jsonResponse.map<Pizza>((i) => Pizza.fromJson(i)).toList();
      return pizzas;
    } else {
      return [];
    }
  }
}

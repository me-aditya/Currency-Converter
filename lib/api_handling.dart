import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = "015A4E9A-B6A3-4901-8837-79247C36EEB7";
String url = "https://rest.coinapi.io/v1/exchangerate/BTC";

class ApiHandling {
  Future<dynamic> getData(String currency) async {
    String getUrl = "$url/$currency?apikey=$apiKey";
    http.Response response = await http.get(Uri.parse(getUrl));
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
    return data;
  }
}

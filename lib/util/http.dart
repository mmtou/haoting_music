import 'package:dio/dio.dart';

class Http {
  static Future<String> get(String url, {Map param}) async {
    if (param != null) {
      if (!url.contains('?')) {
        url += "?";
      }
      List<String> list =
          param.keys.map((key) => '$key=${param[key]}').toList();
      url += list.join('&');
    }
    print('http request start: $url');
    try {
      Response<String> response = await Dio().get<String>(url);
      print('http request end: ${response.data}');
      return response.data;
    } catch (e) {
      print('http request error: $e');
      return null;
    }
  }
}

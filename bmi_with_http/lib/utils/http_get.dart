import 'package:bmi_with_http/data/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List> fetchData() async {
  String _url =
      'https://raw.githubusercontent.com/RoyARG02/my_flutter_samples/master/bmi_with_http/assets/data/categories.json';
  http.Response _resp;
  try {
    _resp = await http.get(_url);
  } catch (e) {
    print(e.toString());
    return null;
  }
  // if (_resp.statusCode != 200) return null;
  return json.decode(_resp.body);
}

List<Category> bmiCategories;

Future<void> getCategories() async {
  await fetchData().then(
    (onValue) {
      print(onValue);
      bmiCategories = onValue
              ?.map((data) => Category(
                  data["low"], data["high"], data["label"], data["color"]))
              ?.toList() ??
          [];
    },
  );
  print(bmiCategories);
}

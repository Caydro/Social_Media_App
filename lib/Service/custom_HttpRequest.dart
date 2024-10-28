import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> customHttpRequest(
    {required String url, required Map<String, String> body}) async {
  http.Response response = await http.post(Uri.parse(url), body: body);
  Map<String, dynamic> data = jsonDecode(response.body);
  return data;
}

Future<List<Map<String, dynamic>>> customHttpRequestWithList(
    {required String url, required Map<String, String> body}) async {
  List<Map<String, dynamic>> dataWithList = [];

  // Send POST request
  http.Response response = await http.post(Uri.parse(url), body: body);

  // Decode response
  Map<String, dynamic> data = jsonDecode(response.body);

  // Check if the response contains a 'data' key and if it is a list
  if (data.containsKey('data') && data['data'] is List) {
    List<dynamic> dataList = data['data'];

    // Convert each entry in the list to a Map<String, dynamic> and add to dataWithList
    for (var item in dataList) {
      if (item is Map<String, dynamic>) {
        dataWithList.add(item);
      }
    }
  } else if (data.containsKey("error")) {
    return [
      {
        "error": data["error"],
      }
    ];
  }

  // Return the list, either filled or empty
  return dataWithList;
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholar_ai/key.dart';

Future<String> makeApiRequest(String prompt) async {
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$tokenKey';

  final body = {
    'prompt': {
      'text': prompt,
    }
  };
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    String s = jsonDecode(response.body)["candidates"][0]["output"];
    print(jsonDecode(response.body)["candidates"][0]["output"]);
    return s;
    // Handle the API response
  } else {
    return "error";
    // Handle error
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> askGemini(String prompt) async {
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
  );

  final headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": prompt},
        ],
      },
    ],
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['candidates'][0]['content']['parts'][0]['text'];
  } else {
    throw Exception("Gemini API Error: ${response.body}");
  }
}

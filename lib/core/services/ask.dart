import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> askGemini(String prompt) async {
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  // Creates the endpoint URL for Gemini 2.0 Flash model
  final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
  );
  // Sets request type to JSON.
  final headers = {'Content-Type': 'application/json'};
  // Formats the request data into Gemini API’s expected structure
  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": prompt}, // Contains the actual text input (my prompt).
        ],
      },
    ],
  });
  // Sends an HTTP POST request to Gemini.
  final response = await http.post(url, headers: headers, body: body);
  // Handling the Response
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['candidates'][0]['content']['parts'][0]['text'];
  } else {
    throw Exception("Gemini API Error: ${response.body}");
  }
}

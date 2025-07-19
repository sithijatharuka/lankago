import 'package:flutter/material.dart';
import 'package:lankago/ask.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  String response = "";

  void sendPrompt() async {
    setState(() => response = "Thinking...");
    try {
      final result = await askGemini("Give me a one featured destination in Sri Lanka");
      setState(() => response = result);
    } catch (e) {
      setState(() => response = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gemini Chat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Ask something...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: sendPrompt, child: Text("Send")),
            SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: Text(response))),
          ],
        ),
      ),
    );
  }
}

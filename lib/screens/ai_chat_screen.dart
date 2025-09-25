import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
 
  static const String _apiKey = "AIzaSyA8XxwEVGbQcQGzgm44labmGAyp-eWcWpA";
  static const String _endpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent";

  final TextEditingController _input = TextEditingController();
  final List<Map<String, String>> _messages =
      []; // {"role": "user"/"model", "text": "..."}

  bool _sending = false;

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _input.clear();
      _sending = true;
    });

    try {
      // পুরো কনভার্সেশনকে Gemini ফরম্যাটে কনভার্ট
      final contents = _messages.map((m) {
        return {
          "role": m["role"], // "user" বা "model"
          "parts": [
            {"text": m["text"]},
          ],
        };
      }).toList();

      final uri = Uri.parse("$_endpoint?key=$_apiKey");
      final resp = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"contents": contents}),
      );

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final reply =
            data["candidates"][0]["content"]["parts"][0]["text"] as String? ??
            "⚠️ Empty response";
        setState(() {
          _messages.add({"role": "model", "text": reply});
        });
      } else {
        setState(() {
          _messages.add({
            "role": "model",
            "text": "❌ API error (${resp.statusCode}): ${resp.body}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "model", "text": "⚠️ Network error: $e"});
      });
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chatbot"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                final isUser = m["role"] == "user";
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 320),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.green.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        m["text"] ?? "",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (_sending)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: CircularProgressIndicator(),
            ),

          // input bar
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: "Type your message…",
                        filled: true,
                        fillColor: Colors.green.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _send,
                    icon: const Icon(Icons.send, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

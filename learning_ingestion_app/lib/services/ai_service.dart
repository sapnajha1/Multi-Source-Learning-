import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // ← Yaha paste karo
  static const String _apiKey = 'AIzaSyAkQPsSKeLKHYvCMX18CO05P-G9I2W4fr0';

  /// Real AI call
  Future<Map<String, dynamic>> generateLearningMaterial(String inputText) async {
    print("🔥 generateLearningMaterial CALLED");
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiKey',
    );
    final prompt = """
You are an AI that converts learning content into structured output.

Return ONLY valid JSON in this format:
{
  "summary": "...",
  "flashcards": [
    {"question": "...", "answer": "..."}
  ],
  "topics": {
    "Topic": ["Subtopic1", "Subtopic2"]
  }
}

Content:
$inputText
""";

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    print("API status code: ${response.statusCode}");
    print("API body: ${response.body}");
    final data = jsonDecode(response.body);
    final rawText =
    data['candidates'][0]['content']['parts'][0]['text'];

    print("🧾 RAW AI TEXT: $rawText");

// 🔥 Remove markdown
    final cleanedText = rawText
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();

    print("✅ CLEAN JSON: $cleanedText");

    return jsonDecode(cleanedText);
    ;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _apiKey = 'AIzaSyDv07YevmBQZ5SMAIFZfRqKFxAEW_K1jSo';

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
  
  "learningPath": [
    {
      "id": 1,
      "title": "Basic Concept",
      "parentId": null
    },
    {
      "id": 2,
      "title": "Intermediate Concept",
      "parentId": 1
    },
    {
      "id": 3,
      "title": "Advanced Concept",
      "parentId": 2
    }
  ]
}
Rules:
- learningPath must be ordered from basic to advanced
- parentId = null means root topic
- Do not include explanations or markdown
- Return only JSON

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

    final cleanedText = rawText
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();

    print("✅ CLEAN JSON: $cleanedText");

    return jsonDecode(cleanedText);

  }
}

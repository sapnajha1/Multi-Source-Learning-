class LearningOutput {
  final String summary;
  final List<Flashcard> flashcards;
  final Map<String, List<String>> topics;
  // final List<LearningNode> learningPath;

  LearningOutput({
    required this.summary,
    required this.flashcards,
    required this.topics,
    // required this.learningPath,
  });

  factory LearningOutput.fromJson(Map<String, dynamic> json) {
    return LearningOutput(
      summary: json['summary'] ?? '',
      flashcards: (json['flashcards'] as List<dynamic>? ?? [])
          .map((e) => Flashcard.fromJson(e))
          .toList(),
      topics: (json['topics'] as Map<String, dynamic>? ?? {})
          .map(
            (key, value) => MapEntry(
          key,
          List<String>.from(value ?? []),
        ),
      ),
    );
  }
}

class Flashcard {
  final String question;
  final String answer;

  Flashcard({
    required this.question,
    required this.answer,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}

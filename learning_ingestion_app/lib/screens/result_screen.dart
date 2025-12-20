import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../models/learning_output.dart';
import '../widgets/flashcard_tile.dart';

class ResultScreen extends StatefulWidget {
  final String userText;
  const ResultScreen({super.key, required this.userText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  LearningOutput? output;
  bool isLoading = false; // initially false, loader only when AI call

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData(widget.userText);
  }

  Future<void> _loadData(String userText) async {
    print("🟡 _loadData CALLED");
    setState(() => isLoading = true);

    try {
      final aiService = AIService();
      final outputJson = await aiService.generateLearningMaterial(userText);
      final parsedOutput = LearningOutput.fromJson(outputJson);

      setState(() {
        output = parsedOutput;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching AI data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Output'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Summary'),
            Tab(text: 'Flashcards'),
            Tab(text: 'Topics'),
          ],
        ),
      ),
      body:
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
          _buildSummaryTab(),
          _buildFlashcardsTab(),
          _buildTopicsTab(),
        ],
      ),
    );
  }

  /// SUMMARY TAB
  Widget _buildSummaryTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        output?.summary ?? 'No summary yet',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  /// FLASHCARDS TAB
  Widget _buildFlashcardsTab() {
    final flashcards = output?.flashcards ?? [];

    if (flashcards.isEmpty) {
      return const Center(child: Text('No flashcards available'));
    }

    return ListView.builder(
      itemCount: flashcards.length,
      itemBuilder: (context, index) {
        return FlashcardTile(flashcard: flashcards[index]);
      },
    );
  }

  /// TOPICS TAB
  Widget _buildTopicsTab() {
    final topics = output?.topics ?? {};

    if (topics.isEmpty) {
      return const Center(child: Text('No topics found'));
    }

    return ListView(
      children: topics.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key),
          children: entry.value
              .map((subtopic) => ListTile(title: Text(subtopic)))
              .toList(),
        );
      }).toList(),
    );
  }
}

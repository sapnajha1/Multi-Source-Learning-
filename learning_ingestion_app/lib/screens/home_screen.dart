import 'package:flutter/material.dart';
import 'package:learning_ingestion_app/screens/result_screen.dart';
import '../pdf_picker_util.dart';
import 'loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Ingestion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Paste learning content here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isEmpty) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  LoadingScreen(
                      text: _controller.text,
                    ),
                  ),
                );
              },
              child: const Text('Generate Learning Material'),
            ),

            const SizedBox(height: 16,),
            // ElevatedButton(
            //   onPressed: () async {
            //     final pdfPath = await pickPDF();
            //     if (pdfPath != null) {
            //       final pdfText = await extractTextFromPDF(pdfPath);
            //       // Ab pdfText ko ResultScreen me bhej do
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => ResultScreen(userText: pdfText),
            //         ),
            //       );
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text("No PDF selected")),
            //       );
            //     }
            //   },
            //   child: const Text('Choose PDF'),
            // ),

          ],
        ),
      ),
    );
  }
}

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
  String? selectedPdfName;
  String? selectedPdfPath;

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
              onPressed: () async {
                setState(() {
                  selectedPdfName = null;
                  selectedPdfPath = null;
                });

                final pdfPath = await pickPDF();

                if (pdfPath != null) {
                  setState(() {
                    selectedPdfPath = pdfPath;
                    selectedPdfName = pdfPath.split('/').last; // 📄 filename
                  });

                  final pdfText = await extractTextFromPDF(pdfPath);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(userText: pdfText),
                    ),
                  );
                  setState(() {
                    selectedPdfName = null;
                    selectedPdfPath = null;
                  });

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No PDF selected")),
                  );
                }
              },
              child: const Text('Choose PDF'),
            ),
            if (selectedPdfName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedPdfName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),



            const SizedBox(height: 16,),

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

          ],
        ),
      ),
    );
  }
}

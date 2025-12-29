import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';

Future<String?> pickPDF() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.single.path != null) {
    return result.files.single.path!;
  } else {
    return null;
  }
}

Future<String> extractTextFromPDF(String path) async {
  final pdf = await PDFDoc.fromPath(path); // await yahan lagao
  String text = await pdf.text; // yeh bhi await hai
  return text;
}

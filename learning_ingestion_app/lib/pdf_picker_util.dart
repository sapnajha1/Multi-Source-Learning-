// import 'package:file_picker/file_picker.dart';
// import 'package:pdfx/pdfx.dart';
//
// /// Opens a file picker to select a PDF file
// Future<String?> pickPDF() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['pdf'],
//   );
//
//   if (result != null && result.files.single.path != null) {
//     return result.files.single.path!;
//   } else {
//     return null; // user cancelled
//   }
// }
//
// /// Extract text safely from PDF
// Future<String> extractTextFromPDF(String path) async {
//   final document = await PdfDocument.openFile(path);
//   String text = '';
//   for (int i = 1; i <= document.pagesCount; i++) {
//     final page = await document.getPage(i);
//     final pageText = await page.text ?? ''; // null safety
//     text += pageText + '\n';
//     await page.close();
//   }
//   await document.close();
//   return text;
// }

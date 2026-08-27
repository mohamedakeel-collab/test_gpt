part of '../imports/request_details_imports.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({
    super.key,
    required this.url,
  });

  final String url;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.attachments,
        showArrow: true,
        onTap: () {
          Go.back();
        },
      ),

      body: SfPdfViewer.network(
        url,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color bgColor = brightness == Brightness.light ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 37, 37, 37);
    Color textColor = brightness == Brightness.light ? Colors.black : Colors.white;
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://siamatic.co.th/privacy-policy"));
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: bgColor),
            WebViewWidget(controller: controller),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: TextButton.icon(
                  icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 26),
                  onPressed: () => Navigator.pop<String>(context, null),
                  label: Text("BACK", style: TextStyle(color: textColor, fontSize: 18)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 5, right: 15),
                    backgroundColor: bgColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

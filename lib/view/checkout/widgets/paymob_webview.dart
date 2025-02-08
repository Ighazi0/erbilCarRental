import 'package:erbil/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymobWebview extends StatefulWidget {
  final String link;
  const PaymobWebview({super.key, required this.link});

  @override
  State<PaymobWebview> createState() => _PaymobWebviewState();
}

class _PaymobWebviewState extends State<PaymobWebview> {
  double loading = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.link),
              ),
              onNavigationResponse: (controller, navigationResponse) async {
                print(
                    'onNavigationResponse ${navigationResponse.response?.url?.path}');
                return null;
              },
              onLoadResource: (controller, resource) {
                print('onLoadResource ${resource.url?.path}');
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  loading = (progress / 100).toDouble();
                });
              },
            ),
            if (loading < 1)
              LinearProgressIndicator(
                value: loading,
                valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
              )
          ],
        ),
      ),
    );
  }
}

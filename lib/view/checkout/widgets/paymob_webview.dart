import 'package:erbil/controller/checkout_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaymobWebview extends StatefulWidget {
  final CheckoutController checkoutController;
  final String link;
  const PaymobWebview(
      {super.key, required this.link, required this.checkoutController});

  @override
  State<PaymobWebview> createState() => _PaymobWebviewState();
}

class _PaymobWebviewState extends State<PaymobWebview> {
  double loading = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(widget.link),
            ),
            onNavigationResponse: (controller, navigationResponse) async {
              if (navigationResponse.response?.url?.path
                      .contains('checkIcon') ??
                  false) {
                widget.checkoutController.success = true;
                Get.back();
              }
              if (navigationResponse.response?.url?.path
                      .contains('paymentDeclinedIcon') ??
                  false) {
                widget.checkoutController.success = false;
              }
              Get.log(
                  'onNavigationResponse ${navigationResponse.response?.url?.path}');
              return null;
            },
            onLoadResource: (controller, resource) {
              if (resource.url?.path.contains('checkIcon') ?? false) {
                widget.checkoutController.success = true;
                Get.back();
              }
              if (resource.url?.path.contains('paymentDeclinedIcon') ?? false) {
                widget.checkoutController.success = false;
              }
              Get.log('onLoadResource ${resource.url?.path}');

              // /unifiedcheckout/paymentDeclinedIcon.b59dc2a94db88dc5bd5e0dabb15e88d1.svg
              // /unifiedcheckout/checkIcon.ea60e7f70bbed567734b46b9f87445e7.svg
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
    );
  }
}

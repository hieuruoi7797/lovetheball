import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWithGoogleScreen extends StatefulWidget {
  const LoginWithGoogleScreen({super.key});

  @override
  State<LoginWithGoogleScreen> createState() => _LoginWithGoogleScreenState();
}

class _LoginWithGoogleScreenState extends State<LoginWithGoogleScreen> {
  @override
  Widget build(BuildContext context) {
    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams());
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadHtmlString(AuthenticationBloc.html);
      // ..loadRequest(Uri.parse('https://flutter.dev'));
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Renders the live site in an embedded browser on Android and iOS.
///
/// Desktop builds (and platforms without a WebView plugin) fall back to the
/// designed artwork.
class WebsiteEmbed extends StatefulWidget {
  const WebsiteEmbed({super.key, required this.url, required this.fallback});

  final String url;
  final Widget fallback;

  @override
  State<WebsiteEmbed> createState() => _WebsiteEmbedState();
}

class _WebsiteEmbedState extends State<WebsiteEmbed> {
  static bool get _supported => Platform.isAndroid || Platform.isIOS;

  WebViewController? _controller;
  bool _loading = true;
  bool _failed = false;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    if (!_supported) return;
    final uri = Uri.tryParse(widget.url);
    if (uri == null) {
      _failed = true;
      return;
    }
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF5F3EE))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            if (!mounted) return;
            setState(() => _progress = value);
          },
          onPageStarted: (_) {
            if (!mounted) return;
            setState(() {
              _loading = true;
              _failed = false;
            });
          },
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() {
              _loading = false;
              _progress = 100;
            });
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            if (error.isForMainFrame ?? true) {
              setState(() {
                _loading = false;
                _failed = true;
              });
            }
          },
        ),
      )
      ..loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (controller == null || _failed) return widget.fallback;
    return Stack(
      fit: StackFit.expand,
      children: [
        WebViewWidget(controller: controller),
        if (_loading)
          Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(
              value: _progress <= 0 ? null : _progress / 100,
              minHeight: 2.5,
            ),
          ),
      ],
    );
  }
}

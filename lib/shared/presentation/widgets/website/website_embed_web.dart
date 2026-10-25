import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

int _viewCounter = 0;

class WebsiteEmbed extends StatefulWidget {
  const WebsiteEmbed({super.key, required this.url, required this.fallback});

  final String url;
  final Widget fallback;

  @override
  State<WebsiteEmbed> createState() => _WebsiteEmbedState();
}

class _WebsiteEmbedState extends State<WebsiteEmbed> {
  String? _viewType;

  @override
  void initState() {
    super.initState();
    final viewType = 'folio-website-${_viewCounter++}';
    final iframe = web.HTMLIFrameElement()
      ..src = widget.url
      ..title = 'Live website preview';
    iframe.style
      ..border = '0'
      ..width = '100%'
      ..height = '100%'
      ..backgroundColor = '#F5F3EE';
    iframe.setAttribute('loading', 'lazy');
    iframe.setAttribute('allow', 'fullscreen; clipboard-write');
    iframe.setAttribute('referrerpolicy', 'no-referrer');
    ui_web.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => iframe,
    );
    _viewType = viewType;
  }

  @override
  Widget build(BuildContext context) {
    final viewType = _viewType;
    if (viewType == null) return widget.fallback;
    return HtmlElementView(viewType: viewType);
  }
}

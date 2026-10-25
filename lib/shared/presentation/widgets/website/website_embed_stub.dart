import 'package:flutter/widgets.dart';

class WebsiteEmbed extends StatelessWidget {
  const WebsiteEmbed({super.key, required this.url, required this.fallback});

  final String url;
  final Widget fallback;

  @override
  Widget build(BuildContext context) => fallback;
}

import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';

class FolioWordmark extends StatelessWidget {
  const FolioWordmark({
    super.key,
    this.fontSize = 25,
    this.color,
    this.dotColor,
    this.showDot = true,
  });

  final double fontSize;
  final Color? color;
  final Color? dotColor;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final ink = color ?? context.folio.ink;
    final dot = dotColor ?? context.folio.accent;
    return Semantics(
      label: 'Folio, beranda',
      button: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'folio',
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: fontSize,
              height: 0.95,
              letterSpacing: -1.4,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          if (showDot)
            Padding(
              padding: EdgeInsets.only(
                left: fontSize * 0.07,
                bottom: fontSize * 0.12,
              ),
              child: Container(
                width: fontSize * 0.22,
                height: fontSize * 0.22,
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}

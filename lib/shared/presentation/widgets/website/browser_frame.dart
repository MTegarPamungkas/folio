import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';

class BrowserFrame extends StatelessWidget {
  const BrowserFrame({
    super.key,
    required this.address,
    required this.child,
    this.height,
    this.onReload,
    this.onOpen,
    this.compact = false,
  });

  final String address;
  final Widget child;
  final double? height;
  final VoidCallback? onReload;
  final VoidCallback? onOpen;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final chromeHeight = compact ? 30.0 : 42.0;
    final iconSize = compact ? 13.0 : 17.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1917),
        borderRadius: BorderRadius.circular(compact ? 14 : 20),
        border: Border.all(color: const Color(0xFF35322D)),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: compact ? 18 : 30,
            offset: Offset(0, compact ? 8 : 16),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: chromeHeight,
            padding: EdgeInsets.symmetric(horizontal: compact ? 9 : 14),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1917),
              border: Border(bottom: BorderSide(color: Color(0xFF35322D))),
            ),
            child: Row(
              children: [
                for (final dotColor in const [
                  Color(0xFFFF6B55),
                  Color(0xFFF2C14E),
                  Color(0xFF7CBF8A),
                ]) ...[
                  Container(
                    width: compact ? 6 : 8,
                    height: compact ? 6 : 8,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: compact ? 4 : 6),
                ],
                SizedBox(width: compact ? 5 : 10),
                Expanded(
                  child: Container(
                    height: compact ? 18 : 24,
                    padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF272520),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: compact ? 8 : 10,
                          color: const Color(0xFFAAA398),
                        ),
                        SizedBox(width: compact ? 4 : 6),
                        Expanded(
                          child: Text(
                            address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: compact ? 7 : 9.5,
                              color: const Color(0xFFD5CFC3),
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (onReload != null) ...[
                  SizedBox(width: compact ? 4 : 8),
                  _BrowserAction(
                    icon: Icons.refresh_rounded,
                    tooltip: 'Muat ulang preview',
                    size: iconSize,
                    onPressed: onReload!,
                  ),
                ],
                if (onOpen != null) ...[
                  SizedBox(width: compact ? 1 : 4),
                  _BrowserAction(
                    icon: Icons.arrow_outward_rounded,
                    tooltip: 'Buka langsung',
                    size: iconSize,
                    onPressed: onOpen!,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: colors.surface,
              child: ClipRect(child: child),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowserAction extends StatelessWidget {
  const _BrowserAction({
    required this.icon,
    required this.tooltip,
    required this.size,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: size, color: const Color(0xFFD5CFC3)),
        ),
      ),
    );
  }
}

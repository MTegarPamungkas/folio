import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';

class AvailabilityBadge extends StatelessWidget {
  const AvailabilityBadge({
    super.key,
    required this.label,
    this.compact = false,
    this.color,
    this.backgroundColor,
  });

  final String label;
  final bool compact;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final dotColor = color ?? colors.success;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 12,
        vertical: compact ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: compact ? 9.5 : 10,
                letterSpacing: 0.35,
                color: colors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

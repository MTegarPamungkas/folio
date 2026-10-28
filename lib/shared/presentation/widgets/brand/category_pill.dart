import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

class CategoryPill extends StatelessWidget {
  const CategoryPill({
    super.key,
    required this.category,
    this.onDark = false,
    this.color,
  });

  final ProjectCategory category;
  final bool onDark;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final resolved = color ?? (onDark ? Colors.white : colors.ink);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: onDark
            ? Colors.white.withValues(alpha: 0.12)
            : colors.surface.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: onDark ? Colors.white.withValues(alpha: 0.2) : colors.line,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, size: 12, color: resolved),
          const SizedBox(width: 5),
          Text(
            context.tr(category.label),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 9.5,
              letterSpacing: 0.45,
              color: resolved,
            ),
          ),
        ],
      ),
    );
  }
}

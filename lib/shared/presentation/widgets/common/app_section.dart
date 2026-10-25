import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.label, {super.key, this.color, this.showLine = true});

  final String label;
  final Color? color;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final resolved = color ?? colors.inkMuted;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLine) ...[
          Container(width: 18, height: 1.5, color: color ?? colors.accent),
          const SizedBox(width: 9),
        ],
        Flexible(
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: resolved,
              letterSpacing: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.eyebrow,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final String? subtitle;
  final Widget? action;
  final String? eyebrow;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;

    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 620;
          final titleBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null) ...[
                Eyebrow(eyebrow!),
                const SizedBox(height: 12),
              ],
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: compact ? 25 : 29,
                  letterSpacing: -0.9,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 7),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.inkMuted,
                    height: 1.55,
                  ),
                ),
              ],
            ],
          );

          if (action == null) return titleBlock;
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [titleBlock, const SizedBox(height: 14), action!],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: titleBlock),
              const SizedBox(width: 28),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: action!,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ArrowAction extends StatelessWidget {
  const ArrowAction({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.arrow_outward_rounded,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: colors.ink,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        minimumSize: const Size(0, 44),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: colors.surfaceElevated,
              shape: BoxShape.circle,
              border: Border.all(color: colors.line),
            ),
            child: Icon(icon, size: 15, color: colors.ink),
          ),
        ],
      ),
    );
  }
}

class PageIntro extends StatelessWidget {
  const PageIntro({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.maxSubtitleWidth = 600,
  });

  final String eyebrow;
  final Widget title;
  final String? subtitle;
  final double maxSubtitleWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(eyebrow),
        const SizedBox(height: 14),
        title,
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxSubtitleWidth),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.inkMuted,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Re-exported to make feature headers visually consistent.
class SectionSpacing extends StatelessWidget {
  const SectionSpacing({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: context.sectionGap);
}

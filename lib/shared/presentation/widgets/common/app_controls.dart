import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';

class TechPill extends StatelessWidget {
  const TechPill({
    super.key,
    required this.label,
    this.compact = false,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool compact;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 13,
        vertical: compact ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: selected ? colors.ink : colors.surfaceElevated,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: selected ? colors.ink : colors.line),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: compact ? 11 : 12,
          color: selected ? colors.background : colors.inkMuted,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );

    if (onTap == null) return content;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: content,
      ),
    );
  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 42,
    this.background,
    this.foreground,
    this.border = true,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final double size;
  final Color? background;
  final Color? foreground;
  final bool border;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final button = SizedBox(
      width: size,
      height: size,
      child: Material(
        color: background ?? colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size / 2),
          side: border ? BorderSide(color: colors.line) : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Icon(icon, size: size * 0.47, color: foreground ?? colors.ink),
        ),
      ),
    );

    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}

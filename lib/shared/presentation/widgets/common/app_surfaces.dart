import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';

class HoverLift extends StatefulWidget {
  const HoverLift({
    super.key,
    required this.child,
    this.enabled = true,
    this.scale = 1.012,
    this.offset = -3,
  });

  final Widget child;
  final bool enabled;
  final double scale;
  final double offset;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) {
        if (widget.enabled) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (widget.enabled) setState(() => _hovering = false);
      },
      child: AnimatedScale(
        scale: _hovering ? widget.scale : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedSlide(
          offset: Offset(0, _hovering ? widget.offset / 100 : 0),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

class FolioSurface extends StatelessWidget {
  const FolioSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.borderRadius = 22,
    this.onTap,
    this.border = true,
    this.hoverable = false,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool border;
  final bool hoverable;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: color ?? colors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ? Border.all(color: colors.line) : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          overlayColor: WidgetStatePropertyAll(
            colors.ink.withValues(alpha: 0.035),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );

    if (onTap == null) return content;
    final semantics = Semantics(
      button: true,
      label: semanticLabel,
      child: content,
    );
    return hoverable ? HoverLift(child: semantics) : semantics;
  }
}

class EmptyCollection extends StatelessWidget {
  const EmptyCollection({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 56),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colors.accentSoft,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, size: 30, color: colors.accent),
          ),
          const SizedBox(height: 22),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.inkMuted),
            ),
          ),
          if (action != null) ...[const SizedBox(height: 22), action!],
        ],
      ),
    );
  }
}

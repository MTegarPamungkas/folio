import 'package:flutter/material.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:go_router/go_router.dart';

class MakerSection extends StatelessWidget {
  const MakerSection({super.key, required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.ink,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -90,
            top: -120,
            child: Container(
              width: 330,
              height: 330,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.background.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: AdaptiveTwoPane(
              breakpoint: 700,
              gap: 32,
              compactGap: 26,
              endWidth: 250,
              rowAlignment: CrossAxisAlignment.center,
              start: _MakerCopy(developer: developer),
              end: MakerPortrait(developer: developer),
            ),
          ),
        ],
      ),
    );
  }
}

class _MakerCopy extends StatelessWidget {
  const _MakerCopy({required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 22, height: 1.5, color: colors.accent),
            const SizedBox(width: 9),
            Text(
              'DI BALIK LAYAR',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.background.withValues(alpha: 0.6),
                fontSize: 9,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: colors.background,
              fontSize: context.isCompact ? 30 : 37,
              height: 1.05,
              letterSpacing: -1.2,
            ),
            children: [
              const TextSpan(text: 'Desain yang rapi,\n'),
              TextSpan(
                text: 'kode yang tenang.',
                style: FolioTypography.serif(
                  fontSize: context.isCompact ? 34 : 41,
                  color: colors.accent,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 13),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            '${developer.shortName} menghubungkan riset, desain, dan engineering '
            'untuk membangun produk yang terasa sederhana — dan bertahan lama.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.background.withValues(alpha: 0.65),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => context.go('/about'),
          style: FilledButton.styleFrom(
            backgroundColor: colors.accent,
            foregroundColor: colors.onAccent,
            minimumSize: const Size(0, 48),
          ),
          icon: const Icon(Icons.arrow_outward_rounded, size: 17),
          label: const Text('Kenalan lebih dekat'),
        ),
      ],
    );
  }
}

class MakerPortrait extends StatelessWidget {
  const MakerPortrait({super.key, required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final compact = context.isCompact;
    final size = compact ? 158.0 : 196.0;

    return SizedBox(
      width: compact ? double.infinity : 250,
      height: size + 16,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.accent.withValues(alpha: 0.8),
                    colors.accent.withValues(alpha: 0.25),
                  ],
                ),
                border: Border.all(
                  color: colors.background.withValues(alpha: 0.16),
                ),
              ),
              child: Center(
                child: Text(
                  developer.initials,
                  style: TextStyle(
                    fontFamily: FolioTypography.sans,
                    fontSize: size * 0.3,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -2,
                    color: colors.background,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: compact ? 14 : 8,
              child: _FloatingPill(
                label: 'Flutter',
                icon: Icons.phone_iphone_rounded,
                background: colors.background,
                foreground: colors.ink,
                angle: -0.04,
              ),
            ),
            Positioned(
              bottom: 0,
              left: compact ? 14 : 0,
              child: _FloatingPill(
                label: 'UI / UX',
                icon: Icons.draw_outlined,
                background: colors.surface,
                foreground: colors.ink,
                angle: 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingPill extends StatelessWidget {
  const _FloatingPill({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.angle,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 10.5,
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

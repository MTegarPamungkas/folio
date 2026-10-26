import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/utils/links.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/brand/availability_badge.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:go_router/go_router.dart';

class AboutIntro extends StatelessWidget {
  const AboutIntro({super.key, required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;
    final headingSize = context.responsive<double>(
      compact: 38,
      medium: 45,
      expanded: 55,
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('Tentang saya'),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: headingSize,
              height: 1.03,
              letterSpacing: headingSize * -0.045,
            ),
            children: [
              TextSpan(text: 'Halo, saya ${developer.shortName}.\n'),
              const TextSpan(text: 'Saya bikin produk\nyang '),
              TextSpan(
                text: 'enak dipakai.',
                style: FolioTypography.serif(
                  fontSize: headingSize * 1.06,
                  color: colors.accent,
                  height: 0.98,
                  letterSpacing: -1.1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            developer.bio.split('\n\n').first,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: context.isExpanded ? 16 : 14.5,
              height: 1.7,
              color: colors.inkMuted,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AvailabilityBadge(label: developer.availability, compact: true),
            _InfoPill(
              icon: Icons.location_on_outlined,
              label: developer.location.replaceFirst('West Java, ', ''),
            ),
            _InfoPill(icon: Icons.schedule_rounded, label: developer.timezone),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => context.push('/contact'),
              icon: const Icon(Icons.mail_outline_rounded, size: 18),
              label: const Text('Ajak kolaborasi'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                context.read<ExploreBloc>().add(const ExploreFiltersCleared());
                context.go('/explore');
              },
              icon: const Icon(Icons.grid_view_rounded, size: 17),
              label: const Text('Lihat karya'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final social in developer.socials)
              _SocialButton(social: social),
          ],
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdaptiveTwoPane(
          breakpoint: 850,
          gap: 52,
          compactGap: 28,
          endWidth: 350,
          rowAlignment: CrossAxisAlignment.center,
          start: copy,
          end: _PortraitCard(developer: developer),
        ),
        const SizedBox(height: 36),
        _StatsStrip(developer: developer),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: colors.inkMuted),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10.5,
                color: colors.inkMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.social});

  final SocialLink social;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return InkWell(
      onTap: () => openExternalLink(
        context,
        social.url,
        fallbackMessage: 'Tautan ${social.label} belum bisa dibuka.',
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(social.icon, size: 15, color: colors.inkMuted),
            const SizedBox(width: 7),
            Text(
              social.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 11,
                color: colors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortraitCard extends StatelessWidget {
  const _PortraitCard({required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final height = context.isCompact ? 360.0 : 448.0;
    final locationLabel =
        '${developer.location.split(',').first.trim().toUpperCase()}, ID';
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFB347), Color(0xFFFF5C35), Color(0xFFE74324)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2B1207).withValues(alpha: 0.14),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFD9A3).withValues(alpha: 0.24),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _DotGridPainter(
                color: const Color(0xFF2B1207).withValues(alpha: 0.11),
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2B1207),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    locationLabel,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF2B1207),
                      fontSize: 8,
                      letterSpacing: 0.9,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              developer.initials,
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: height * 0.29,
                height: 1,
                letterSpacing: -height * 0.035,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF241009),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          developer.name,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          developer.role,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 10.5,
                                color: colors.inkMuted,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: colors.accentSoft,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      size: 17,
                      color: colors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  _DotGridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var x = 22.0; x < size.width - 12; x += 24) {
      for (var y = 22.0; y < size.height - 12; y += 24) {
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final stats = [
      ('${developer.yearsExperience}+', 'Tahun pengalaman'),
      ('${developer.projectCount}', 'Proyek & modul'),
      ('${developer.collaborationCount}', 'Kolaborasi'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.line),
          bottom: BorderSide(color: colors.line),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;
          return Row(
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                if (i > 0)
                  Container(
                    width: 1,
                    height: 36,
                    margin: EdgeInsets.symmetric(horizontal: compact ? 12 : 28),
                    color: colors.line,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stats[i].$1,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontSize: compact ? 23 : 30,
                              letterSpacing: -1,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        stats[i].$2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: compact ? 9.5 : 11,
                          color: colors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

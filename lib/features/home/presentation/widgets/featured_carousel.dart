import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/actions/favorite_actions.dart';
import 'package:folio/shared/presentation/widgets/brand/category_pill.dart';
import 'package:folio/shared/presentation/widgets/project/project_icon.dart';
import 'package:folio/shared/presentation/widgets/project/project_pattern_painter.dart';
import 'package:folio/shared/presentation/widgets/phone/phone_mockup.dart';
import 'package:folio/shared/presentation/widgets/website/browser_frame.dart';
import 'package:folio/shared/presentation/widgets/website/website_artwork.dart';
import 'package:go_router/go_router.dart';

class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({super.key, required this.projects});

  final List<Project> projects;

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= widget.projects.length) return;
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 460),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = widget.projects;
    final baseHeight = context.responsive<double>(
      compact: 402,
      medium: 422,
      expanded: 444,
    );
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final height = baseHeight + ((textScale - 1).clamp(0.0, 1.0) * 540);

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: _controller,
            itemCount: projects.length,
            onPageChanged: (value) => setState(() => _current = value),
            itemBuilder: (context, index) {
              return RepaintBoundary(
                child: _FeaturedSlide(project: projects[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final showArrows = constraints.maxWidth >= 620;
            return Row(
              children: [
                for (var i = 0; i < projects.length; i++)
                  Semantics(
                    label: 'Tampilkan pilihan ${i + 1}',
                    button: true,
                    selected: i == _current,
                    child: InkWell(
                      onTap: () => _goTo(i),
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 8,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          width: i == _current ? 26 : 7,
                          height: 5,
                          decoration: BoxDecoration(
                            color: i == _current
                                ? context.folio.ink
                                : context.folio.line,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Text(
                  '${(_current + 1).toString().padLeft(2, '0')} / '
                  '${projects.length.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    letterSpacing: 1,
                    color: context.folio.inkMuted,
                  ),
                ),
                const Spacer(),
                if (showArrows) ...[
                  _CarouselArrow(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Pilihan sebelumnya',
                    dark: false,
                    onPressed: _current == 0 ? null : () => _goTo(_current - 1),
                    disabled: _current == 0,
                  ),
                  const SizedBox(width: 8),
                  _CarouselArrow(
                    icon: Icons.arrow_forward_rounded,
                    tooltip: 'Pilihan berikutnya',
                    dark: true,
                    onPressed: _current == projects.length - 1
                        ? null
                        : () => _goTo(_current + 1),
                    disabled: _current == projects.length - 1,
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  const _CarouselArrow({
    required this.icon,
    required this.tooltip,
    required this.dark,
    required this.onPressed,
    required this.disabled,
  });

  final IconData icon;
  final String tooltip;
  final bool dark;
  final VoidCallback? onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: dark ? colors.ink : colors.surface,
        shape: BoxShape.circle,
        border: dark ? null : Border.all(color: colors.line),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 17,
          color: dark
              ? colors.background
              : disabled
              ? colors.inkMuted.withValues(alpha: 0.4)
              : colors.ink,
        ),
      ),
    );
  }
}

class _FeaturedSlide extends StatelessWidget {
  const _FeaturedSlide({required this.project});

  final Project project;

  String _addressLabel(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return project.name;
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri != null && uri.host.isNotEmpty) return uri.host;
    return rawUrl;
  }

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        final titleSize = context.responsive<double>(
          compact: constraints.maxWidth >= 430 ? 34 : 31,
          medium: 40,
          expanded: 46,
        );

        return ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [p.start, p.end],
                  ),
                ),
              ),
              CustomPaint(
                painter: ProjectPatternPainter(
                  category: project.category,
                  color: p.ink,
                  accent: p.accent,
                ),
              ),
              Positioned(
                right: -constraints.maxWidth * 0.12,
                bottom: -constraints.maxWidth * 0.23,
                child: Container(
                  width: constraints.maxWidth * 0.62,
                  height: constraints.maxWidth * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: p.ink.withValues(alpha: 0.08),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              if (wide)
                Positioned(
                  right: constraints.maxWidth * 0.045,
                  top: 34,
                  bottom: 30,
                  child: Center(
                    child: Transform.rotate(
                      angle: project.isWebsite ? -0.02 : 0.055,
                      child: project.isWebsite
                          ? SizedBox(
                              width: constraints.maxWidth >= 1000 ? 300 : 250,
                              child: BrowserFrame(
                                compact: true,
                                height: constraints.maxWidth >= 1000
                                    ? 200
                                    : 170,
                                address: _addressLabel(project.liveUrl),
                                child: project.hasScreenshots
                                    ? Image.asset(
                                        project.screenshots.first.asset,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        filterQuality: FilterQuality.medium,
                                      )
                                    : WebsiteArtwork(project: project),
                              ),
                            )
                          : PhoneMockup(
                              project: project,
                              variant: 0,
                              width: 173,
                            ),
                    ),
                  ),
                )
              else
                Positioned(
                  top: 66,
                  right: 23,
                  child: ProjectIcon(
                    project: project,
                    size: 72,
                    showShadow: true,
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  wide ? 34 : 24,
                  wide ? 30 : 23,
                  wide ? 34 : 23,
                  wide ? 30 : 23,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CategoryPill(
                          category: project.category,
                          onDark: true,
                          color: p.ink,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: p.ink.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: p.ink.withValues(alpha: 0.14),
                            ),
                          ),
                          child: Text(
                            project.year,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: p.ink,
                                  fontSize: 9,
                                  letterSpacing: 0.7,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: wide
                          ? constraints.maxWidth *
                                (project.isWebsite ? 0.5 : 0.56)
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'PILIHAN SAYA',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: p.ink.withValues(alpha: 0.62),
                                  fontSize: 9,
                                  letterSpacing: 1.6,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            project.editorialTitle,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: p.ink,
                                  fontSize: titleSize,
                                  height: 1.02,
                                  letterSpacing: -titleSize * 0.04,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            project.tagline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: p.ink.withValues(alpha: 0.76),
                                  fontSize: wide ? 13.5 : 12.5,
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                project.isWebsite
                                    ? Icons.language_rounded
                                    : Icons.phone_iphone_rounded,
                                size: 14,
                                color: p.accent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                project.type.label,
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: p.ink,
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              Container(
                                width: 3,
                                height: 3,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: p.ink.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  project.highlight,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: p.ink.withValues(alpha: 0.68),
                                        fontSize: 10.5,
                                      ),
                                ),
                              ),
                              const Spacer(),
                              if (wide)
                                Text(
                                  '${project.year} · ${project.version}',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: p.ink.withValues(alpha: 0.55),
                                        fontSize: 8.5,
                                        letterSpacing: 0.55,
                                      ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 9,
                            runSpacing: 9,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              FilledButton.icon(
                                onPressed: () =>
                                    context.push('/project/${project.id}'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: p.ink,
                                  foregroundColor: p.start,
                                  minimumSize: const Size(0, 46),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 17,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.arrow_outward_rounded,
                                  size: 16,
                                ),
                                label: const Text('Buka proyek'),
                              ),
                              FavoriteIconButton(
                                project: project,
                                background: p.ink.withValues(alpha: 0.12),
                                foreground: p.ink,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

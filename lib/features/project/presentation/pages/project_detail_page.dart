import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/utils/links.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_bloc.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_state.dart';
import 'package:folio/features/project/presentation/widgets/detail_columns.dart';
import 'package:folio/features/project/presentation/widgets/project_hero.dart';
import 'package:folio/features/project/presentation/widgets/related_projects.dart';
import 'package:folio/features/project/presentation/widgets/screens_section.dart';
import 'package:folio/features/project/presentation/widgets/website_preview_section.dart';
import 'package:folio/features/project/presentation/widgets/website_screens_section.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/actions/favorite_actions.dart';
import 'package:folio/shared/presentation/widgets/common/app_controls.dart';
import 'package:folio/shared/presentation/widgets/footer/folio_footer.dart';
import 'package:folio/shared/presentation/widgets/navigation/folio_page_bar.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Column(
              children: [
                FolioPageBar(),
                Expanded(child: Center(child: CircularProgressIndicator())),
              ],
            ),
          );
        }

        final detail = state.detail;
        if (detail == null) {
          return Scaffold(
            body: Column(
              children: [
                const FolioPageBar(),
                Expanded(
                  child: Center(child: Text(context.l10n.projectNotFound)),
                ),
              ],
            ),
          );
        }

        final project = detail.project;
        return Scaffold(
          body: Column(
            children: [
              FolioPageBar(
                actions: [
                  CircularIconButton(
                    icon: Icons.share_outlined,
                    tooltip: context.l10n.shareProject,
                    onPressed: () => _share(context, project),
                  ),
                  const SizedBox(width: 7),
                  FavoriteIconButton(
                    project: project,
                    background: context.folio.surface,
                    foreground: context.folio.ink,
                    size: 42,
                    iconSize: 19,
                    showBorder: true,
                  ),
                ],
              ),
              Expanded(
                child: AdaptivePage(
                  topPadding: 24,
                  bottomPadding: 24,
                  children: [
                    ProjectHero(project: project),
                    const SizedBox(height: 32),
                    if (project.isWebsite) ...[
                      WebsitePreviewSection(project: project),
                      if (project.hasScreenshots) ...[
                        const SizedBox(height: 26),
                        WebsiteScreensSection(project: project),
                      ],
                    ] else ...[
                      ScreensSection(project: project),
                      if (project.hasLiveUrl) ...[
                        const SizedBox(height: 26),
                        WebsitePreviewSection(
                          project: project,
                          heading: context.l10n.webVersion,
                        ),
                      ],
                    ],
                    const SizedBox(height: 38),
                    DetailColumns(project: project),
                    const SizedBox(height: 42),
                    RelatedProjects(projects: detail.relatedProjects),
                    const SizedBox(height: 42),
                    const FolioFooter(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _share(BuildContext context, Project project) {
    final link = kIsWeb
        ? Uri.base
              .removeFragment()
              .replace(fragment: '/project/${project.id}', query: '')
              .toString()
        : '${project.name} — Folio';
    copyToClipboard(context, link, message: context.l10n.projectLinkCopied);
  }
}

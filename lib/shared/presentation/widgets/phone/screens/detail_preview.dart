import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

class ProjectDetailPreview extends StatelessWidget {
  const ProjectDetailPreview({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: p.onScreen.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 11,
                  color: p.onScreen,
                ),
              ),
              const Spacer(),
              Icon(Icons.bookmark_border_rounded, size: 15, color: p.onScreen),
            ],
          ),
          const SizedBox(height: 9),
          Container(
            height: 142,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [p.start, p.end],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -30,
                  top: -30,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: p.ink.withValues(alpha: 0.18)),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    project.icon,
                    size: 58,
                    color: p.ink.withValues(alpha: 0.9),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: p.ink.withValues(alpha: 0.17),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      project.previewMetricIn(context.language),
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7,
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            project.previewTitleIn(context.language),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 16,
              height: 1.05,
              letterSpacing: -0.6,
              fontWeight: FontWeight.w800,
              color: p.onScreen,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            project.previewSubtitleIn(context.language),
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 7.5,
              color: p.screenMuted,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Icon(
                project.isWebsite
                    ? Icons.language_rounded
                    : Icons.phone_iphone_rounded,
                size: 10,
                color: p.start,
              ),
              const SizedBox(width: 3),
              Text(
                project.isWebsite ? 'Web' : 'Mobile',
                style: TextStyle(
                  fontFamily: FolioTypography.sans,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: p.onScreen,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 2.5,
                height: 2.5,
                decoration: BoxDecoration(
                  color: p.screenMuted,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                context.tr(project.category.label),
                style: TextStyle(
                  fontFamily: FolioTypography.sans,
                  fontSize: 7,
                  color: p.screenMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (final item in project.previewItemsIn(context.language))
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: p.onScreen.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 6.5,
                      color: p.onScreen,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            project.descriptionIn(context.language),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 8,
              height: 1.52,
              color: p.screenMuted,
            ),
          ),
          const Spacer(),
          Container(
            height: 31,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: p.start,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              context.tr('Mulai jelajah'),
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 8.5,
                fontWeight: FontWeight.w700,
                color: p.ink,
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

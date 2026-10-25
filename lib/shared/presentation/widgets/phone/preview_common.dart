import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

class PreviewHeader extends StatelessWidget {
  const PreviewHeader({super.key, required this.project, this.trailing});

  final Project project;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [p.start, p.end]),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(project.icon, size: 11, color: p.ink),
        ),
        const SizedBox(width: 6),
        Text(
          project.name.toLowerCase(),
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
            color: p.onScreen,
          ),
        ),
        const Spacer(),
        trailing ??
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: p.onScreen.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 11,
                color: p.onScreen,
              ),
            ),
      ],
    );
  }
}

class PreviewMiniStat extends StatelessWidget {
  const PreviewMiniStat({
    super.key,
    required this.project,
    required this.label,
    required this.value,
  });

  final Project project;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: p.start.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 6.5,
              color: p.screenMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: p.onScreen,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

class ProjectIcon extends StatelessWidget {
  const ProjectIcon({
    super.key,
    required this.project,
    this.size = 64,
    this.radius,
    this.showShadow = false,
  });

  final Project project;
  final double size;
  final double? radius;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? size * 0.27),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.start, p.end],
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: p.start.withValues(alpha: 0.24),
                  blurRadius: size * 0.2,
                  offset: Offset(0, size * 0.08),
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -size * 0.12,
            right: -size * 0.16,
            child: Container(
              width: size * 0.62,
              height: size * 0.62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: p.ink.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -size * 0.2,
            left: -size * 0.08,
            child: Container(
              width: size * 0.55,
              height: size * 0.55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: p.ink.withValues(alpha: 0.18),
                  width: 1.2,
                ),
              ),
            ),
          ),
          Center(
            child: Icon(project.icon, size: size * 0.4, color: p.ink),
          ),
          Positioned(
            right: size * 0.16,
            bottom: size * 0.16,
            child: Container(
              width: size * 0.1,
              height: size * 0.1,
              decoration: BoxDecoration(
                color: p.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/project/presentation/widgets/aside_info.dart';
import 'package:folio/features/project/presentation/widgets/story_section.dart';

class DetailColumns extends StatelessWidget {
  const DetailColumns({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTwoPane(
      breakpoint: 880,
      gap: 34,
      compactGap: 32,
      endWidth: 340,
      start: StorySection(project: project),
      end: AsideInfo(project: project),
    );
  }
}

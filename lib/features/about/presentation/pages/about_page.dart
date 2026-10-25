import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/features/about/presentation/bloc/about_bloc.dart';
import 'package:folio/features/about/presentation/bloc/about_state.dart';
import 'package:folio/features/about/presentation/widgets/about_intro.dart';
import 'package:folio/features/about/presentation/widgets/education_section.dart';
import 'package:folio/features/about/presentation/widgets/experience_section.dart';
import 'package:folio/features/about/presentation/widgets/preferences_contact_section.dart';
import 'package:folio/features/about/presentation/widgets/principles_section.dart';
import 'package:folio/features/about/presentation/widgets/skills_section.dart';
import 'package:folio/shared/presentation/widgets/footer/folio_footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        final developer = state.developer;
        if (developer == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return AdaptivePage(
          topPadding: 28,
          bottomPadding: 24,
          children: [
            AboutIntro(developer: developer),
            SizedBox(height: context.sectionGap),
            PrinciplesSection(principles: developer.principles),
            SizedBox(height: context.sectionGap),
            SkillsSection(groups: developer.skillGroups),
            SizedBox(height: context.sectionGap),
            ExperienceSection(items: developer.experience),
            SizedBox(height: context.sectionGap),
            EducationSection(
              education: developer.education,
              organizations: developer.organizations,
            ),
            SizedBox(height: context.sectionGap),
            const PreferencesContactSection(),
            const SizedBox(height: 42),
            const FolioFooter(),
          ],
        );
      },
    );
  }
}

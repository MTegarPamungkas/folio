import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/features/home/presentation/bloc/home_bloc.dart';
import 'package:folio/features/home/presentation/bloc/home_state.dart';
import 'package:folio/features/home/presentation/widgets/categories_section.dart';
import 'package:folio/features/home/presentation/widgets/featured_carousel.dart';
import 'package:folio/features/home/presentation/widgets/home_intro.dart';
import 'package:folio/features/home/presentation/widgets/latest_releases_section.dart';
import 'package:folio/features/home/presentation/widgets/maker_section.dart';
import 'package:folio/shared/presentation/widgets/footer/folio_footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final content = state.content;
        if (content == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return AdaptivePage(
          topPadding: 24,
          bottomPadding: 24,
          children: [
            HomeIntro(
              developer: content.developer,
              projectCount: content.totalProjects,
            ),
            const SizedBox(height: 34),
            RepaintBoundary(
              child: FeaturedCarousel(projects: content.featuredProjects),
            ),
            SizedBox(height: context.sectionGap),
            RepaintBoundary(
              child: LatestReleasesSection(projects: content.latestProjects),
            ),
            SizedBox(height: context.sectionGap),
            RepaintBoundary(
              child: CategoriesSection(counts: content.categoryCounts),
            ),
            SizedBox(height: context.sectionGap),
            RepaintBoundary(child: MakerSection(developer: content.developer)),
            const SizedBox(height: 38),
            const FolioFooter(),
          ],
        );
      },
    );
  }
}

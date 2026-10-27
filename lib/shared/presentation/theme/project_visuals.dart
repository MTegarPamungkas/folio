import 'package:flutter/material.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/domain/entities/project.dart';

@immutable
class ProjectPalette {
  const ProjectPalette({
    required this.start,
    required this.end,
    required this.ink,
    required this.accent,
    required this.screen,
    required this.onScreen,
    required this.screenMuted,
  });

  final Color start;
  final Color end;
  final Color ink;
  final Color accent;
  final Color screen;
  final Color onScreen;
  final Color screenMuted;
}

@immutable
class ProjectVisual {
  const ProjectVisual({required this.icon, required this.palette});

  final IconData icon;
  final ProjectPalette palette;
}

abstract final class ProjectVisualCatalog {
  static const Map<String, ProjectVisual> _visuals = {
    'loka': ProjectVisual(
      icon: Icons.landscape_rounded,
      palette: ProjectPalette(
        start: Color(0xFF0E5B4F),
        end: Color(0xFFA8C66C),
        ink: Color(0xFFF8F5E8),
        accent: Color(0xFFE9FFAD),
        screen: Color(0xFFF6F1E4),
        onScreen: Color(0xFF17241B),
        screenMuted: Color(0xFF747B64),
      ),
    ),
    'saku': ProjectVisual(
      icon: Icons.account_balance_wallet_rounded,
      palette: ProjectPalette(
        start: Color(0xFF1A2350),
        end: Color(0xFF5368E8),
        ink: Color(0xFFF5F6FF),
        accent: Color(0xFFA7F3D0),
        screen: Color(0xFF0D1430),
        onScreen: Color(0xFFF5F6FF),
        screenMuted: Color(0xFF98A2D6),
      ),
    ),
    'kroma': ProjectVisual(
      icon: Icons.auto_awesome_rounded,
      palette: ProjectPalette(
        start: Color(0xFF4A1D6B),
        end: Color(0xFFFF8C6B),
        ink: Color(0xFFFFF8F4),
        accent: Color(0xFFFFE66D),
        screen: Color(0xFFF8EFF5),
        onScreen: Color(0xFF251A2A),
        screenMuted: Color(0xFF806D82),
      ),
    ),
    'ruang': ProjectVisual(
      icon: Icons.timer_rounded,
      palette: ProjectPalette(
        start: Color(0xFFF06A3C),
        end: Color(0xFFFFC36B),
        ink: Color(0xFF261408),
        accent: Color(0xFFFFF1D0),
        screen: Color(0xFFF6EBDD),
        onScreen: Color(0xFF2A1A10),
        screenMuted: Color(0xFF806C5D),
      ),
    ),
    'pasar': ProjectVisual(
      icon: Icons.storefront_rounded,
      palette: ProjectPalette(
        start: Color(0xFF10100F),
        end: Color(0xFF4A4438),
        ink: Color(0xFFFFF9E8),
        accent: Color(0xFFF6D451),
        screen: Color(0xFF11110F),
        onScreen: Color(0xFFFFF9E8),
        screenMuted: Color(0xFFB7AF9B),
      ),
    ),
    'selara': ProjectVisual(
      icon: Icons.restaurant_rounded,
      palette: ProjectPalette(
        start: Color(0xFF8E1B1B),
        end: Color(0xFFE37A4A),
        ink: Color(0xFFFFF8ED),
        accent: Color(0xFFFFD36E),
        screen: Color(0xFFFAF0E3),
        onScreen: Color(0xFF2B1713),
        screenMuted: Color(0xFF80675D),
      ),
    ),
    'mis-msa': ProjectVisual(
      icon: Icons.engineering_rounded,
      palette: ProjectPalette(
        start: Color(0xFF0B3B36),
        end: Color(0xFF4E8D7C),
        ink: Color(0xFFF3F4EA),
        accent: Color(0xFFD8F3A5),
        screen: Color(0xFFF2F1E8),
        onScreen: Color(0xFF12241F),
        screenMuted: Color(0xFF6A7C74),
      ),
    ),
    'website': ProjectVisual(
      icon: Icons.dashboard_customize_rounded,
      palette: ProjectPalette(
        start: Color(0xFF101B2D),
        end: Color(0xFF2C5C6E),
        ink: Color(0xFFF4F1E8),
        accent: Color(0xFFE7C36A),
        screen: Color(0xFFF1EEE6),
        onScreen: Color(0xFF19222E),
        screenMuted: Color(0xFF6D7784),
      ),
    ),
    'getcrew': ProjectVisual(
      icon: Icons.groups_2_rounded,
      palette: ProjectPalette(
        start: Color(0xFF1C2A5E),
        end: Color(0xFF4F8FD8),
        ink: Color(0xFFF2F6FF),
        accent: Color(0xFFBDEBFF),
        screen: Color(0xFFEFF4FB),
        onScreen: Color(0xFF15213B),
        screenMuted: Color(0xFF6C7C9A),
      ),
    ),
    'tomboati': ProjectVisual(
      icon: Icons.menu_book_rounded,
      palette: ProjectPalette(
        start: Color(0xFF254A3A),
        end: Color(0xFF88A96B),
        ink: Color(0xFFF7F3E6),
        accent: Color(0xFFF3DCA5),
        screen: Color(0xFFF7F1E4),
        onScreen: Color(0xFF1F2A20),
        screenMuted: Color(0xFF747C68),
      ),
    ),
    'movie-finder': ProjectVisual(
      icon: Icons.movie_filter_rounded,
      palette: ProjectPalette(
        start: Color(0xFF3B1F4E),
        end: Color(0xFF9B5D73),
        ink: Color(0xFFFFF7F1),
        accent: Color(0xFFFFD166),
        screen: Color(0xFFF6EFF4),
        onScreen: Color(0xFF2C1B32),
        screenMuted: Color(0xFF816D86),
      ),
    ),
    'story-app': ProjectVisual(
      icon: Icons.auto_stories_rounded,
      palette: ProjectPalette(
        start: Color(0xFF123D4A),
        end: Color(0xFF6C9A8B),
        ink: Color(0xFFF3F6EF),
        accent: Color(0xFFFFE0A3),
        screen: Color(0xFFF2F5F0),
        onScreen: Color(0xFF182A24),
        screenMuted: Color(0xFF71827A),
      ),
    ),
    'dompetektif': ProjectVisual(
      icon: Icons.manage_search_rounded,
      palette: ProjectPalette(
        start: Color(0xFF15191E),
        end: Color(0xFFC9A227),
        ink: Color(0xFFF7F1E3),
        accent: Color(0xFFE8B84B),
        screen: Color(0xFF12161B),
        onScreen: Color(0xFFF4EFE4),
        screenMuted: Color(0xFF9C9588),
      ),
    ),
    'bagi-fair': ProjectVisual(
      icon: Icons.receipt_long_rounded,
      palette: ProjectPalette(
        start: Color(0xFF0D5A45),
        end: Color(0xFF2E9469),
        ink: Color(0xFFF6F1E4),
        accent: Color(0xFFE4703A),
        screen: Color(0xFFF7F2E7),
        onScreen: Color(0xFF14322A),
        screenMuted: Color(0xFF7C8B80),
      ),
    ),
    'lbh-apik': ProjectVisual(
      icon: Icons.balance_rounded,
      palette: ProjectPalette(
        start: Color(0xFF4B0E63),
        end: Color(0xFF8B1FA8),
        ink: Color(0xFFFDF6FF),
        accent: Color(0xFFF6C445),
        screen: Color(0xFFFBF3FD),
        onScreen: Color(0xFF2C0C3A),
        screenMuted: Color(0xFF7B6485),
      ),
    ),
  };

  static ProjectVisual visualFor(Project project) {
    return _visuals[project.id] ??
        ProjectVisual(
          icon: project.category.icon,
          palette: _categoryPalette(project.category),
        );
  }

  static ProjectPalette _categoryPalette(ProjectCategory category) {
    return switch (category) {
      ProjectCategory.travel => _visuals['loka']!.palette,
      ProjectCategory.finance => _visuals['saku']!.palette,
      ProjectCategory.ai => _visuals['kroma']!.palette,
      ProjectCategory.productivity => _visuals['tomboati']!.palette,
      ProjectCategory.commerce => _visuals['pasar']!.palette,
      ProjectCategory.food => _visuals['selara']!.palette,
      ProjectCategory.enterprise => _visuals['mis-msa']!.palette,
      ProjectCategory.career => _visuals['getcrew']!.palette,
      ProjectCategory.experiment => _visuals['movie-finder']!.palette,
      ProjectCategory.website => _visuals['website']!.palette,
    };
  }

  static ProjectPalette paletteForCategory(ProjectCategory category) =>
      _categoryPalette(category);
}

extension ProjectVisuals on Project {
  ProjectVisual get visual => ProjectVisualCatalog.visualFor(this);

  ProjectPalette get palette => visual.palette;

  IconData get icon => visual.icon;

  String get platformLabel => isWebsite
      ? 'Web · Responsif'
      : (hasLiveUrl ? 'Android · Web' : 'iOS · Android');
}

extension ProjectCategoryVisuals on ProjectCategory {
  IconData get icon => switch (this) {
    ProjectCategory.travel => Icons.flight_takeoff_rounded,
    ProjectCategory.finance => Icons.account_balance_wallet_rounded,
    ProjectCategory.ai => Icons.auto_awesome_rounded,
    ProjectCategory.productivity => Icons.timer_rounded,
    ProjectCategory.commerce => Icons.storefront_rounded,
    ProjectCategory.food => Icons.restaurant_rounded,
    ProjectCategory.enterprise => Icons.business_center_rounded,
    ProjectCategory.career => Icons.work_outline_rounded,
    ProjectCategory.experiment => Icons.science_rounded,
    ProjectCategory.website => Icons.language_rounded,
  };

  ProjectPalette get palette => ProjectVisualCatalog.paletteForCategory(this);
}

extension SocialLinkVisuals on SocialLink {
  IconData get icon => switch (platform) {
    SocialPlatform.github => Icons.code_rounded,
    SocialPlatform.linkedin => Icons.work_outline_rounded,
    SocialPlatform.dribbble => Icons.palette_outlined,
  };
}

extension SkillGroupVisuals on SkillGroup {
  IconData get icon => switch (kind) {
    SkillGroupKind.fullStack => Icons.layers_outlined,
    SkillGroupKind.mobile => Icons.phone_iphone_rounded,
    SkillGroupKind.architecture => Icons.account_tree_outlined,
    SkillGroupKind.design => Icons.draw_outlined,
    SkillGroupKind.backend => Icons.dns_outlined,
    SkillGroupKind.product => Icons.checklist_rounded,
  };
}

extension PrincipleVisuals on Principle {
  IconData get icon => switch (title) {
    'Produksi, bukan demo' => Icons.verified_rounded,
    'Offline-first' => Icons.cloud_off_rounded,
    'AI sebagai akselerator' => Icons.auto_awesome_rounded,
    _ => Icons.auto_awesome_rounded,
  };
}

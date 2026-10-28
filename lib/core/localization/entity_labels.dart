import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

/// Localized labels for enum values that are not part of `portfolio.json`.
///
/// Values that are already brand or proper nouns (`Travel`, `Fintech`, …) are
/// passed straight through `t`, mirroring the way content is stored.
String projectTypeLabel(AppLocalizations l10n, ProjectType type) =>
    switch (type) {
      ProjectType.mobileApp => l10n.projectTypeMobile,
      ProjectType.website => l10n.t('Website', 'Website'),
    };

String projectCategoryLabel(AppLocalizations l10n, ProjectCategory category) =>
    switch (category) {
      ProjectCategory.travel => l10n.t('Travel', 'Travel'),
      ProjectCategory.finance => l10n.t('Fintech', 'Fintech'),
      ProjectCategory.ai => l10n.aiCreative,
      ProjectCategory.productivity => l10n.productivity,
      ProjectCategory.commerce => l10n.t('E-commerce', 'E-commerce'),
      ProjectCategory.food => l10n.foodCategory,
      ProjectCategory.enterprise => l10n.t('Enterprise', 'Enterprise'),
      ProjectCategory.career => l10n.career,
      ProjectCategory.experiment => l10n.experiments,
      ProjectCategory.website => l10n.t('Website', 'Website'),
    };

String projectPlatformLabel(AppLocalizations l10n, Project project) {
  final label = project.platformLabel;
  return label == 'Web · Responsif' ? l10n.webResponsive : label;
}

String skillGroupLabel(AppLocalizations l10n, SkillGroupKind kind) =>
    switch (kind) {
      SkillGroupKind.fullStack => l10n.fullStack,
      SkillGroupKind.mobile => l10n.t('Mobile', 'Mobile'),
      SkillGroupKind.architecture => l10n.architecture,
      SkillGroupKind.design => l10n.design,
      SkillGroupKind.backend => l10n.t('Backend', 'Backend'),
      SkillGroupKind.product => l10n.productAndOps,
    };

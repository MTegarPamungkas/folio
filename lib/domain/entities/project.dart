import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/app_language.dart';

enum ProjectType {
  mobileApp('Aplikasi mobile'),
  website('Website');

  const ProjectType(this.label);

  final String label;

  static ProjectType? fromName(String? name) {
    for (final type in values) {
      if (type.name == name) return type;
    }
    return null;
  }
}

enum ProjectCategory {
  travel('Travel', 'travel'),
  finance('Fintech', 'fintech'),
  ai('AI & Kreatif', 'ai-kreatif'),
  productivity('Produktivitas', 'produktivitas'),
  commerce('E-commerce', 'e-commerce'),
  food('Kuliner', 'kuliner'),
  enterprise('Enterprise', 'enterprise'),
  career('Karier', 'career'),
  experiment('Eksperimen', 'eksperimen'),
  website('Website', 'website');

  const ProjectCategory(this.label, this.slug);

  final String label;
  final String slug;

  static ProjectCategory? fromSlug(String? slug) {
    for (final category in ProjectCategory.values) {
      if (category.slug == slug) return category;
    }
    return null;
  }
}

/// One real capture of the running app, used instead of a drawn mockup.
class ProjectScreenshot extends Equatable {
  const ProjectScreenshot({
    required this.asset,
    required this.label,
    this.labelEn,
  });

  final String asset;
  final String label;
  final String? labelEn;

  String labelIn(AppLanguage language) =>
      language.isEnglish ? labelEn ?? label : label;

  @override
  List<Object?> get props => [asset, label, labelEn];
}

class Project extends Equatable {
  const Project({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.story,
    required this.category,
    required this.year,
    required this.role,
    required this.timeline,
    required this.status,
    required this.version,
    required this.updatedAt,
    required this.tech,
    required this.features,
    required this.releaseNotes,
    required this.previewTitle,
    required this.previewSubtitle,
    required this.previewMetric,
    required this.previewMetricLabel,
    required this.previewItems,
    required this.editorialTitle,
    required this.highlight,
    this.taglineEn,
    this.descriptionEn,
    this.storyEn,
    this.timelineEn,
    this.statusEn,
    this.updatedAtEn,
    this.featuresEn = const [],
    this.releaseNotesEn = const [],
    this.previewTitleEn,
    this.previewSubtitleEn,
    this.previewMetricEn,
    this.previewMetricLabelEn,
    this.previewItemsEn = const [],
    this.editorialTitleEn,
    this.highlightEn,
    this.type = ProjectType.mobileApp,
    this.featured = false,
    this.screenshots = const [],
    this.githubUrl,
    this.liveUrl,
    this.downloadUrl,
  });

  final String id;
  final String name;
  final String tagline;
  final String description;
  final String story;
  final ProjectCategory category;
  final String year;
  final String role;
  final String timeline;
  final String status;
  final String version;
  final String updatedAt;
  final List<String> tech;
  final List<String> features;
  final List<String> releaseNotes;
  final String previewTitle;
  final String previewSubtitle;
  final String previewMetric;
  final String previewMetricLabel;
  final List<String> previewItems;
  final String editorialTitle;
  final String highlight;
  final String? taglineEn;
  final String? descriptionEn;
  final String? storyEn;
  final String? timelineEn;
  final String? statusEn;
  final String? updatedAtEn;
  final List<String> featuresEn;
  final List<String> releaseNotesEn;
  final String? previewTitleEn;
  final String? previewSubtitleEn;
  final String? previewMetricEn;
  final String? previewMetricLabelEn;
  final List<String> previewItemsEn;
  final String? editorialTitleEn;
  final String? highlightEn;
  final ProjectType type;
  final bool featured;
  final List<ProjectScreenshot> screenshots;
  final String? githubUrl;
  final String? liveUrl;
  final String? downloadUrl;

  bool get isWebsite => type == ProjectType.website;

  bool get hasScreenshots => screenshots.isNotEmpty;

  /// Real capture for the given slot, or `null` when the project only has the
  /// generated previews.
  ProjectScreenshot? screenshotAt(int index) {
    if (index < 0 || index >= screenshots.length) return null;
    return screenshots[index];
  }

  bool get hasGithubUrl => githubUrl != null && githubUrl!.trim().isNotEmpty;

  bool get hasLiveUrl => liveUrl != null && liveUrl!.trim().isNotEmpty;

  bool get hasDownloadUrl =>
      downloadUrl != null && downloadUrl!.trim().isNotEmpty;

  String taglineIn(AppLanguage language) =>
      _localized(tagline, taglineEn, language);

  String descriptionIn(AppLanguage language) =>
      _localized(description, descriptionEn, language);

  String storyIn(AppLanguage language) => _localized(story, storyEn, language);

  String timelineIn(AppLanguage language) =>
      _localized(timeline, timelineEn, language);

  String statusIn(AppLanguage language) =>
      _localized(status, statusEn, language);

  String updatedAtIn(AppLanguage language) =>
      _localized(updatedAt, updatedAtEn, language);

  List<String> featuresIn(AppLanguage language) =>
      _localizedList(features, featuresEn, language);

  List<String> releaseNotesIn(AppLanguage language) =>
      _localizedList(releaseNotes, releaseNotesEn, language);

  String previewTitleIn(AppLanguage language) =>
      _localized(previewTitle, previewTitleEn, language);

  String previewSubtitleIn(AppLanguage language) =>
      _localized(previewSubtitle, previewSubtitleEn, language);

  String previewMetricIn(AppLanguage language) =>
      _localized(previewMetric, previewMetricEn, language);

  String previewMetricLabelIn(AppLanguage language) =>
      _localized(previewMetricLabel, previewMetricLabelEn, language);

  List<String> previewItemsIn(AppLanguage language) =>
      _localizedList(previewItems, previewItemsEn, language);

  String editorialTitleIn(AppLanguage language) =>
      _localized(editorialTitle, editorialTitleEn, language);

  String highlightIn(AppLanguage language) =>
      _localized(highlight, highlightEn, language);

  bool matches(String normalizedQuery) {
    if (normalizedQuery.isEmpty) return true;
    final haystack = <String>[
      name,
      tagline,
      taglineEn ?? '',
      description,
      descriptionEn ?? '',
      category.label,
      ...tech,
    ].join(' ').toLowerCase();
    return haystack.contains(normalizedQuery);
  }

  @override
  List<Object?> get props => [
    id,
    name,
    tagline,
    description,
    story,
    category,
    year,
    role,
    timeline,
    status,
    version,
    updatedAt,
    tech,
    features,
    releaseNotes,
    previewTitle,
    previewSubtitle,
    previewMetric,
    previewMetricLabel,
    previewItems,
    editorialTitle,
    highlight,
    taglineEn,
    descriptionEn,
    storyEn,
    timelineEn,
    statusEn,
    updatedAtEn,
    featuresEn,
    releaseNotesEn,
    previewTitleEn,
    previewSubtitleEn,
    previewMetricEn,
    previewMetricLabelEn,
    previewItemsEn,
    editorialTitleEn,
    highlightEn,
    type,
    featured,
    screenshots,
    githubUrl,
    liveUrl,
    downloadUrl,
  ];
}

String _localized(String base, String? english, AppLanguage language) =>
    language.isEnglish ? english ?? base : base;

List<String> _localizedList(
  List<String> base,
  List<String> english,
  AppLanguage language,
) => language.isEnglish && english.isNotEmpty ? english : base;

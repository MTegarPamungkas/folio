import 'package:equatable/equatable.dart';

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
    this.type = ProjectType.mobileApp,
    this.featured = false,
    this.githubUrl,
    this.liveUrl,
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
  final ProjectType type;
  final bool featured;
  final String? githubUrl;
  final String? liveUrl;

  bool get isWebsite => type == ProjectType.website;

  bool get hasLiveUrl => liveUrl != null && liveUrl!.trim().isNotEmpty;

  bool matches(String normalizedQuery) {
    if (normalizedQuery.isEmpty) return true;
    final haystack = <String>[
      name,
      tagline,
      description,
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
    type,
    featured,
    githubUrl,
    liveUrl,
  ];
}

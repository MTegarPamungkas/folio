import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/entities/project.dart';

/// Reads the portfolio content from a bundled JSON file.
///
/// The JSON is the single source of truth for the published portfolio. It is
/// loaded once at startup and never edited through the UI.
class PortfolioJsonDataSource {
  PortfolioJsonDataSource([AssetBundle? bundle])
    : _bundle = bundle ?? rootBundle;

  static const String assetPath = 'assets/data/portfolio.json';

  final AssetBundle _bundle;

  Future<PortfolioContent> load() async {
    final raw = await _bundle.loadString(assetPath);
    return parse(raw);
  }

  PortfolioContent parse(String source) {
    final root = _map(jsonDecode(source), 'root');
    return PortfolioContent(
      developer: _developer(_map(root['developer'], 'developer')),
      latestProjectIds: _strings(root['latestProjectIds'], 'latestProjectIds'),
      projects: [
        for (final item in _list(root['projects'], 'projects'))
          _project(_map(item, 'project')),
      ],
    );
  }

  Developer _developer(Map<String, dynamic> json) {
    return Developer(
      name: _string(json['name'], 'developer.name'),
      shortName: _string(json['shortName'], 'developer.shortName'),
      initials: _string(json['initials'], 'developer.initials'),
      role: _string(json['role'], 'developer.role'),
      tagline: _string(json['tagline'], 'developer.tagline'),
      taglineEn: _optionalString(json['taglineEn']),
      bio: _string(json['bio'], 'developer.bio'),
      bioEn: _optionalString(json['bioEn']),
      location: _string(json['location'], 'developer.location'),
      timezone: _string(json['timezone'], 'developer.timezone'),
      email: _string(json['email'], 'developer.email'),
      phone: _string(json['phone'], 'developer.phone'),
      availability: _string(json['availability'], 'developer.availability'),
      availabilityEn: _optionalString(json['availabilityEn']),
      yearsExperience: _integer(
        json['yearsExperience'],
        'developer.yearsExperience',
      ),
      projectCount: _integer(json['projectCount'], 'developer.projectCount'),
      collaborationCount: _integer(
        json['collaborationCount'],
        'developer.collaborationCount',
      ),
      socials: [
        for (final item in _list(json['socials'], 'developer.socials'))
          _social(_map(item, 'developer.social')),
      ],
      skillGroups: [
        for (final item in _list(json['skillGroups'], 'developer.skillGroups'))
          _skillGroup(_map(item, 'developer.skillGroup')),
      ],
      experience: [
        for (final item in _list(json['experience'], 'developer.experience'))
          _experience(_map(item, 'developer.experienceItem')),
      ],
      education: [
        for (final item in _list(json['education'], 'developer.education'))
          _education(_map(item, 'developer.educationItem')),
      ],
      organizations: [
        for (final item in _list(
          json['organizations'],
          'developer.organizations',
        ))
          _organization(_map(item, 'developer.organizationItem')),
      ],
      principles: [
        for (final item in _list(json['principles'], 'developer.principles'))
          _principle(_map(item, 'developer.principle')),
      ],
    );
  }

  SocialLink _social(Map<String, dynamic> json) {
    final platform = SocialPlatform.fromName(
      _string(json['platform'], 'platform'),
    );
    if (platform == null) {
      throw FormatException('Unknown social platform: ${json['platform']}');
    }
    return SocialLink(
      platform: platform,
      handle: _string(json['handle'], 'social.handle'),
      url: _string(json['url'], 'social.url'),
    );
  }

  SkillGroup _skillGroup(Map<String, dynamic> json) {
    final kind = SkillGroupKind.fromName(_string(json['kind'], 'skill.kind'));
    if (kind == null) {
      throw FormatException('Unknown skill group: ${json['kind']}');
    }
    return SkillGroup(kind: kind, skills: _strings(json['skills'], 'skills'));
  }

  ExperienceItem _experience(Map<String, dynamic> json) {
    return ExperienceItem(
      role: _string(json['role'], 'experience.role'),
      company: _string(json['company'], 'experience.company'),
      period: _string(json['period'], 'experience.period'),
      periodEn: _optionalString(json['periodEn']),
      description: _string(json['description'], 'experience.description'),
      descriptionEn: _optionalString(json['descriptionEn']),
      current: json['current'] == true,
    );
  }

  EducationItem _education(Map<String, dynamic> json) {
    return EducationItem(
      degree: _string(json['degree'], 'education.degree'),
      institution: _string(json['institution'], 'education.institution'),
      period: _string(json['period'], 'education.period'),
      location: _string(json['location'], 'education.location'),
    );
  }

  OrganizationItem _organization(Map<String, dynamic> json) {
    return OrganizationItem(
      role: _string(json['role'], 'organization.role'),
      organization: _string(json['organization'], 'organization.name'),
      period: _string(json['period'], 'organization.period'),
      periodEn: _optionalString(json['periodEn']),
    );
  }

  Principle _principle(Map<String, dynamic> json) {
    return Principle(
      title: _string(json['title'], 'principle.title'),
      titleEn: _optionalString(json['titleEn']),
      description: _string(json['description'], 'principle.description'),
      descriptionEn: _optionalString(json['descriptionEn']),
    );
  }

  Project _project(Map<String, dynamic> json) {
    final category = ProjectCategory.fromSlug(
      _string(json['category'], 'project.category'),
    );
    if (category == null) {
      throw FormatException('Unknown project category: ${json['category']}');
    }
    return Project(
      id: _string(json['id'], 'project.id'),
      name: _string(json['name'], 'project.name'),
      tagline: _string(json['tagline'], 'project.tagline'),
      taglineEn: _optionalString(json['taglineEn']),
      description: _string(json['description'], 'project.description'),
      descriptionEn: _optionalString(json['descriptionEn']),
      story: _string(json['story'], 'project.story'),
      storyEn: _optionalString(json['storyEn']),
      category: category,
      type:
          ProjectType.fromName(_optionalString(json['type'])) ??
          ProjectType.mobileApp,
      year: _string(json['year'], 'project.year'),
      role: _string(json['role'], 'project.role'),
      timeline: _string(json['timeline'], 'project.timeline'),
      timelineEn: _optionalString(json['timelineEn']),
      status: _string(json['status'], 'project.status'),
      statusEn: _optionalString(json['statusEn']),
      version: _string(json['version'], 'project.version'),
      updatedAt: _string(json['updatedAt'], 'project.updatedAt'),
      updatedAtEn: _optionalString(json['updatedAtEn']),
      tech: _strings(json['tech'], 'project.tech'),
      features: _strings(json['features'], 'project.features'),
      featuresEn: _optionalStrings(json['featuresEn']),
      releaseNotes: _strings(json['releaseNotes'], 'project.releaseNotes'),
      releaseNotesEn: _optionalStrings(json['releaseNotesEn']),
      previewTitle: _string(json['previewTitle'], 'project.previewTitle'),
      previewTitleEn: _optionalString(json['previewTitleEn']),
      previewSubtitle: _string(
        json['previewSubtitle'],
        'project.previewSubtitle',
      ),
      previewSubtitleEn: _optionalString(json['previewSubtitleEn']),
      previewMetric: _string(json['previewMetric'], 'project.previewMetric'),
      previewMetricEn: _optionalString(json['previewMetricEn']),
      previewMetricLabel: _string(
        json['previewMetricLabel'],
        'project.previewMetricLabel',
      ),
      previewMetricLabelEn: _optionalString(json['previewMetricLabelEn']),
      previewItems: _strings(json['previewItems'], 'project.previewItems'),
      previewItemsEn: _optionalStrings(json['previewItemsEn']),
      editorialTitle: _string(json['editorialTitle'], 'project.editorialTitle'),
      editorialTitleEn: _optionalString(json['editorialTitleEn']),
      highlight: _string(json['highlight'], 'project.highlight'),
      highlightEn: _optionalString(json['highlightEn']),
      featured: json['featured'] == true,
      screenshots: _screenshots(json['screenshots']),
      githubUrl: _optionalString(json['githubUrl']),
      liveUrl: _optionalString(json['liveUrl']),
      downloadUrl: _optionalString(json['downloadUrl']),
    );
  }

  /// Screenshots are optional: projects without them keep the generated
  /// previews.
  List<ProjectScreenshot> _screenshots(Object? value) {
    if (value == null) return const [];
    return [
      for (final item in _list(value, 'project.screenshots'))
        _screenshot(_map(item, 'project.screenshot')),
    ];
  }

  ProjectScreenshot _screenshot(Map<String, dynamic> json) {
    return ProjectScreenshot(
      asset: _string(json['asset'], 'project.screenshot.asset'),
      label: _string(json['label'], 'project.screenshot.label'),
      labelEn: _optionalString(json['labelEn']),
    );
  }

  Map<String, dynamic> _map(Object? value, String field) {
    if (value is Map<String, dynamic>) return value;
    throw FormatException('Expected an object at $field');
  }

  List<dynamic> _list(Object? value, String field) {
    if (value is List<dynamic>) return value;
    throw FormatException('Expected a list at $field');
  }

  List<String> _strings(Object? value, String field) {
    return [
      for (final item in _list(value, field))
        if (item is String)
          item
        else
          throw FormatException('Expected text in $field'),
    ];
  }

  String _string(Object? value, String field) {
    if (value is String) return value;
    throw FormatException('Expected text at $field');
  }

  String? _optionalString(Object? value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    throw FormatException('Expected optional text');
  }

  List<String> _optionalStrings(Object? value) {
    if (value == null) return const [];
    return _strings(value, 'localized list');
  }

  int _integer(Object? value, String field) {
    if (value is int) return value;
    throw FormatException('Expected a number at $field');
  }
}

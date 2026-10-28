import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/data/datasources/portfolio_json_data_source.dart';
import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PortfolioContent content;

  setUpAll(() async {
    content = await PortfolioJsonDataSource().load();
  });

  test('loads the developer identity from JSON', () {
    final developer = content.developer;
    expect(developer.name, 'Muhammad Tegar Pamungkas');
    expect(developer.role, contains('Full Stack'));
    expect(developer.phone, isNotEmpty);
    expect(developer.education, hasLength(2));
    expect(developer.organizations, hasLength(2));
  });

  test('loads the portfolio projects with real CV categories', () {
    expect(content.projects, hasLength(10));
    expect(
      content.projects.map((project) => project.category),
      containsAll([
        ProjectCategory.enterprise,
        ProjectCategory.finance,
        ProjectCategory.career,
        ProjectCategory.productivity,
        ProjectCategory.experiment,
        ProjectCategory.website,
      ]),
    );
    expect(
      content.projects.every((project) => project.highlight.isNotEmpty),
      isTrue,
    );
  });

  test('keeps the Dompetektif web and APK links', () {
    final project = content.projects.singleWhere(
      (project) => project.id == 'dompetektif',
    );
    expect(project.liveUrl, 'https://mtegarpamungkas.github.io/dompetektif/');
    expect(project.githubUrl, contains('dompetektif'));
    expect(project.downloadUrl, contains('/releases/latest'));
  });

  test('ships real screenshots for the showcased projects', () async {
    const expectedCounts = {
      'dompetektif': 6,
      'bagi-fair': 6,
      'lbh-apik': 6,
      'movie-finder': 4,
      'story-app': 6,
      'custom-fit': 6,
      'team-intelligence': 6,
      'tomboati': 6,
      'getcrew': 3,
    };
    for (final entry in expectedCounts.entries) {
      final project = content.projects.singleWhere(
        (project) => project.id == entry.key,
      );
      expect(project.hasScreenshots, isTrue, reason: entry.key);
      expect(project.screenshots, hasLength(entry.value), reason: entry.key);
      for (final screenshot in project.screenshots) {
        expect(screenshot.label, isNotEmpty);
        expect(screenshot.asset, startsWith('assets/screenshots/'));
        final data = await rootBundle.load(screenshot.asset);
        expect(data.lengthInBytes, greaterThan(0));
      }
    }
  });

  test('labels the Kotlin app as Android-only', () {
    final project = content.projects.singleWhere(
      (project) => project.id == 'movie-finder',
    );
    expect(project.platformLabel, 'Android');
  });

  test('projects without screenshots keep the generated previews', () {
    const withScreenshots = {
      'dompetektif',
      'bagi-fair',
      'lbh-apik',
      'movie-finder',
      'story-app',
      'custom-fit',
      'team-intelligence',
      'tomboati',
      'getcrew',
    };
    final others = content.projects.where(
      (project) => !withScreenshots.contains(project.id),
    );
    expect(others.every((project) => !project.hasScreenshots), isTrue);
    expect(others.first.screenshotAt(0), isNull);
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/data/datasources/portfolio_json_data_source.dart';
import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/entities/project.dart';

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
    expect(content.projects, hasLength(8));
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
    for (final id in ['dompetektif', 'bagi-fair', 'lbh-apik']) {
      final project = content.projects.singleWhere(
        (project) => project.id == id,
      );
      expect(project.hasScreenshots, isTrue, reason: id);
      expect(project.screenshots, hasLength(6), reason: id);
      for (final screenshot in project.screenshots) {
        expect(screenshot.label, isNotEmpty);
        expect(screenshot.asset, startsWith('assets/screenshots/'));
        final data = await rootBundle.load(screenshot.asset);
        expect(data.lengthInBytes, greaterThan(0));
      }
    }
  });

  test('projects without screenshots keep the generated previews', () {
    const withScreenshots = {'dompetektif', 'bagi-fair', 'lbh-apik'};
    final others = content.projects.where(
      (project) => !withScreenshots.contains(project.id),
    );
    expect(others.every((project) => !project.hasScreenshots), isTrue);
    expect(others.first.screenshotAt(0), isNull);
  });
}

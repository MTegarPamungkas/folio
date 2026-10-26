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

  test('loads six projects with real CV categories', () {
    expect(content.projects, hasLength(6));
    expect(
      content.projects.map((project) => project.category),
      containsAll([
        ProjectCategory.enterprise,
        ProjectCategory.finance,
        ProjectCategory.career,
        ProjectCategory.productivity,
        ProjectCategory.experiment,
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
}

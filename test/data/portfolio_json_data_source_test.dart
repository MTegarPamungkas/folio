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

  test('loads seven projects with real CV categories', () {
    expect(content.projects, hasLength(7));
    expect(
      content.projects.map((project) => project.category),
      containsAll([
        ProjectCategory.enterprise,
        ProjectCategory.finance,
        ProjectCategory.website,
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

  test('keeps the website project live preview URL', () {
    final website = content.projects.singleWhere(
      (project) => project.type == ProjectType.website,
    );
    expect(website.liveUrl, 'sites/mis-msa.html');
  });
}

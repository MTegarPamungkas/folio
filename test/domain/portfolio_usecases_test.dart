import 'package:flutter_test/flutter_test.dart';
import 'package:folio/data/datasources/portfolio_json_data_source.dart';
import 'package:folio/data/repositories/portfolio_repository_impl.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/domain/usecases/filter_projects.dart';
import 'package:folio/domain/usecases/get_home_content.dart';
import 'package:folio/domain/usecases/get_project_detail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PortfolioRepositoryImpl repository;
  late List<Project> projects;

  setUpAll(() async {
    final content = await PortfolioJsonDataSource().load();
    repository = PortfolioRepositoryImpl(content);
    projects = content.projects;
  });

  group('FilterProjects', () {
    const filter = FilterProjects();

    test('matches project name, technology, and category', () {
      expect(
        filter(projects: projects, query: 'tomboati').single.id,
        'tomboati',
      );
      expect(
        filter(
          projects: projects,
          query: '',
          category: ProjectCategory.enterprise,
        ).single.id,
        'mis-msa',
      );
      expect(
        filter(projects: projects, query: 'geofencing').length,
        greaterThanOrEqualTo(1),
      );
      expect(filter(projects: projects, query: 'tidak-ada').isEmpty, isTrue);
    });
  });

  group('portfolio use cases', () {
    test('home content exposes featured projects and counts', () {
      final content = GetHomeContent(repository)();
      expect(content.featuredProjects, hasLength(6));
      expect(content.latestProjects, hasLength(4));
      expect(content.totalProjects, 10);
      expect(content.categoryCounts[ProjectCategory.enterprise], 1);
      expect(content.categoryCounts[ProjectCategory.finance], 2);
      expect(content.categoryCounts[ProjectCategory.career], 1);
      expect(content.categoryCounts[ProjectCategory.experiment], 2);
      expect(content.categoryCounts[ProjectCategory.website], 1);
      expect(content.categoryCounts[ProjectCategory.ai], 1);
      expect(content.categoryCounts[ProjectCategory.productivity], 2);
    });

    test('project detail resolves project and related projects', () {
      final detail = GetProjectDetail(repository)('mis-msa');
      expect(detail, isNotNull);
      expect(detail!.project.name, 'MIS MSA');
      expect(detail.relatedProjects, hasLength(3));
      expect(
        detail.relatedProjects.any((project) => project.id == 'mis-msa'),
        isFalse,
      );
    });

    test('project detail resolves Dompetektif with its web build', () {
      final detail = GetProjectDetail(repository)('dompetektif');
      expect(detail, isNotNull);
      expect(detail!.project.hasLiveUrl, isTrue);
      expect(detail.project.hasDownloadUrl, isTrue);
    });

    test('project detail returns null for an unknown id', () {
      expect(GetProjectDetail(repository)('missing'), isNull);
    });
  });
}

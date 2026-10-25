import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/domain/usecases/filter_projects.dart';
import 'package:folio/domain/usecases/get_portfolio_content.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/features/explore/presentation/bloc/explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  factory ExploreBloc(
    GetPortfolioContent getPortfolioContent,
    FilterProjects filterProjects,
  ) {
    final projects = getPortfolioContent().projects;
    return ExploreBloc._(projects, filterProjects);
  }

  ExploreBloc._(this._allProjects, this._filterProjects)
    : super(ExploreState(allProjects: _allProjects, results: _allProjects)) {
    on<ExploreQueryChanged>(_onQueryChanged);
    on<ExploreCategoryChanged>(_onCategoryChanged);
    on<ExploreFiltersCleared>(_onFiltersCleared);
  }

  final FilterProjects _filterProjects;
  final List<Project> _allProjects;

  void _onQueryChanged(ExploreQueryChanged event, Emitter<ExploreState> emit) {
    _emitFilters(
      query: event.query,
      category: state.selectedCategory,
      emit: emit,
    );
  }

  void _onCategoryChanged(
    ExploreCategoryChanged event,
    Emitter<ExploreState> emit,
  ) {
    _emitFilters(query: state.query, category: event.category, emit: emit);
  }

  void _onFiltersCleared(
    ExploreFiltersCleared event,
    Emitter<ExploreState> emit,
  ) {
    if (!state.isFiltering) return;
    _emitFilters(query: '', category: null, emit: emit);
  }

  void _emitFilters({
    required String query,
    required ProjectCategory? category,
    required Emitter<ExploreState> emit,
  }) {
    final results = _filterProjects(
      projects: _allProjects,
      query: query,
      category: category,
    );
    emit(
      ExploreState(
        allProjects: _allProjects,
        results: results,
        query: query,
        selectedCategory: category,
      ),
    );
  }
}

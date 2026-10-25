import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/usecases/get_home_content.dart';
import 'package:folio/features/home/presentation/bloc/home_event.dart';
import 'package:folio/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getHomeContent) : super(const HomeState()) {
    on<HomeStarted>(_onStarted);
  }

  final GetHomeContent _getHomeContent;

  void _onStarted(HomeStarted event, Emitter<HomeState> emit) {
    emit(HomeState(content: _getHomeContent()));
  }
}

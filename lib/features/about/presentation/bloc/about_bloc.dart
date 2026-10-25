import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/usecases/get_about_content.dart';
import 'package:folio/features/about/presentation/bloc/about_event.dart';
import 'package:folio/features/about/presentation/bloc/about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc(this._getAboutContent) : super(const AboutState()) {
    on<AboutStarted>(_onStarted);
  }

  final GetAboutContent _getAboutContent;

  void _onStarted(AboutStarted event, Emitter<AboutState> emit) {
    emit(AboutState(developer: _getAboutContent()));
  }
}

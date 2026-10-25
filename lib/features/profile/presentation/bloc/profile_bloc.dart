import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/usecases/get_about_content.dart';
import 'package:folio/features/profile/presentation/bloc/profile_event.dart';
import 'package:folio/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._getAboutContent)
    : super(ProfileState(developer: _getAboutContent())) {
    on<ProfileRefreshRequested>(_onRefreshRequested);
  }

  final GetAboutContent _getAboutContent;

  void _onRefreshRequested(
    ProfileRefreshRequested event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileState(developer: _getAboutContent()));
  }
}

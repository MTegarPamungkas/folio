import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/developer.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.developer});

  final Developer developer;

  @override
  List<Object?> get props => [developer];
}

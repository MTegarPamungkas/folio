import 'package:equatable/equatable.dart';

class ContactRequest extends Equatable {
  const ContactRequest({
    required this.name,
    required this.email,
    required this.projectType,
    required this.message,
  });

  final String name;
  final String email;
  final String projectType;
  final String message;

  @override
  List<Object?> get props => [name, email, projectType, message];
}

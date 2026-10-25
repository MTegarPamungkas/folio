import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/contact_context.dart';

const List<String> contactProjectTypes = [
  'Aplikasi mobile',
  'Desain produk',
  'Konsultasi',
  'Kolaborasi lain',
];

enum ContactStatus { idle, submitting, success, failure }

class ContactState extends Equatable {
  const ContactState({
    required this.context,
    required this.name,
    required this.email,
    required this.projectType,
    required this.message,
    this.status = ContactStatus.idle,
    this.nameError,
    this.emailError,
    this.messageError,
    this.errorMessage,
  });

  final ContactContext context;
  final String name;
  final String email;
  final String projectType;
  final String message;
  final ContactStatus status;
  final String? nameError;
  final String? emailError;
  final String? messageError;
  final String? errorMessage;

  bool get isSubmitting => status == ContactStatus.submitting;

  bool get hasErrors =>
      nameError != null || emailError != null || messageError != null;

  String? get projectName => context.project?.name;

  ContactState copyWith({
    String? name,
    String? email,
    String? projectType,
    String? message,
    ContactStatus? status,
    String? nameError,
    String? emailError,
    String? messageError,
    String? errorMessage,
    bool clearNameError = false,
    bool clearEmailError = false,
    bool clearMessageError = false,
    bool clearErrorMessage = false,
  }) {
    return ContactState(
      context: context,
      name: name ?? this.name,
      email: email ?? this.email,
      projectType: projectType ?? this.projectType,
      message: message ?? this.message,
      status: status ?? this.status,
      nameError: clearNameError ? null : nameError ?? this.nameError,
      emailError: clearEmailError ? null : emailError ?? this.emailError,
      messageError: clearMessageError
          ? null
          : messageError ?? this.messageError,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    context,
    name,
    email,
    projectType,
    message,
    status,
    nameError,
    emailError,
    messageError,
    errorMessage,
  ];
}

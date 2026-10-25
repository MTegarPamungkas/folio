import 'package:equatable/equatable.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => const [];
}

final class ContactNameChanged extends ContactEvent {
  const ContactNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ContactEmailChanged extends ContactEvent {
  const ContactEmailChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ContactProjectTypeChanged extends ContactEvent {
  const ContactProjectTypeChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ContactMessageChanged extends ContactEvent {
  const ContactMessageChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ContactSubmitted extends ContactEvent {
  const ContactSubmitted();
}

final class ContactStatusAcknowledged extends ContactEvent {
  const ContactStatusAcknowledged();
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:folio/features/contact/presentation/bloc/contact_event.dart';
import 'package:folio/features/contact/presentation/bloc/contact_state.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;

    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        final bloc = context.read<ContactBloc>();
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: colors.line),
          ),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: colors.accentSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.edit_note_rounded,
                        size: 20,
                        color: colors.accent,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tulis pesan',
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            'Saya terbuka untuk proyek dan diskusi.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10.5,
                              color: colors.inkMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final fields = [
                      TextFormField(
                        initialValue: state.name,
                        onChanged: (value) =>
                            bloc.add(ContactNameChanged(value)),
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          hintText: 'Nama lengkap',
                          errorText: state.nameError,
                        ),
                      ),
                      TextFormField(
                        initialValue: state.email,
                        onChanged: (value) =>
                            bloc.add(ContactEmailChanged(value)),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'nama@email.com',
                          errorText: state.emailError,
                        ),
                      ),
                    ];

                    if (constraints.maxWidth < 520) {
                      return Column(
                        children: [
                          fields[0],
                          const SizedBox(height: 12),
                          fields[1],
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: fields[0]),
                        const SizedBox(width: 12),
                        Expanded(child: fields[1]),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: state.projectType,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Jenis proyek'),
                  borderRadius: BorderRadius.circular(16),
                  items: [
                    for (final type in contactProjectTypes)
                      DropdownMenuItem(value: type, child: Text(type)),
                  ],
                  onChanged: (value) =>
                      bloc.add(ContactProjectTypeChanged(value ?? '')),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: state.message,
                  onChanged: (value) => bloc.add(ContactMessageChanged(value)),
                  minLines: 5,
                  maxLines: 8,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Pesan',
                    hintText:
                        'Ceritakan sedikit tentang produk, tujuan, dan waktu yang kamu bayangkan…',
                    alignLabelWithHint: true,
                    errorText: state.messageError,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: state.isSubmitting
                      ? null
                      : () => bloc.add(const ContactSubmitted()),
                  icon: state.isSubmitting
                      ? const SizedBox(
                          width: 17,
                          height: 17,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.mail_outline_rounded, size: 18),
                  label: Text(
                    state.isSubmitting
                        ? 'Menyiapkan email…'
                        : 'Buka aplikasi email',
                  ),
                ),
                const SizedBox(height: 11),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 12,
                      color: colors.inkMuted,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Form ini cuma membuka aplikasi email dengan pesan yang sudah '
                        'terisi. Tidak ada data yang dikirim ke server.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 9.5,
                          height: 1.5,
                          color: colors.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

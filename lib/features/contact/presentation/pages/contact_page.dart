import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/utils/links.dart';
import 'package:folio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:folio/features/contact/presentation/bloc/contact_event.dart';
import 'package:folio/features/contact/presentation/bloc/contact_state.dart';
import 'package:folio/features/contact/presentation/widgets/contact_form.dart';
import 'package:folio/features/contact/presentation/widgets/contact_info.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/common/app_feedback.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:folio/shared/presentation/widgets/footer/folio_footer.dart';
import 'package:folio/shared/presentation/widgets/navigation/folio_page_bar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;

    return Scaffold(
      body: Column(
        children: [
          const FolioPageBar(maxWidth: 1120),
          Expanded(
            child: BlocListener<ContactBloc, ContactState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                final bloc = context.read<ContactBloc>();
                if (state.status == ContactStatus.success) {
                  showFolioSnackBar(
                    context,
                    message: context.l10n.openingEmailApp,
                  );
                  bloc.add(const ContactStatusAcknowledged());
                } else if (state.status == ContactStatus.failure) {
                  showFolioSnackBar(
                    context,
                    message: context.l10n.emailAppUnavailableOnDevice,
                    actionLabel: context.l10n.copyEmail,
                    onAction: () => copyToClipboard(
                      context,
                      state.context.developer.email,
                      message: context.l10n.emailCopied,
                    ),
                  );
                  bloc.add(const ContactStatusAcknowledged());
                }
              },
              child: AdaptivePage(
                maxWidth: 1120,
                topPadding: 32,
                bottomPadding: 24,
                children: [
                  PageIntro(
                    eyebrow: context.l10n.contactTitle,
                    title: Text.rich(
                      TextSpan(
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontSize: context.responsive<double>(
                            compact: 39,
                            medium: 49,
                            expanded: 49,
                          ),
                          letterSpacing: -1.8,
                        ),
                        children: [
                          TextSpan(text: context.l10n.contactHeadlineLead),
                          TextSpan(
                            text: context.l10n.contactHeadlineAccent,
                            style: FolioTypography.serif(
                              fontSize: context.responsive<double>(
                                compact: 43,
                                medium: 53,
                                expanded: 53,
                              ),
                              color: colors.accent,
                              height: 0.95,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: context.l10n.contactBody,
                    maxSubtitleWidth: 550,
                  ),
                  const SizedBox(height: 32),
                  const AdaptiveTwoPane(
                    breakpoint: 860,
                    gap: 34,
                    compactGap: 16,
                    startWidth: 320,
                    compactOrder: CompactOrder.endFirst,
                    start: ContactInfo(),
                    end: ContactForm(),
                  ),
                  const SizedBox(height: 44),
                  const FolioFooter(compact: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

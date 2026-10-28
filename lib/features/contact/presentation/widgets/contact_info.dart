import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/utils/links.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:folio/features/contact/presentation/bloc/contact_state.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/brand/availability_badge.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      buildWhen: (previous, current) => previous.context != current.context,
      builder: (context, state) {
        return _ContactInfoContent(developer: state.context.developer);
      },
    );
  }
}

class _ContactInfoContent extends StatelessWidget {
  const _ContactInfoContent({required this.developer});

  final Developer developer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;
    final steps = [
      context.l10n.processStepContext,
      context.l10n.processStepReply,
      context.l10n.processStepSchedule,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvailabilityBadge(label: developer.availabilityIn(context.language)),
        const SizedBox(height: 20),
        _ContactRow(
          icon: Icons.mail_outline_rounded,
          label: context.l10n.email,
          value: developer.email,
          onTap: () => copyToClipboard(
            context,
            developer.email,
            message: context.l10n.emailCopied,
          ),
          trailingIcon: Icons.copy_rounded,
        ),
        const SizedBox(height: 11),
        _ContactRow(
          icon: Icons.phone_outlined,
          label: context.l10n.phone,
          value: developer.phone,
          onTap: () => copyToClipboard(
            context,
            developer.phone,
            message: context.l10n.phoneCopied,
          ),
          trailingIcon: Icons.copy_rounded,
        ),
        const SizedBox(height: 11),
        _ContactRow(
          icon: Icons.location_on_outlined,
          label: context.l10n.location,
          value: developer.location,
        ),
        const SizedBox(height: 11),
        _ContactRow(
          icon: Icons.schedule_rounded,
          label: context.l10n.responseTime,
          value: context.l10n.responseTimeValue,
        ),
        const SizedBox(height: 22),
        Text(
          context.l10n.findMeOn,
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 9,
            letterSpacing: 1.2,
            color: colors.inkMuted,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            for (final social in developer.socials)
              InkWell(
                onTap: () => openExternalLink(
                  context,
                  social.url,
                  fallbackMessage: context.l10n.linkOpenFailed(social.label),
                ),
                borderRadius: BorderRadius.circular(11),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: colors.line),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(social.icon, size: 14, color: colors.inkMuted),
                      const SizedBox(width: 6),
                      Text(
                        social.label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 10.5,
                          color: colors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colors.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.processTitle,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              for (var i = 0; i < steps.length; i++) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: colors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        steps[i],
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          height: 1.55,
                          color: colors.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                if (i != steps.length - 1) const SizedBox(height: 7),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.trailingIcon,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final content = Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 33,
            height: 33,
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 15, color: colors.inkMuted),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 7.5,
                    letterSpacing: 0.9,
                    color: colors.inkMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 11.5),
                ),
              ],
            ),
          ),
          if (trailingIcon != null)
            Icon(trailingIcon, size: 15, color: colors.inkMuted),
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: content,
    );
  }
}

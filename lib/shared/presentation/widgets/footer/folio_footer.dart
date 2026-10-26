import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/utils/links.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/profile/presentation/bloc/profile_state.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/brand/folio_wordmark.dart';

class FolioFooter extends StatelessWidget {
  const FolioFooter({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profile) {
        final colors = context.folio;
        final theme = Theme.of(context);
        final developer = profile.developer;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: compact ? 22 : 30,
            horizontal: compact ? 4 : 8,
          ),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.line)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stack = constraints.maxWidth < 900;
              final brand = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FolioWordmark(fontSize: 21),
                  const SizedBox(height: 7),
                  Text(
                    'Portofolio saya, disusun seperti app store.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11.5,
                      color: colors.inkMuted,
                    ),
                  ),
                ],
              );

              final socialRow = Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final social in developer.socials)
                    Tooltip(
                      message: social.label,
                      child: InkWell(
                        onTap: () => openExternalLink(
                          context,
                          social.url,
                          fallbackMessage:
                              'Tautan ${social.label} belum bisa dibuka.',
                        ),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.line),
                          ),
                          child: Icon(
                            social.icon,
                            size: 16,
                            color: colors.inkMuted,
                          ),
                        ),
                      ),
                    ),
                ],
              );

              final copyright = Text(
                '© ${DateTime.now().year} ${developer.name} · Dibuat dengan Flutter',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10.5,
                  color: colors.inkMuted,
                ),
              );

              if (stack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    brand,
                    const SizedBox(height: 18),
                    socialRow,
                    const SizedBox(height: 16),
                    copyright,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: brand),
                  socialRow,
                  const SizedBox(width: 24),
                  copyright,
                ],
              );
            },
          ),
        );
      },
    );
  }
}

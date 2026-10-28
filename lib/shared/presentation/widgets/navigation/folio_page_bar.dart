import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/brand/folio_wordmark.dart';
import 'package:folio/shared/presentation/widgets/common/app_controls.dart';
import 'package:go_router/go_router.dart';

class FolioPageBar extends StatelessWidget {
  const FolioPageBar({
    super.key,
    this.actions = const [],
    this.showWordmark = true,
    this.maxWidth = AppBreakpoints.contentMaxWidth,
  });

  final List<Widget> actions;
  final bool showWordmark;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(bottom: BorderSide(color: colors.line)),
      ),
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sidePadding = AppBreakpoints.contentInsetFor(
              constraints.maxWidth,
              maxWidth: maxWidth,
            );
            return Padding(
              padding: EdgeInsets.fromLTRB(sidePadding, 10, sidePadding, 10),
              child: Row(
                children: [
                  CircularIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: context.l10n.back,
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                  if (showWordmark) ...[
                    const SizedBox(width: 14),
                    InkWell(
                      onTap: () => context.go('/'),
                      borderRadius: BorderRadius.circular(10),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 6,
                        ),
                        child: FolioWordmark(fontSize: 22),
                      ),
                    ),
                  ],
                  const Spacer(),
                  ...actions,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

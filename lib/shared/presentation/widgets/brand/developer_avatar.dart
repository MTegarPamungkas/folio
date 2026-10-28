import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';

class DeveloperAvatar extends StatelessWidget {
  const DeveloperAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.showStatus = true,
    this.onTap,
  });

  final String initials;
  final double size;
  final bool showStatus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFC857), Color(0xFFFF5C35)],
        ),
        border: Border.all(color: colors.surface, width: 2),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: FolioTypography.sans,
          fontSize: size * 0.32,
          height: 1,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: const Color(0xFF2B1207),
        ),
      ),
    );

    return Semantics(
      label: context.tr('Buka profil'),
      button: onTap != null,
      child: Tooltip(
        message: context.tr('Buka profil'),
        child: InkResponse(
          onTap: onTap,
          radius: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              avatar,
              if (showStatus)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: size * 0.29,
                    height: size * 0.29,
                    decoration: BoxDecoration(
                      color: colors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/core/localization/entity_labels.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/widgets/common/app_controls.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.categories,
    required this.onSelected,
  });

  final ProjectCategory? selected;
  final List<ProjectCategory> categories;
  final ValueChanged<ProjectCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TechPill(
            label: context.l10n.all,
            selected: selected == null,
            onTap: () => onSelected(null),
          ),
          const SizedBox(width: 7),
          for (final category in categories) ...[
            TechPill(
              label: projectCategoryLabel(context.l10n, category),
              selected: selected == category,
              onTap: () => onSelected(selected == category ? null : category),
            ),
            if (category != categories.last) const SizedBox(width: 7),
          ],
        ],
      ),
    );
  }
}

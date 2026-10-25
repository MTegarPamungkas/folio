import 'package:flutter/material.dart';
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
            label: 'Semua',
            selected: selected == null,
            onTap: () => onSelected(null),
          ),
          const SizedBox(width: 7),
          for (final category in categories) ...[
            TechPill(
              label: category.label,
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

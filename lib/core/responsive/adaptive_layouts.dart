import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';

/// A scrollable page with consistent horizontal padding and a readable
/// max-width. Every full page in the app uses this instead of repeating
/// `SingleChildScrollView + Center + ConstrainedBox`.
class AdaptivePage extends StatelessWidget {
  const AdaptivePage({
    super.key,
    required this.children,
    this.topPadding = 24,
    this.bottomPadding = 24,
    this.maxWidth = AppBreakpoints.contentMaxWidth,
    this.scrollable = true,
    this.lazy = false,
  });

  final List<Widget> children;
  final double topPadding;
  final double bottomPadding;
  final double maxWidth;
  final bool scrollable;

  /// Builds scroll children only as they approach the viewport.
  ///
  /// Use this for long editorial pages. The visual padding, max width, and
  /// scrolling behaviour stay identical to the non-lazy layout.
  final bool lazy;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = AppBreakpoints.pagePaddingFor(constraints.maxWidth);
        final content = Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        );

        if (!scrollable) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              padding,
              topPadding,
              padding,
              bottomPadding,
            ),
            child: content,
          );
        }

        final viewPadding = EdgeInsets.fromLTRB(
          padding,
          topPadding,
          padding,
          bottomPadding,
        );

        if (lazy) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: ListView.builder(
              primary: true,
              padding: viewPadding,
              itemCount: children.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: children[index],
                  ),
                );
              },
            ),
          );
        }

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            primary: true,
            padding: viewPadding,
            child: content,
          ),
        );
      },
    );
  }
}

enum CompactOrder { startFirst, endFirst }

/// A two-pane layout that turns into a vertical stack below [breakpoint].
///
/// Pane widths can be fixed (`startWidth` / `endWidth`) or flexible
/// (`startFlex` / `endFlex`).
class AdaptiveTwoPane extends StatelessWidget {
  const AdaptiveTwoPane({
    super.key,
    required this.start,
    required this.end,
    this.breakpoint = 860,
    this.gap = 32,
    this.compactGap,
    this.startWidth,
    this.endWidth,
    this.startFlex = 1,
    this.endFlex = 1,
    this.rowAlignment = CrossAxisAlignment.start,
    this.compactOrder = CompactOrder.startFirst,
    this.showEndOnCompact = true,
  }) : assert(startWidth == null || startFlex == 1);

  final Widget start;
  final Widget end;
  final double breakpoint;
  final double gap;
  final double? compactGap;
  final double? startWidth;
  final double? endWidth;
  final int startFlex;
  final int endFlex;
  final CrossAxisAlignment rowAlignment;
  final CompactOrder compactOrder;
  final bool showEndOnCompact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          if (!showEndOnCompact) return start;
          final stackGap = compactGap ?? gap;
          final children = compactOrder == CompactOrder.endFirst
              ? [end, SizedBox(height: stackGap), start]
              : [start, SizedBox(height: stackGap), end];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }

        return Row(
          crossAxisAlignment: rowAlignment,
          children: [
            if (startWidth != null)
              SizedBox(width: startWidth, child: start)
            else
              Expanded(flex: startFlex, child: start),
            SizedBox(width: gap),
            if (endWidth != null)
              SizedBox(width: endWidth, child: end)
            else
              Expanded(flex: endFlex, child: end),
          ],
        );
      },
    );
  }
}

/// A wrapping grid whose column count is derived from available width.
///
/// This replaces repeated `LayoutBuilder + columns + Wrap` code.
class AdaptiveColumns extends StatelessWidget {
  const AdaptiveColumns({
    super.key,
    required this.children,
    this.minItemWidth = 280,
    this.maxColumns = 3,
    this.spacing = 12,
    this.runSpacing = 12,
    this.itemHeight,
  }) : assert(children.length >= 0);

  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;
  final double runSpacing;
  final double? itemHeight;

  int columnsFor(double width) {
    if (children.isEmpty) return 1;
    final raw = ((width + spacing) / (minItemWidth + spacing)).floor();
    return math.max(1, math.min(maxColumns, raw));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = columnsFor(constraints.maxWidth);
        final itemWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, height: itemHeight, child: child),
          ],
        );
      },
    );
  }
}

/// Small helper for spacing that adapts to the current window class.
class AdaptiveGap extends StatelessWidget {
  const AdaptiveGap({
    super.key,
    required this.compact,
    required this.expanded,
    this.medium,
    this.axis = Axis.vertical,
  });

  final double compact;
  final double? medium;
  final double expanded;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final size = context.responsive<double>(
      compact: compact,
      medium: medium,
      expanded: expanded,
    );
    return SizedBox(
      width: axis == Axis.horizontal ? size : null,
      height: axis == Axis.vertical ? size : null,
    );
  }
}

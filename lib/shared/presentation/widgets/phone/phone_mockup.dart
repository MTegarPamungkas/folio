import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/ai_home_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/detail_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/finance_home_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/focus_home_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/food_home_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/market_home_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/summary_preview.dart';
import 'package:folio/shared/presentation/widgets/phone/screens/travel_home_preview.dart';

const double _phoneDesignWidth = 208;
const double _phoneDesignHeight = 438;

class PhoneMockup extends StatelessWidget {
  const PhoneMockup({
    super.key,
    required this.project,
    required this.variant,
    this.width = 214,
  });

  final Project project;
  final int variant;
  final double width;

  @override
  Widget build(BuildContext context) {
    final scale = width / _phoneDesignWidth;
    return ExcludeSemantics(
      child: SizedBox(
        width: width,
        height: _phoneDesignHeight * scale,
        child: FittedBox(
          fit: BoxFit.fill,
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child: SizedBox(
              width: _phoneDesignWidth,
              height: _phoneDesignHeight,
              child: _PhoneFrame(project: project, variant: variant),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.project, required this.variant});

  final Project project;
  final int variant;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111110),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFF34322E), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: ColoredBox(
          color: p.screen,
          child: Stack(
            children: [
              Column(
                children: [
                  _StatusBar(project: project),
                  Expanded(
                    child: switch (variant) {
                      0 => _HomeScreen(project: project),
                      1 => ProjectDetailPreview(project: project),
                      _ => ProjectSummaryPreview(project: project),
                    },
                  ),
                  _HomeIndicator(color: p.onScreen),
                ],
              ),
              Positioned(
                top: 7,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 58,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10100F),
                      borderRadius: BorderRadius.circular(100),
                    ),
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

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final color = project.palette.onScreen;
    return SizedBox(
      height: 27,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 7, 12, 0),
        child: Row(
          children: [
            Text(
              '9:41',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const Spacer(),
            Icon(Icons.signal_cellular_alt_rounded, size: 9, color: color),
            const SizedBox(width: 3),
            Icon(Icons.wifi_rounded, size: 9, color: color),
            const SizedBox(width: 3),
            Icon(Icons.battery_full_rounded, size: 10, color: color),
          ],
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 3.5,
      margin: const EdgeInsets.only(top: 4, bottom: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      child: switch (project.category) {
        ProjectCategory.travel => TravelHomePreview(project: project),
        ProjectCategory.finance => FinanceHomePreview(project: project),
        ProjectCategory.ai => AiHomePreview(project: project),
        ProjectCategory.productivity => FocusHomePreview(project: project),
        ProjectCategory.commerce => MarketHomePreview(project: project),
        ProjectCategory.food => FoodHomePreview(project: project),
        ProjectCategory.enterprise => ProjectSummaryPreview(project: project),
        ProjectCategory.career => ProjectSummaryPreview(project: project),
        ProjectCategory.experiment => ProjectSummaryPreview(project: project),
        ProjectCategory.website => ProjectSummaryPreview(project: project),
      },
    );
  }
}

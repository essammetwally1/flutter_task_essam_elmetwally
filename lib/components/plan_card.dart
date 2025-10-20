import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class PlanCard extends StatelessWidget {
  final String price;
  final String planName;
  final bool isSelectPlan;
  final void Function(bool?)? onChanged;
  final Widget widget;
  const PlanCard({
    super.key,
    required this.price,
    required this.planName,
    required this.isSelectPlan,
    this.onChanged,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        border: BoxBorder.all(color: AppTheme.grey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.black.withValues(alpha: .2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                price,
                style: textTheme.titleMedium!.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.primary,
                ),
              ),
              Spacer(),
              Text(
                planName,
                style: textTheme.titleMedium!.copyWith(
                  color: AppTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Checkbox(
                checkColor: AppTheme.white,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppTheme.blue;
                  }
                  return Colors.transparent;
                }),
                side: WidgetStateBorderSide.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return BorderSide(color: AppTheme.blue);
                  }
                  return BorderSide(color: Colors.grey);
                }),
                value: isSelectPlan,
                onChanged: onChanged,
              ),
            ],
          ),
          const Divider(color: AppTheme.grey, thickness: 1),
          widget,
        ],
      ),
    );
  }
}

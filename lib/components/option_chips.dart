import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class OptionChips extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const OptionChips({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: List.generate(options.length, (index) {
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.blue.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected ? AppTheme.blue : AppTheme.grey,
                width: 1.5,
              ),
            ),
            child: Text(
              options[index],
              style: textTheme.titleSmall!.copyWith(
                color: isSelected ? AppTheme.blue : AppTheme.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }
}

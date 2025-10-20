import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class PlanRow extends StatelessWidget {
  final String text;
  final String iconpath;
  final Widget? widget;
  const PlanRow({
    super.key,
    required this.text,
    required this.iconpath,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: textTheme.titleSmall!.copyWith(color: AppTheme.black),
              ),
              widget == null ? SizedBox() : widget!,
            ],
          ),
          SizedBox(width: 5),
          SvgPicture.asset('assets/icons/$iconpath.svg'),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

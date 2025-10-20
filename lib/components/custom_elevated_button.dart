import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final String textElevatedButton;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final TextStyle? textStyle;
  final Widget? widget;
  const CustomElevatedButton({
    super.key,
    required this.textElevatedButton,
    required this.onPressed,
    this.isLoading = false,
    this.color = AppTheme.blue,
    this.textStyle,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
      ),
      onPressed: onPressed,
      child: isLoading
          ? Center(child: CircularProgressIndicator(color: AppTheme.white))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget == null ? SizedBox() : widget!,
                Text(
                  textElevatedButton,
                  style:
                      textStyle ??
                      TextTheme.of(context).titleLarge!.copyWith(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
    );
  }
}

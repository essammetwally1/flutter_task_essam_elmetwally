import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final VoidCallback? onPressed;
  final int? maxLines;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.onChange,
    this.maxLines = 1,
    this.validator,
    this.onPressed,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      maxLines: widget.maxLines,
      controller: widget.controller,

      onChanged: widget.onChange,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppTheme.primary,
      style: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(color: AppTheme.primary),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: widget.hintText,
      ),
    );
  }
}

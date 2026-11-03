import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Labeled input field used across auth screens.
class AuthTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isActive;
  final String? errorText;
  final int? maxLength;
  final int maxLines;
  final bool obscureText;
  final void Function(String)? onChanged;

  const AuthTextField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isActive = false,
    this.errorText,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSuffix = widget.obscureText
        ? GestureDetector(
            onTap: () => setState(() => _obscured = !_obscured),
            child: Icon(
              _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 20,
              color: AppColors.muted,
            ),
          )
        : widget.suffixIcon;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.nameLabel),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          obscureText: _obscured,
          onChanged: widget.onChanged,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.muted),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: effectiveSuffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: effectiveSuffix,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            counterText: '',
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.indigo, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            errorText: widget.errorText,
          ),
        ),
        if (widget.helperText != null && widget.errorText == null) ...[
          const SizedBox(height: 4),
          Text(widget.helperText!, style: AppTextStyles.meta),
        ],
      ],
    );
  }
}

/// Labeled text field that shows a character counter in the suffix (e.g. 11/40).
class AuthTextFieldWithCounter extends StatefulWidget {
  final String label;
  final String? hint;
  final int maxLength;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const AuthTextFieldWithCounter({
    super.key,
    required this.label,
    this.hint,
    required this.maxLength,
    this.controller,
    this.onChanged,
  });

  @override
  State<AuthTextFieldWithCounter> createState() => _AuthTextFieldWithCounterState();
}

class _AuthTextFieldWithCounterState extends State<AuthTextFieldWithCounter> {
  late int _len;

  @override
  void initState() {
    super.initState();
    _len = widget.controller?.text.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.nameLabel),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          onChanged: (v) {
            setState(() => _len = v.length);
            widget.onChanged?.call(v);
          },
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.muted),
            counterText: '',
            suffixText: '$_len/${widget.maxLength}',
            suffixStyle: AppTextStyles.meta,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.indigo, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

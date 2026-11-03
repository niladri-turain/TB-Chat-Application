import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Phone number field: flag + dial code dropdown | number input.
class PhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String dialCode, String number)? onChanged;
  final bool showClearButton;

  const PhoneField({
    super.key,
    this.controller,
    this.onChanged,
    this.showClearButton = false,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String _dialCode = '+91';
  String _flag = '🇮🇳';
  bool _hasText = false;

  final List<_CountryCode> _countries = const [
    _CountryCode('🇮🇳', '+91', 'India'),
    _CountryCode('🇺🇸', '+1', 'USA'),
    _CountryCode('🇬🇧', '+44', 'UK'),
    _CountryCode('🇦🇺', '+61', 'Australia'),
    _CountryCode('🇸🇬', '+65', 'Singapore'),
    _CountryCode('🇦🇪', '+971', 'UAE'),
  ];

  void _pickCountry(BuildContext context) async {
    final result = await showModalBottomSheet<_CountryCode>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _CountryPickerSheet(countries: _countries),
    );
    if (result != null) {
      setState(() {
        _dialCode = result.dial;
        _flag = result.flag;
      });
      widget.onChanged?.call(_dialCode, widget.controller?.text ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mobile number', style: AppTextStyles.nameLabel),
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              // Dial code picker
              GestureDetector(
                onTap: () => _pickCountry(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.line),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_flag, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 6),
                      Text(_dialCode, style: AppTextStyles.body),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 18, color: AppColors.muted),
                    ],
                  ),
                ),
              ),
              // Number input
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: AppTextStyles.body,
                  onChanged: (v) {
                    setState(() => _hasText = v.isNotEmpty);
                    widget.onChanged?.call(_dialCode, v);
                  },
                  decoration: InputDecoration(
                    hintText: '98765 43210',
                    hintStyle: AppTextStyles.body.copyWith(color: AppColors.muted),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    suffixIcon: widget.showClearButton && _hasText
                        ? GestureDetector(
                            onTap: () {
                              widget.controller?.clear();
                              setState(() => _hasText = false);
                              widget.onChanged?.call(_dialCode, '');
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(Icons.close_rounded,
                                  size: 18, color: AppColors.muted),
                            ),
                          )
                        : null,
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CountryCode {
  final String flag;
  final String dial;
  final String name;
  const _CountryCode(this.flag, this.dial, this.name);
}

class _CountryPickerSheet extends StatelessWidget {
  final List<_CountryCode> countries;
  const _CountryPickerSheet({required this.countries});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.line,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          ...countries.map(
            (c) => ListTile(
              leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
              title: Text(c.name, style: AppTextStyles.body),
              trailing: Text(c.dial, style: AppTextStyles.meta),
              onTap: () => Navigator.pop(context, c),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

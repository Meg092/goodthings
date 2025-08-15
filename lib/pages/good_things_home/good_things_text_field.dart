import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/services.dart';

class GoodThingsTextField extends StatelessWidget {
  final String value;
  final TextInputType keyboardType;
  final bool isInteger;
  final bool isNumber;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final Function(String) onChange;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? padding;

  const GoodThingsTextField({
    super.key,
    required this.onChange,
    required this.value,
    this.keyboardType = TextInputType.text,
    this.isInteger = false,
    this.isNumber = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.border,
    this.focusedBorder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    List<TextInputFormatter> inputFormatters = [];

    if (isInteger) {
      inputFormatters.add(
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
      );
    } else if (isNumber) {
      inputFormatters.add(
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*\.?[0-9]*$')),
      );
    }

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters.isEmpty ? null : inputFormatters,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText ?? 'Input...',
        hintStyle: TextStyle(
          color: Color(0xFF7C7C7C),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon, size: 20.sp, color: Colors.grey[600])
                : null,
        suffixIcon:
            suffixIcon != null
                ? IconButton(
                  icon: Icon(suffixIcon, size: 20.sp, color: Colors.grey[600]),
                  onPressed: onSuffixIconPressed,
                )
                : null,
        contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 8.w),
        border: border ?? InputBorder.none,
        enabledBorder: border ?? InputBorder.none,
        focusedBorder: focusedBorder ?? InputBorder.none,
      ),
      onChanged: (v) => onChange.call(v),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onTap,
      this.textInputType,
      this.textCapitalization,
      this.textAlign = TextAlign.left,
      this.prefixIcon,
      this.prefixColor,
      this.prefixOnTap,
      this.onChanged,
      this.onEditingComplete,
      this.contentPadding,
      this.readOnly = false,
      this.focusNode});

  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final IconData? prefixIcon;
  final Color? prefixColor;
  final TextAlign? textAlign;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? prefixOnTap;
  final bool readOnly;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      onTap: onTap,
      focusNode: focusNode,
      readOnly: readOnly,
      onChanged: (val) {
        if (onChanged != null) {
          onChanged!(val);
        }
      },
      onEditingComplete: onEditingComplete,
      keyboardType: textInputType ?? TextInputType.text,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlign: textAlign!,
      style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.w400,
          fontSize: 16),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 1,
            )),
        fillColor: AppColors.cardColor,
        filled: true,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none),
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: const TextStyle(
            color: AppColors.hintColor,
            fontWeight: FontWeight.w400,
            fontSize: 16),
        prefixIcon: prefixIcon != null
            ? InkWell(
                onTap: prefixOnTap,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 16),
                  child: Icon(prefixIcon,
                      size: 20, color: prefixColor ?? AppColors.textColor),
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints.loose(size),
        prefixIconConstraints: BoxConstraints.loose(size),
      ),
    );
  }
}

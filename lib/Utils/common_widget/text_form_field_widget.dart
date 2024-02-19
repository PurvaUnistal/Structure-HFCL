import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';

class TextFormFieldWidget extends StatelessWidget {
 final TextInputType? keyboardType;
 final TextInputAction? textInputAction;
 final Iterable<String>? autofillHints;
 final  Widget? suffixIcon;
 final TextEditingController? controller;
 final bool? obscureText;
 final void Function(String)? onChanged;
 final  Widget? prefix;
 final  String? labelText;
 final String? hintText;
  const TextFormFieldWidget({Key? key,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.suffixIcon, this.controller,
    this.obscureText,
    this.onChanged,
    this.prefix,
    this.labelText, this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      controller: controller,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 1, color: AppColor.appBlue),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 1, color: AppColor.appBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(width: 1, color: AppColor.appBlue),
        ),
      ),
    );
  }
}

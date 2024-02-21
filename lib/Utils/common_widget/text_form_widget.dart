import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final String labelText;
  final bool? enabled;
  final bool? obscureText;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLine;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool? isRequired;
  const TextFieldWidget({
    required this.labelText,
    this.enabled,
    this.obscureText,
    this.textInputAction,
    this.controller,
    this.hintText,
    this.autofillHints,
    this.onTap,
    this.onChanged,
    this.textInputType,
    this.maxLength,
    this.suffixIcon,
    this.prefix,
    this.maxLine,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
          enabled: enabled ?? true,
          obscureText: obscureText ?? false,
          autofillHints: autofillHints,
          controller: controller,
          style:  TextStyle(fontSize: 14, color: AppColor.black,),
          inputFormatters: textInputType != null ? textInputType == TextInputType.number ?
          [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}'))] : null : null,
          keyboardType: textInputType == null ?  TextInputType.text
              : Platform.isIOS ? textInputType == TextInputType.number
              ? const TextInputType.numberWithOptions(signed: true, decimal: true)
              : textInputType ?? TextInputType.text : textInputType ?? TextInputType.text ,
          maxLength: maxLength,
          maxLines: maxLine ?? 1,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: maxLine != null ? 8 : 0),
              suffixIcon: suffixIcon ?? const Text(""),
              prefixIcon: prefix ?? null,
              label: Text.rich(TextSpan(children: [
                TextSpan(text: labelText),
                TextSpan(text: isRequired != null && isRequired == true ? ' *' : "", style: const TextStyle(color: Colors.red)),
              ])),
              labelStyle: TextStyle(fontSize: 14, color: controller == null ?  AppColor.appBlue
                  : controller!.text.toString().isNotEmpty ? AppColor.appBlue : AppColor.appBlue,),
              fillColor: Colors.white,
              border: _border(),
              enabledBorder: _border(),
              disabledBorder: _border(),
              focusedBorder:_border()
          ),
          onChanged: onChanged),
    );
  }

  OutlineInputBorder _border(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
          width: 1,
          color: AppColor.appBlue
      ),
    );
  }
}

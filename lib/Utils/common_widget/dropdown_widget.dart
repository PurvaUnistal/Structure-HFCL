import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T? dropdownValue;
  final String hint;
  final String? label;
  final void Function(T?)? onChanged;
  final List<T> items;

  const DropdownWidget({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
    required this.items,
    required this.hint,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        borderRadius: BorderRadius.circular(5),
        decoration: InputDecoration(
          fillColor: AppColor.white,
          // labelText: label,
          isDense: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          enabledBorder: _border(),
          disabledBorder:_border(),
          border: _border(),
          focusedBorder: _border(),

          // label: label!,
          label: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              label??"",
              style: TextStyle(fontSize: 14, color:  AppColor.appBlue),
            ),
          ),

        ),
        hint: Text(
          hint,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),
        ),
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),
        isExpanded: true,
        value: dropdownValue != null ? dropdownValue : null,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
              value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          );
        }).toList(),
        onChanged: onChanged
        );
  }

  OutlineInputBorder _border(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
          style: BorderStyle.solid,
        width: 0.80,
          color: AppColor.appBlue,
      ),
    );
  }
}

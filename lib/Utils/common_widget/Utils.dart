import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';
class Utils {
  static successToast(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(msg)),
            Icon(
              Icons.check_circle,
              color: AppColor.white,
            ),
          ],
        ),
        backgroundColor: Colors.green,
        padding: EdgeInsets.all(8),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static warningMeg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(msg)),
            Icon(
              Icons.warning_amber_rounded,
              color: AppColor.white,
            ),
          ],
        ),
        backgroundColor: Colors.orangeAccent.shade200,
        padding: EdgeInsets.all(8),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static failureMeg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(msg)),
            Icon(
              Icons.close,
              color: AppColor.white,
            ),
          ],
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(8),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

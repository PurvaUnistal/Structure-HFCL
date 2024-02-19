import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/Utils/common_widget/button_widget.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';

class DialogBoxWidget extends StatelessWidget {
  const DialogBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.white,
      title: Text(
        AppString.logout,
      ),
      content: Text(
        AppString.logoutMessage,
      ),
      actions: [
        ButtonWidget(
          text: AppString.no,
          onPressed: () => Navigator.pop(context),
        ),
        ButtonWidget(
            text: AppString.yes,
            onPressed: () async {
              await PreferenceUtil.clearAll();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.splashView, (Route<dynamic> route) => false);
              // Navigator.pushReplacementNamed(context, RoutesName.loginView);
            })
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/Utils/common_widget/button_widget.dart';
import 'package:structure_app/Utils/common_widget/text_widget.dart';
import 'package:structure_app/features/Login/presentation/login_view.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4.9,
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextWidget(AppString.logout+"?",
              fontWeight: FontWeight.w600,
              fontSize: 22,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextWidget(AppString.logoutMessage,
              textAlign: TextAlign.center,
              color: AppColor.black,
              fontSize: 14,),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: ButtonWidget(text: AppString.logout,
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginView()),
                                (route) => false
                        );
                        await PreferenceUtil.clearAll();
                      }
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),

                Flexible(
                  flex: 2,
                  child: ButtonWidget(
                      text: AppString.no,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

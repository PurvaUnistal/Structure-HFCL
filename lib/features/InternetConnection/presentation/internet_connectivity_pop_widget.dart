import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';

class InternetConnectivityPopWidget extends StatelessWidget {
  const InternetConnectivityPopWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width / 1.7,
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              _closeButton(context: context),
              _centerImage(context: context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _text(context: context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _centerImage({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      child: Icon(
        Icons.signal_cellular_connected_no_internet_4_bar_rounded,
        size: MediaQuery.of(context).size.height * 0.09,
        color: AppColor.green,
      ),
    );
  }

  Widget _text({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Text(
        "No Internet Connection.",
      ),
    );
  }

  Widget _closeButton({required BuildContext context}) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: AppColor.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

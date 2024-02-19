import 'package:flutter/material.dart';

class ImagePopWidget extends StatelessWidget {
  final void Function()? onTapGallery, onTapCamera;
  const ImagePopWidget(
      {Key? key, required this.onTapGallery, required this.onTapCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child:
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              Text('Choose One'),
              ListTile(title: Text('Gallery'), onTap: onTapGallery),
              ListTile(title: Text('Camera',), onTap: onTapCamera,),
              TextButton(
                child: Text('Dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

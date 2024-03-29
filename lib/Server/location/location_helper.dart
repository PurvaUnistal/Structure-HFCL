/*
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  static Position? position;
  static String currentAddress = '';

  static Future<bool> checkGps({required BuildContext context}) async {
    bool serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return false;
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext mContext) => const GPSAlertPopWidget());
      print("GPS Service is not enabled, turn on GPS location");
      return false;
    }
  }

  static Future<dynamic> getLocation({required BuildContext context}) async {
    if (await checkGps(context: context) == false) {
      return null;
    } else {
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.denied) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          return _getAddressFromLatLng(position);
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
  }

  static Future<dynamic> getLocationOfflineMode({required BuildContext context}) async {
    if (await checkGps(context: context) == false) {
      return null;
    } else {
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.denied) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best).timeout(Duration(seconds: 4));
          Map<String, dynamic> location = {
            "lat": position.latitude,
            "long": position.longitude,
            "city": "",
            "address": '',
          };
          print(location.toString());
          return responseLocationData(location);
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
  }

  static Future<dynamic> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarker =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarker[0];
      print("position.latitude" + position.latitude.toString());
      Map<String, dynamic> location = {
        "lat": position.latitude,
        "long": position.longitude,
        "city": place.locality.toString(),
        "address":
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.country}, ${place.postalCode}',
      };
      print(location.toString());
      return responseLocationData(location);
    } catch (e) {
      return null;
    }
  }

  static Future<String> getAddress({required String lat, required String log}) async {
    try {
      List<Placemark> placeMarker =
      await placemarkFromCoordinates(double.parse(lat), double.parse(log));
      Placemark place = placeMarker[0];
      String address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.country}, ${place.postalCode}';
      return address;
    } catch (e) {
      return "";
    }
  }


  static Future<bool> checkPermissions({required BuildContext context}) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationAlways,
      Permission.locationWhenInUse
    ].request();

    if (Platform.isAndroid) {
      final status = await Permission.locationAlways.status;
      if (status == PermissionStatus.denied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => GPSSettingPermissionPopWidget());
        return false;

      }
      if (status == PermissionStatus.permanentlyDenied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => GPSSettingPermissionPopWidget());
        return false;
      }
    } else if (Platform.isIOS) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => GPSSettingPermissionPopWidget());
        return false;
      }
    }
    return true;
  }

  static Future<bool> checkImagePermission({required BuildContext context}) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();

    final status = await Permission.camera.status;
    print("Check Camera Permissin ---- ${status}");
    if (Platform.isAndroid) {
      if (status == PermissionStatus.denied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CameraPermissionPopWidget());
        return false;
      }
      if (status == PermissionStatus.permanentlyDenied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CameraPermissionPopWidget());
        return false;
      }
    }else{
      if (status == PermissionStatus.denied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CameraPermissionPopWidget());
        return false;
      } else if (status == PermissionStatus.permanentlyDenied) {
      showDialog(
            context: context,
            builder: (BuildContext context) => CameraPermissionPopWidget());
        return false;
      }
    }

    return true;
  }

  static Future<bool> checkStoragePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.accessMediaLocation
    ].request();
    final status = await Permission.locationWhenInUse.status;
    if (status == PermissionStatus.denied) {
      return false;

    }
    if (status == PermissionStatus.permanentlyDenied) {
      return false;
    }
    return true;
  }
}
*/

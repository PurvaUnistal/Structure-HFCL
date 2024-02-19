// import 'package:dpr/features/InternetConnection/domain/bloc/network_bloc.dart';
// import 'package:dpr/features/InternetConnection/presentation/internet_connectivity_pop_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class NetworkHelper {
//   static Future<dynamic> observeNetwork({required BuildContext context}) async {
//     bool isInternetConnectivity =
//         BlocProvider.of<NetworkBloc>(context).isConnected;
//     print(isInternetConnectivity);
//     if (isInternetConnectivity == false) {
//       showDialog(
//           context: context,
//           builder: (BuildContext context) =>
//               const InternetConnectivityPopWidget());
//       return false;
//     }
//     return true;
//   }
// }

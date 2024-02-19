import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_event.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_state.dart';
import 'package:structure_app/features/InternetConnection/presentation/internet_connectivity_pop_widget.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitialState()) {
    on<NetworkObserveEvent>(_connectionCheck);
    on<NetworkNotifyEvent>(_updateConnectivityStatus);
  }

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  late BuildContext context;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  _connectionCheck(NetworkObserveEvent event, emit) async {
    context = event.context;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initConnectivity();
  }

  _updateConnectivityStatus(NetworkNotifyEvent event, emit) {
    emit(NetworkConnectionState(
      isConnected: isConnected,
    ));
  }

  Future<dynamic> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<dynamic> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    _isConnected = await _checkInterNetConnect();
    if (isConnected == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              const InternetConnectivityPopWidget());
    }
    BlocProvider.of<NetworkBloc>(context).add(NetworkNotifyEvent());
  }

  static Future<bool> _checkInterNetConnect() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}

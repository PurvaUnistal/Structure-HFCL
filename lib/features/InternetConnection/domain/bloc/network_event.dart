import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NetworkEvent extends Equatable {}

class NetworkObserveEvent extends NetworkEvent {
  final BuildContext context;
  NetworkObserveEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

class NetworkNotifyEvent extends NetworkEvent {
  final bool isConnected;

  NetworkNotifyEvent({this.isConnected = false});

  @override
  // TODO: implement props
  List<Object?> get props => [isConnected];
}

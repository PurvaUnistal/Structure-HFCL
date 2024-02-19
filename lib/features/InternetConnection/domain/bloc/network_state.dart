import 'package:equatable/equatable.dart';

abstract class NetworkState extends Equatable {}

class NetworkInitialState extends NetworkState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NetworkConnectionState extends NetworkState {
  final bool isConnected;
  NetworkConnectionState({required this.isConnected});
  @override
  // TODO: implement props
  List<Object?> get props => [isConnected];
}

class NetworkFailureState extends NetworkState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

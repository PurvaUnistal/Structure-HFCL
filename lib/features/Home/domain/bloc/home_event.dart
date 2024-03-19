import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {}

class HomePageLoaderEvent extends HomeEvent {
  final BuildContext context;
  HomePageLoaderEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}
class SelectBlockEvent extends HomeEvent {
  final dynamic blockValue;
  final BuildContext context;
  SelectBlockEvent({required this.blockValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [blockValue, context];
}

class SelectDistrictEvent extends HomeEvent {
  final dynamic districtValue;
  final BuildContext context;
  SelectDistrictEvent({required this.districtValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [districtValue, context];
}

class SelectSchemaEvent extends HomeEvent {
  final dynamic schemaValue;
  final BuildContext context;
  SelectSchemaEvent({required this.schemaValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [schemaValue, context];
}

class SelectSubSystemValue extends HomeEvent {
  final dynamic subSystemValue;
  final BuildContext context;
  SelectSubSystemValue({required this.subSystemValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [subSystemValue, context];
}

class SelectSubSubSystemValue extends HomeEvent {
  final dynamic subSubSystemValue;
  final BuildContext context;
  SelectSubSubSystemValue({required this.subSubSystemValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [subSubSystemValue, context];
}
class SelectActivityEvent extends HomeEvent {
  final dynamic activityValue;
  final BuildContext context;
  SelectActivityEvent({required this.activityValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [activityValue, context];
}


class SelectContractorEvent extends HomeEvent {
  final dynamic contractorValue;
  final BuildContext context;
  SelectContractorEvent({required this.contractorValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [contractorValue, context];
}

class SelectStartDateEvent extends HomeEvent {
  final BuildContext context;
  SelectStartDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

class SelectEndDateEvent extends HomeEvent {
  final BuildContext context;
  SelectEndDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

class CaptureGalleryEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CaptureCameraEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeSubmitEvent extends HomeEvent {
  final BuildContext context;
  HomeSubmitEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

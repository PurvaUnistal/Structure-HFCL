import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable{}

class HomePageLoaderEvent extends HomeEvent{
  final BuildContext context;
  HomePageLoaderEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

class SelectDistrictEvent extends HomeEvent{
  final dynamic districtValue;
  final BuildContext context;
  SelectDistrictEvent({required this.districtValue,required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [districtValue,context];
}

class SelectBlockEvent extends HomeEvent{
  final dynamic blockValue;
  final BuildContext context;
  SelectBlockEvent({required this.blockValue,required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [blockValue, context];
}

class SelectSchemaEvent extends HomeEvent {
  final dynamic schemaValue;
  final BuildContext context;
  SelectSchemaEvent({required this.schemaValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [schemaValue, context];
}


class SelectMajorActivityEvent extends HomeEvent{
  final dynamic majorActivityValue;
  final BuildContext context;
  SelectMajorActivityEvent({required this.majorActivityValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [majorActivityValue, context];
}

class SelectActivityEvent extends HomeEvent{
  final dynamic activityValue;
  final BuildContext context;
  SelectActivityEvent({required this.activityValue, required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [activityValue, context];
}

class HomeSubmitEvent extends HomeEvent{
  final BuildContext context;
  HomeSubmitEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}
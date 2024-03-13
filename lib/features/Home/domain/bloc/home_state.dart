import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
import 'package:structure_app/features/Home/domain/model/SubSubSystemModel.dart';
import 'package:structure_app/features/Home/domain/model/SubSystemModel.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomePageLoaderState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeFetchDataState extends HomeState {
  bool isPageLoader;
  final File photo;
  DistrictsData? districtValue;
  BlockData? blockValue;
  SchemeData? schemeValue;
  FinalSubSystemData? subSystemDataValue;
  SubSubSystemData? subSubSystemDataValue;
  ActivityData? activityValue;
  List<BlockData> blockList;
  List<SchemeData> schemeList;
  List<FinalSubSystemData> subSystemList;
  List<SubSubSystemData> subSubSystemList;
  List<ActivityData> activityList;
  List<DistrictsData> districtList;
  TextEditingController startDateController;
  TextEditingController endDateController;
  TextEditingController remarksController;
  SubSystemModel  subSystemModel;
  SubSubSystemModel subSubSystemModel;
  ActivityModel activityModel;
  HomeFetchDataState({
    required this.isPageLoader,
    required this.photo,
    required this.blockValue,
    required this.schemeValue,
    required this.subSystemDataValue,
    required this.subSubSystemDataValue,
    required this.activityValue,
    required this.blockList,
    required this.schemeList,
    required this.subSystemList,
    required this.subSubSystemList,
    required this.activityList,
    required this.startDateController,
    required this.endDateController,
    required this.remarksController,
    required this.subSystemModel,
    required this.subSubSystemModel,
    required this.activityModel,
    required this.districtValue,
    required this.districtList,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isPageLoader,
    photo,
    blockValue,
    schemeValue,
    subSystemDataValue,
    subSubSystemDataValue,
    activityValue,
    blockList,
    schemeList,
    subSystemList,
    subSubSystemList,
    activityList,
    startDateController,
    endDateController,
    remarksController,
    subSystemModel,
    subSubSystemModel,
    activityModel,
    districtValue,
    districtList,
      ];
}

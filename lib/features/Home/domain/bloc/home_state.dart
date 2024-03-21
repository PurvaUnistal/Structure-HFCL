import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/ActivityStartDateModel.dart';
import 'package:structure_app/features/Home/domain/model/AllContractorModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
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
  bool isActivityLoader;
  final File photo;
  DistrictsData? districtValue;
  BlockData? blockValue;
  SchemeData? schemeValue;
  SubSystemData? subSystemDataValue;
  ActivityData? activityValue;
  List<BlockData> blockList;
  List<SchemeData> schemeList;
  List<SubSystemData> subSystemList;
  List<ActivityData> activityList;
  List<DistrictsData> districtList;
  TextEditingController startDateController;
  TextEditingController endDateController;
  TextEditingController remarksController;
  TextEditingController schemeIdController;
  SubSystemModel subSystemModel;
  ActivityModel activityModel;
  ActivityStartDateModel? activityStartDateModel;
  AllContractorData? allContractorValue;
  List<AllContractorData> allContractorDataList;
  HomeFetchDataState({
    required this.isPageLoader,
    required this.isActivityLoader,
    required this.photo,
    required this.blockValue,
    required this.schemeValue,
    required this.subSystemDataValue,
    required this.activityValue,
    required this.blockList,
    required this.schemeList,
    required this.subSystemList,
    required this.activityList,
    required this.startDateController,
    required this.endDateController,
    required this.remarksController,
    required this.subSystemModel,
    required this.activityModel,
    required this.districtValue,
    required this.districtList,
    required this.activityStartDateModel,
    required this.allContractorDataList,
    required this.allContractorValue,
    required this.schemeIdController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isPageLoader,
    isActivityLoader,
    photo,
    blockValue,
    schemeValue,
    subSystemDataValue,
    activityValue,
    blockList,
    schemeList,
    subSystemList,
    activityList,
    startDateController,
    endDateController,
    remarksController,
    subSystemModel,
    activityModel,
    districtValue,
    districtList,
    activityStartDateModel,
    allContractorDataList,
    allContractorValue,
    schemeIdController,
  ];
}

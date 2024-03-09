import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/MajorActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/QuantityModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';

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
  DistrictData? districtValue;
  BlockData? blockValue;
  SchemeData? schemeValue;
  QuantityModel? quantityValue;
  MajorActivityData? majorActivityValue;
  ActivityData? activityValue;
  List<DistrictData> districtList;
  List<BlockData> blockList;
  List<SchemeData> schemeList;
  QuantityModel quantityList;
  List<MajorActivityData> majorActivityList;
  List<ActivityData> activityList;
  TextEditingController startDateController;
  TextEditingController endDateController;
  TextEditingController configuredScopeController;
  TextEditingController workDoneTodayController;
  TextEditingController remarksController;
  HomeFetchDataState({
    required this.isPageLoader,
    required this.photo,
    required this.districtValue,
    required this.blockValue,
    required this.schemeValue,
    required this.quantityValue,
    required this.majorActivityValue,
    required this.activityValue,
    required this.districtList,
    required this.blockList,
    required this.schemeList,
    required this.quantityList,
    required this.majorActivityList,
    required this.activityList,
    required this.startDateController,
    required this.endDateController,
    required this.configuredScopeController,
    required this.workDoneTodayController,
    required this.remarksController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        isPageLoader,
        photo,
        districtValue,
        blockValue,
        schemeValue,
        quantityValue,
        majorActivityValue,
        activityValue,
        districtList,
        blockList,
        schemeList,
        quantityList,
        majorActivityList,
        activityList,
        startDateController,
        endDateController,
        configuredScopeController,
        configuredScopeController,
        workDoneTodayController,
        remarksController
      ];
}

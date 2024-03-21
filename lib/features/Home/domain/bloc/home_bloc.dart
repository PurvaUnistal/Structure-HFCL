import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';
import 'package:structure_app/features/Home/domain/bloc/home_event.dart';
import 'package:structure_app/features/Home/domain/bloc/home_state.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/ActivityStartDateModel.dart';
import 'package:structure_app/features/Home/domain/model/AllContractorModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
import 'package:structure_app/features/Home/domain/model/SubSystemModel.dart';
import 'package:structure_app/features/Home/helper/home_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomePageLoaderEvent>(_pageLoader);
    on<SelectDistrictEvent>(_selectDistrict);
    on<SelectBlockEvent>(_selectBlock);
    on<SelectSchemaEvent>(_selectSchema);
    on<SelectSubSystemValue>(_subSystemValue);
    on<SelectActivityEvent>(_selectActivity);
    on<SelectContractorEvent>(_selectContractor);
    on<SelectStartDateEvent>(_selectStartDate);
    on<SelectEndDateEvent>(_selectEndDate);
    on<CaptureCameraEvent>(_captureCamera);
    on<CaptureGalleryEvent>(_captureGallery);
    on<HomeSubmitEvent>(_submitData);
  }

  bool _isPageLoader = false;
  bool get isPageLoader => _isPageLoader;

  bool _isActivityLoader = false;
  bool get isActivityLoader => _isActivityLoader;

  File _photo = File("");
  File get photo => _photo;

  DistrictsData? districtValue;
  BlockData? blockValue;
  SchemeData? schemeValue;
  SubSystemData? subSystemDataValue;
  ActivityData? activityValue;
  AllContractorData? contractorValue;

  List<DistrictsData> _districtList = [];
  List<DistrictsData> get districtList => _districtList;

  List<BlockData> _blockList = [];
  List<BlockData> get blockList => _blockList;

  List<SchemeData> _schemeList = [];
  List<SchemeData> get schemeList => _schemeList;

  SubSystemModel _subSystemModel = SubSystemModel();
  SubSystemModel get subSystemModel => _subSystemModel;

  ActivityModel _activityModel = ActivityModel();
  ActivityModel get activityModel => _activityModel;

  AllContractorModel _allContractorData = AllContractorModel();
  AllContractorModel get allContractorData => _allContractorData;

  List<AllContractorData> _contractorList = [];
  List<AllContractorData> get contractorList => _contractorList;

  ActivityStartDateModel _activityStartDateModel = ActivityStartDateModel();
  ActivityStartDateModel get activityStartDateModel => _activityStartDateModel;

  List<SubSystemData> _subSystemList = [];
  List<SubSystemData> get subSystemList => _subSystemList;

  List<ActivityData> _activityList = [];
  List<ActivityData> get activityList => _activityList;

  TextEditingController schemeIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  _pageLoader(HomePageLoaderEvent event, emit) async {
    emit(HomePageLoaderState());
    _isPageLoader = false;
    _isActivityLoader = false;
    _photo = File("");
    districtValue = null;
    _subSystemModel = SubSystemModel();
    _activityModel = ActivityModel();
    blockValue = BlockData();
    schemeValue = SchemeData();
    subSystemDataValue = SubSystemData();
    activityValue = ActivityData();
    _activityStartDateModel = ActivityStartDateModel();
    contractorValue = AllContractorData();
    _districtList = [];
    _blockList = [];
    _schemeList = [];
    _subSystemList = [];
    _activityList = [];
    _contractorList = [];
    schemeIdController.text = "";
    startDateController.text = "";
    endDateController.text = "";
    remarksController.text = "";
    await fetchDistrictsData(context: event.context);
    _eventComplete(emit);
  }

  fetchDistrictsData({
    required BuildContext context,
  }) async {
    var res = await HomeHelper.districtsData(context: context);
    if (res != null && res.data.isNotEmpty) {
      _districtList = res.data;
      districtValue = null;
      blockValue = null;
      schemeValue = null;
      subSystemDataValue = null;
      activityValue = null;
      _blockList = [];
      _schemeList = [];
      _subSystemList = [];
      _activityList = [];
      startDateController.text = "";
      endDateController.text = "";
      remarksController.text = "";
      _photo = File("");
    }
  }

  fetchBlocksData({
    required BuildContext context,
    required String districtId,
  }) async {
    var res = await HomeHelper.blocksData(context: context, districtId: districtId);
    if (res != null && res.data.isNotEmpty) {
      _blockList = res.data;
      blockValue = null;
      schemeValue = null;
      subSystemDataValue = null;
      activityValue = null;
      _schemeList = [];
      _subSystemList = [];
      _activityList = [];
      startDateController.text = "";
      endDateController.text = "";
      remarksController.text = "";
      _photo = File("");
    }
  }

  fetchSchemesData({
    required BuildContext context,
    required String blockId,
    required String districtId,
  }) async {
    var res = await HomeHelper.schemesData(blockId: blockId, districtId: districtId, context: context);
    if (res!.data.isNotEmpty) {
      _schemeList = res.data;
      schemeValue = null;
      subSystemDataValue = null;
      activityValue = null;
      _subSystemList = [];
      _activityList = [];
      startDateController.text = "";
      endDateController.text = "";
      remarksController.text = "";
      _photo = File("");
    }
  }

  fetchSubSystemsData({required BuildContext context, emit}) async {
    var res = await HomeHelper.subSystemsData(context: context);
    if (res != null) {
      _subSystemModel = res;
      if (res.data!.isNotEmpty) {
        _subSystemList = res.data!;
        subSystemDataValue = null;
        activityValue = null;
        _activityList = [];
        startDateController.text = "";
        endDateController.text = "";
        remarksController.text = "";
        _photo = File("");
      }
      _eventComplete(emit);
    }
  }

  fetchActivitiesData({required BuildContext context, required String districtId, required String blockId, required String schemeId, required String systemId, emit}) async {
    var res = await HomeHelper.activitiesData(districtId: districtId, blockId: blockId, schemeId: schemeId, systemId: systemId, context: context);
    if (res != null) {
      _activityModel = res;
      if (res.data!.isNotEmpty) {
        _activityList = res.data!;
        activityValue = null;
        startDateController.text = "";
        endDateController.text = "";
        remarksController.text = "";
        _photo = File("");
      }
      _eventComplete(emit);
    }
  }


  fetchContractorData({required BuildContext context}) async {
    var res = await HomeHelper.allContractorData(context: context);
    if (res != null) {
      _allContractorData = res;
      if (res.data != null && res.data!.isNotEmpty) {
        _contractorList = res.data!;
        contractorValue = null;
        activityValue = null;
        startDateController.text = "";
        endDateController.text = "";
        remarksController.text = "";
        _photo = File("");
      }
    }
  }

  fetchActivityStartDate(
      {required BuildContext context,
        required String districtId,
        required String blockId,
        required String schemeId,
        required String systemId,
        required String activitiesId,
        emit}) async {
    var res = await HomeHelper.activityStartDate(districtId: districtId, blockId: blockId, schemeId: schemeId, systemId: systemId, activitiesId: activitiesId, context: context);
    if (res != null) {
      _activityStartDateModel = res;
    }
  }

  _submitData(HomeSubmitEvent event, emit) async {
    try {
      var validationCheck = await HomeHelper.validationSubmit(
        context: event.context,
        networkDistrict: districtValue.toString(),
        zoneBlock: blockValue.toString(),
        dmaSystem: schemeValue.toString(),
        subSystemId: subSystemDataValue.toString(),
        startDate: startDateController.text.trim().toString(),
        contractorId : contractorValue.toString(),
        activityId: activityValue.toString(),
        remarks: remarksController.text.trim().toString(),
        attachFile: photo.path.toString(),
      );
      if (await validationCheck == true) {
        _isPageLoader = true;
        _eventComplete(emit);
        var res = await HomeHelper.progressData(
            context: event.context,
            networkDistrict: districtValue!.networkType.toString(),
            zoneBlock: blockValue!.zone.toString(),
            dmaSystem: schemeValue!.dma.toString(),
            subSystemId: subSystemDataValue!.id.toString(),
            contractorId: contractorValue!.id.toString(),
            activityId: activityValue!.id.toString(),
            startDate: startDateController.text.trim().toString(),
            endDate: endDateController.text.trim().toString(),
            attachFile: photo,
            remarks: remarksController.text.trim().toString());
        if (res != null && res.status == true) {
          _isPageLoader = false;
          _eventComplete(emit);
          Utils.successToast(res.message!, event.context);
          Navigator.pushReplacementNamed(
            event.context,
            RoutesName.homeView,
          );
          blockValue = null;
          schemeValue = null;
          subSystemDataValue = null;
          activityValue = null;
          _blockList = [];
          _schemeList = [];
          _subSystemList = [];
          _activityList = [];
          startDateController.text = "";
          endDateController.text = "";
          remarksController.text = "";
          _eventComplete(emit);
        } else {
          _isPageLoader = false;
          _eventComplete(emit);
        }
      }
    } catch (e) {
      _isPageLoader = false;
      _eventComplete(emit);
    }
  }

  _selectDistrict(SelectDistrictEvent event, emit) async {
    districtValue = event.districtValue;
    if (districtValue != null) {
      await fetchBlocksData(
        districtId: districtValue!.networkType,
        context: event.context,
      );
      _eventComplete(emit);
    }
  }

  _selectBlock(SelectBlockEvent event, emit) async {
    blockValue = event.blockValue;
    if (blockValue != null) {
      await fetchSchemesData(
        districtId: districtValue!.networkType,
        blockId: blockValue!.zone!,
        context: event.context,
      );
      _eventComplete(emit);
    }
  }

  _selectSchema(SelectSchemaEvent event, emit) async {
    schemeValue = event.schemaValue;
    if (schemeValue != null) {
      schemeIdController.clear();
      schemeIdController.text = schemeValue!.schemeId.toString();
      await fetchSubSystemsData(context: event.context, emit: emit);
      _eventComplete(emit);
    }
  }

  _subSystemValue(SelectSubSystemValue event, emit) async {
    subSystemDataValue = event.subSystemValue;
    if (subSystemDataValue != null) {
      _isActivityLoader = true;
      _eventComplete(emit);
      await fetchActivitiesData(
          districtId: districtValue!.networkType, blockId: blockValue!.zone!, schemeId: schemeValue!.dma!, systemId: subSystemDataValue!.id!, context: event.context, emit: emit);
      await fetchContractorData(context: event.context);
      _isActivityLoader = false;
      _eventComplete(emit);
    }
  }

  _selectActivity(SelectActivityEvent event, emit) async {
    activityValue = event.activityValue;
    if (activityValue != null) {
      fetchActivityStartDate(
        context: event.context,
        districtId: districtValue!.networkType,
        blockId: blockValue!.zone!,
        schemeId: schemeValue!.dma!,
        systemId: subSystemDataValue!.id!,
        activitiesId: activityValue!.id!,
        emit: emit,
      );
    }
    _eventComplete(emit);
  }

  _selectContractor(SelectContractorEvent event, emit) async {
    contractorValue = event.contractorValue;
    _eventComplete(emit);
  }

  _selectStartDate(SelectStartDateEvent event, emit) async {
    if (activityStartDateModel.data.toString().isEmpty) {
      startDateController.text = activityStartDateModel.data!.toIso8601String();
    } else {
      DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
      if (dateTime != null) {
        // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        startDateController.text = formattedDate.toString();
        _eventComplete(emit);
      } else {
        log("Date is not selected");
      }
    }
  }

  _selectEndDate(SelectEndDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      endDateController.text = formattedDate.toString();
      _eventComplete(emit);
    } else {
      log("Date is not selected");
    }
  }

  _captureCamera(CaptureCameraEvent event, emit) async {
    var photoPath = await HomeHelper.cameraCapture();
    log("photo-->${photoPath}");
    if (photoPath != null) {
      _photo = photoPath;
    }
    _eventComplete(emit);
  }

  _captureGallery(CaptureGalleryEvent event, emit) async {
    var photoPath = await HomeHelper.galleryCapture();
    log("photo-->${photoPath}");
    if (photoPath != null) {
      _photo = photoPath;
    }
    _eventComplete(emit);
  }

  _eventComplete(Emitter<HomeState> emit) {
    emit(HomeFetchDataState(
      isPageLoader: isPageLoader,
      isActivityLoader: isActivityLoader,
      photo: photo,
      blockValue: blockValue,
      schemeValue: schemeValue,
      subSystemDataValue: subSystemDataValue,
      activityValue: activityValue,
      blockList: blockList,
      schemeList: schemeList,
      subSystemList: subSystemList,
      activityList: activityList,
      startDateController: startDateController,
      endDateController: endDateController,
      remarksController: remarksController,
      subSystemModel: subSystemModel,
      activityModel: activityModel,
      districtValue: districtValue,
      districtList: districtList,
      activityStartDateModel: activityStartDateModel,
      allContractorDataList: contractorList,
      allContractorValue: contractorValue,
      schemeIdController: schemeIdController,
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';
import 'package:structure_app/features/Home/domain/bloc/home_event.dart';
import 'package:structure_app/features/Home/domain/bloc/home_state.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/MajorActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/QuantityModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
import 'package:structure_app/features/Home/helper/home_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeInitialState()){
    on<HomePageLoaderEvent>(_pageLoader);
    on<SelectDistrictEvent>(_selectDistrict);
    on<SelectBlockEvent>(_selectBlock);
    on<SelectSchemaEvent>(_selectSchema);
    on<SelectMajorActivityEvent>(_selectMajorActivity);
    on<SelectActivityEvent>(_selectActivity);
    on<HomeSubmitEvent>(_logout);
  }

  bool _isPageLoader = false;
  bool get isPageLoader => _isPageLoader;

  DistrictData? districtValue;
  BlockData? blockValue;
  SchemeData? schemeValue;
  QuantityData? quantityValue;
  MajorActivityData? majorActivityValue;
  ActivityData? activityValue;

  List<DistrictData> _districtList = [];
  List<DistrictData> get districtList => _districtList;

  List<BlockData> _blockList = [];
  List<BlockData> get blockList => _blockList;

  List<SchemeData>  _schemeList = [];
  List<SchemeData> get schemeList => _schemeList;

  QuantityData  _quantityData = QuantityData();
  QuantityData get quantityData => _quantityData;

  List<MajorActivityData> _majorActivityList =  [];
  List<MajorActivityData> get majorActivityList => _majorActivityList;

  List<ActivityData> _activityList =  [];
  List<ActivityData> get activityList => _activityList;

  TextEditingController configuredScopeController = TextEditingController();
  TextEditingController workDoneTodayController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  _pageLoader(HomePageLoaderEvent event, emit) async {
    emit(HomePageLoaderState());
    _isPageLoader = false;
    districtValue = DistrictData();
    blockValue = BlockData();
    schemeValue = SchemeData();
    quantityValue = QuantityData();
    majorActivityValue = MajorActivityData();
    activityValue = ActivityData();
    _districtList = [];
    _blockList = [];
    _schemeList = [];
    _quantityData =QuantityData();
    _majorActivityList =  [];
    _activityList =  [];
    configuredScopeController.text = "";
    workDoneTodayController.text = "";
    remarksController.text = "";
    await fetchDistrictData(context: event.context);
    _eventComplete(emit);
  }

  fetchDistrictData({required BuildContext context}) async {
    var res = await HomeHelper.districtData(context: context);
    if(res != null ){
      _districtList = res.data!;
    } else if (res != null && res.status == false) {
      return Utils.failureMeg(res.data.toString(), context);
    }
  }

  fetchBlocksData({required BuildContext context,required int id, emit}) async {
    var res = await HomeHelper.blocksData(id: int.parse(districtValue!.networkTypeId!),context: context);
    if(res != null){
      _blockList = res.data;
      blockValue = null;
      schemeValue  = null;
      majorActivityValue = null;
      activityValue  = null;
    }else if (res != null && res.status == false) {
      return Utils.failureMeg(res.data.toString(), context);
    }
    _eventComplete(emit);
  }

  fetchSchemesData({required BuildContext context,required int id, emit}) async {
    var res = await HomeHelper.schemesData(id: int.parse(blockValue!.blockId!),context: context);
    if(res != null){
      _schemeList = res.data;
      schemeValue  = null;
      majorActivityValue = null;
      activityValue  = null;
    }else if (res != null && res.status == false) {
      return Utils.failureMeg(res.data.toString(), context);
    }
    _eventComplete(emit);
  }

  fetchMajorActivitiesData({required BuildContext context,required int id, emit}) async {
    var res = await HomeHelper.majorActivitiesData(id: int.parse(schemeValue!.schemeId!),context: context);
    if(res!.data.isNotEmpty){
      _majorActivityList = res.data;
      majorActivityValue = null;
      activityValue = null;
    } else if (res.data == null && res.status == false) {
      return Utils.failureMeg(res.data.toString(), context);
    }
    _eventComplete(emit);
  }
  fetchActivitiesData({required BuildContext context,required int schemeId,required int majeorId, emit}) async {
    var res = await HomeHelper.activitiesData(
        schemeId: int.parse(schemeValue!.schemeId!),
        majeorId: int.parse(majorActivityValue!.majorActivityId!),
        context: context);
    if(res != null){
      _activityList = res.data;
      activityValue = null;
    } else if (res != null && res.status == false) {
      return Utils.failureMeg(res.data.toString(), context);
    }
    _eventComplete(emit);
  }

  fetchQuantityData({required BuildContext context,required int schemeId, required int majeorId,required int activeId,emit}) async {
    var res = await HomeHelper.quantityData(
        schemeId: int.parse(schemeValue!.schemeId!),
        majeorId: int.parse(majorActivityValue!.majorActivityId!),
        activeId: int.parse(activityValue!.id!),
        context: context);
    if(res != null){
      _quantityData = res.data;
      configuredScopeController.text = _quantityData.quantity! + _quantityData.uomName!;
    } else if (res != null && res.status == false) {
      return Utils.failureMeg(res.message.toString(), context);
    }
    _eventComplete(emit);
  }

  _logout(HomeSubmitEvent event,  emit) async {
    try{
      var validationCheck = await HomeHelper.validationSubmit(
          context: event.context,
          distinct: districtValue!.networkTypeId.toString(),
          block: blockValue!.blockId.toString(),
          scheme: schemeValue!.schemeId.toString(),
          majorActivityId: majorActivityValue!.majorActivityId.toString(),
          activityId: activityValue!.id.toString(),
          targetPerDay: workDoneTodayController.text.trim().toString(),
          remarks: remarksController.text.trim().toString());
      if(validationCheck ==  true){
        _isPageLoader = true;
        _eventComplete(emit);
      var res= await HomeHelper.progressData(
          context: event.context,
          schemeId: schemeValue!.schemeId.toString(),
          majorActivityId: majorActivityValue!.majorActivityId.toString(),
          activityId: activityValue!.id.toString(),
          boqId: quantityData.boqId.toString(),
          quantity: quantityData.quantity.toString(),
          targetPerDay: workDoneTodayController.text.trim().toString(),
          remarks: remarksController.text.trim().toString());
      //_eventComplete(emit);
      if(res != null && res.status == true){
        _isPageLoader = false;
        _eventComplete(emit);
        Utils.successToast(res.message!,event.context);
        Navigator.pushReplacementNamed(event.context, RoutesName.homeView,);
        districtValue = DistrictData();
        majorActivityValue = null;
        blockValue = null;
        schemeValue = null;
        activityValue = null;
        configuredScopeController.text = "";
        workDoneTodayController.text = "";
        remarksController.text = "";
        _eventComplete(emit);
      } else{
        _isPageLoader = false;
        _eventComplete(emit);
      }}
    }catch(e){
      _isPageLoader = false;
      _eventComplete(emit);
    }
  }

  _selectDistrict(SelectDistrictEvent event, emit) async {
    districtValue = event.districtValue;
    await fetchBlocksData(id: int.parse(districtValue!.networkTypeId!), context: event.context,  emit: emit);
    _eventComplete(emit);
  }

  _selectBlock(SelectBlockEvent event, emit) async {
    blockValue = event.blockValue;
    await fetchSchemesData(id: int.parse(blockValue!.blockId!), context: event.context,  emit: emit);
    _eventComplete(emit);
  }

  _selectSchema(SelectSchemaEvent event, emit) async {
    schemeValue = event.schemaValue;
    await fetchMajorActivitiesData(id: int.parse(schemeValue!.schemeId!), context: event.context, emit: emit);
    _eventComplete(emit);
  }

  _selectMajorActivity(SelectMajorActivityEvent event, emit) async {
    majorActivityValue = event.majorActivityValue;
    await fetchActivitiesData(
        schemeId: int.parse(schemeValue!.schemeId!),
        majeorId: int.parse(majorActivityValue!.majorActivityId!),
        context: event.context, emit: emit);
    _eventComplete(emit);
  }

  _selectActivity(SelectActivityEvent event, emit) async {
    activityValue = event.activityValue;
    await fetchQuantityData(
        schemeId: int.parse(schemeValue!.schemeId!),
        majeorId: int.parse(majorActivityValue!.majorActivityId!),
        activeId: int.parse(activityValue!.id!),
        context: event.context, emit: emit);
    _eventComplete(emit);
  }

  _eventComplete(Emitter<HomeState>emit){
    emit(HomeFetchDataState(
        isPageLoader: isPageLoader,
        districtValue: districtValue,
        blockValue: blockValue,
        schemeValue: schemeValue,
        quantityValue: quantityValue,
        majorActivityValue: majorActivityValue,
        activityValue: activityValue,
        districtList: districtList, blockList: blockList,
        schemeList: schemeList,
        quantityList: quantityData,
        majorActivityList: majorActivityList,
        activityList: activityList,
        configuredScopeController: configuredScopeController,
        workDoneTodayController: workDoneTodayController,
        remarksController: remarksController
    ));
  }


}

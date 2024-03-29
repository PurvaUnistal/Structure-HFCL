import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_app/Utils/common_widget/Loader/SpinLoader.dart';
import 'package:structure_app/Utils/common_widget/Loader/dotted_loader_widget.dart';
import 'package:structure_app/Utils/common_widget/app_bar_widget.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/Utils/common_widget/button_widget.dart';
import 'package:structure_app/Utils/common_widget/dropdown_widget.dart';
import 'package:structure_app/Utils/common_widget/image_pop_widget.dart';
import 'package:structure_app/Utils/common_widget/text_form_widget.dart';
import 'package:structure_app/Utils/local_img_widget.dart';
import 'package:structure_app/features/Home/domain/bloc/home_bloc.dart';
import 'package:structure_app/features/Home/domain/bloc/home_event.dart';
import 'package:structure_app/features/Home/domain/bloc/home_state.dart';
import 'package:structure_app/features/Home/presentation/widget/logout_widget.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_event.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NetworkBloc>(context).add(NetworkObserveEvent(context: context));
    BlocProvider.of<HomeBloc>(context).add(HomePageLoaderEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.home,
        actions: [
          IconButton(
              onPressed: () async {
                showModalBottomSheet(context: context, builder: (context) => const LogoutWidget());
              },
              icon: Icon(
                Icons.logout,
                color: AppColor.white,
              ))
        ],
      ),
      backgroundColor: AppColor.white,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeFetchDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return const Center(
              child: SpinLoader(),
            );
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required HomeFetchDataState dataState}) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _verticalSpace(),
            _blockDropDown(dataState: dataState),
            _verticalSpace(),
            _schemeDropDown(dataState: dataState),
            _verticalSpace(),
            _majorActivityDropDown(dataState: dataState),
            _verticalSpace(),
            _activityDropDown(dataState: dataState),
            _quantityMessage(dataState: dataState),
            _startDateController(dataState: dataState),
            _endDateController(dataState: dataState),
            _activityRemark(dataState: dataState),
            _photo(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        )));
  }

  Widget _districtDropDown({required HomeFetchDataState dataState}) {
    return DropdownWidget(
      hint: AppString.distinct,
      label: AppString.distinct,
      dropdownValue: dataState.districtValue?.networkType != null ? dataState.districtValue : null,
      onChanged: (value) {
        BlocProvider.of<HomeBloc>(context).add(SelectDistrictEvent(districtValue: value, context: context));
      },
      items: dataState.districtList,
    );
  }

  Widget _blockDropDown({required HomeFetchDataState dataState}) {
    return DropdownWidget(
      hint: AppString.block,
      label: AppString.block,
      dropdownValue: dataState.blockValue?.block != null ? dataState.blockValue : null,
      onChanged: (value) {
        BlocProvider.of<HomeBloc>(context).add(SelectBlockEvent(blockValue: value, context: context));
      },
      items: dataState.blockList,
    );
  }

  Widget _schemeDropDown({required HomeFetchDataState dataState}) {
    return DropdownWidget(
      hint: AppString.scheme,
      label: AppString.scheme,
      dropdownValue: dataState.schemeValue?.scheme != null ? dataState.schemeValue : null,
      onChanged: (value) {
        BlocProvider.of<HomeBloc>(context).add(SelectSchemaEvent(schemaValue: value, context: context));
      },
      items: dataState.schemeList,
    );
  }

  Widget _majorActivityDropDown({required HomeFetchDataState dataState}) {
    return DropdownWidget(
      hint: AppString.majorActivity,
      label: AppString.majorActivity,
      dropdownValue: dataState.majorActivityValue?.subSystem != null ? dataState.majorActivityValue : null,
      onChanged: (value) {
        BlocProvider.of<HomeBloc>(context).add(SelectMajorActivityEvent(majorActivityValue: value, context: context));
      },
      items: dataState.majorActivityList,
    );
  }

  Widget _activityDropDown({required HomeFetchDataState dataState}) {
    return DropdownWidget(
      hint: AppString.activity,
      label: AppString.activity,
      dropdownValue: dataState.activityValue?.name != null ? dataState.activityValue : null,
      onChanged: (value) {
        BlocProvider.of<HomeBloc>(context).add(SelectActivityEvent(activityValue: value, context: context));
      },
      items: dataState.activityList,
    );
  }

  Widget _quantityMessage({required HomeFetchDataState dataState}) {
    return dataState.quantityList.status == true ? Container() : _column(child: Text(dataState.quantityList.message ?? ""));
  }

  Widget _startDateController({required HomeFetchDataState dataState}) {
    return dataState.quantityList.activityId == null
        ? Container()
        : _column(
            child: TextFieldWidget(
            label: AppString.startDate,
            hintText: AppString.startDate,
            enabled: true,
              keyboardType: TextInputType.text,
            controller: dataState.startDateController,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today_rounded,
                color: AppColor.appBlue,
              ),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(SelectStartDateEvent(context: context));
              },
            ),
            onTap: () {
              FocusScope.of(context).focusedChild!.unfocus();
              BlocProvider.of<HomeBloc>(context).add(SelectStartDateEvent(context: context));
            },
          ));
  }

  Widget _endDateController({required HomeFetchDataState dataState}) {
    return dataState.quantityList.activityId == null
        ? Container()
        : _column(
            child: TextFieldWidget(
            label: AppString.endDate,
            hintText: AppString.endDate,
            enabled: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: dataState.endDateController,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today_rounded,
                color: AppColor.appBlue,
              ),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(SelectEndDateEvent(context: context));
              },
            ),
            onTap: () {
              FocusScope.of(context).focusedChild!.unfocus();
              BlocProvider.of<HomeBloc>(context).add(SelectEndDateEvent(context: context));
            },
          ));
  }

  Widget _activityRemark({required HomeFetchDataState dataState}) {
    return dataState.quantityList.activityId == null
        ? Container()
        : _column(
            child: TextFieldWidget(
            maxLine: 3,
              keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            label: AppString.remarks,
            controller: dataState.remarksController,
          ));
  }

  Widget _photo({required HomeFetchDataState dataState}) {
    return dataState.quantityList.activityId == null
        ? Container()
        : _column(
            child: LocalImgWidget(
              file: dataState.photo,
              onTap: () {
                showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ImagePopWidget(
                        onTapCamera: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<HomeBloc>(context).add(CaptureCameraEvent());
                        },
                        onTapGallery: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<HomeBloc>(context).add(CaptureGalleryEvent());
                        },
                      );
                    });
              },
            ),
          );
  }

  Widget _button({required HomeFetchDataState dataState}) {
    return dataState.isPageLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            onPressed: () {
              FocusScope.of(context).unfocus();
              TextInput.finishAutofillContext();
              BlocProvider.of<HomeBloc>(context).add(HomeSubmitEvent(context: context));
            })
        : const DottedLoaderWidget();
  }

  Widget _column({required Widget child}) {
    return Column(
      children: [_verticalSpace(), child],
    );
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

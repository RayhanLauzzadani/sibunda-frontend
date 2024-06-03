import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/domain/model/profile_data.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/form_controller.dart';
import 'package:common/arch/ui/widget/form_generic_vm_group_observer.dart';
import 'package:common/arch/ui/widget/form_vm_observer.dart';
import 'package:common/arch/ui/widget/picker_icon_widget.dart';
import 'package:common/config/manifest.dart';
import 'package:common/res/string/_string.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/util/navigations.dart';
import 'package:common/util/ui.dart';
import 'package:common/value/const_values.dart';
import 'package:core/ui/base/live_data_observer.dart';
import 'package:core/ui/base/view_model.dart';
import 'package:flutter/material.dart';
import 'package:home/config/home_routes.dart';
import 'package:home/ui/form_get_started/father_form_vm.dart';

class FatherFormPage extends StatelessWidget {
  final PageController? pageControll;
  final FormGroupInterceptor? interceptor;

  FatherFormPage({
    this.pageControll,
    this.interceptor,
  });

  @override
  Widget build(BuildContext context) {
    final canSkip = getArgs<bool>(context, Const.KEY_CAN_SKIP) != false;
    final credential =
        getArgs<ProfileCredential>(context, Const.KEY_CREDENTIAL);
    final isEdit = getArgs<bool>(context, Const.KEY_IS_EDIT) == true;

    final vm = ViewModelProvider.of<FatherFormVm>(context)
      ..getFatherData(
        credential: credential,
      );

    return Column(
      children: [
        Text(
          !isEdit ? Strings.fill_father_data : Strings.edit_father_data,
          style: SibTextStyles.header1,
        ).withMargin(EdgeInsets.only(top: 60)),
        //ImgPick().withMargin(EdgeInsets.only(top: 10, bottom: 14)),
        LiveDataObserver<ImgData>(
          liveData: vm.imgProfile,
          builder: (ctx, img) => ImgPick(
            pic: img,
            onImgPick: (file) => vm.imgProfile.value =
                file != null ? ImgData.fromXFile(file) : null,
          ),
        ).withMargin(EdgeInsets.only(
          top: 10,
          bottom: 10,
        )),
        // if (canSkip)
        //   Padding(
        //     padding: EdgeInsets.only(
        //       top: 10,
        //       bottom: 20,
        //     ),
        //     child: TxtLink(
        //       Strings.skip,
        //       onTap: () {
        //         vm.isDataPresent.value = false;
        //         _toNextPage(context);
        //       },
        //     ),
        //   ),
        FormVmGroupObserver<FatherFormVm>(
          showHeader: false,
          interceptor: interceptor,
          pickerIconBuilder: (group, key, data) {
            if (group == 0) {
              switch (key) {
                case Const.KEY_BIRTH_PLACE:
                  return CityPickerIcon(
                    onItemSelected: (city) async {
                      data.value = city;
                    },
                  );
                case Const.KEY_BLOOD_TYPE:
                  return BloodTypePickerIcon(
                    onItemSelected: (bloodType) async {
                      data.value = bloodType?.name;
                    },
                  );
              }
            }
          },
          onSubmit: (ctx, success) {
            if (success) {
              _toNextPage(ctx);
            } else {
              showSnackBar(ctx, "Terjadi kesalahan");
            }
          },
          submitBtnMargin: EdgeInsets.only(
            bottom: 15,
          ),
          submitBtnBuilder: (ctx, canProceed) => !isEdit
              ? FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward_rounded,
                  ),
                  backgroundColor: canProceed == true ? pink_300 : grey,
                  onPressed:
                      null, //canProceed == true ? null : () => showSnackBar(context, "Masih ada yg blum valid",),
                )
              : TxtBtn(
                  Strings.update_data,
                  color:
                      canProceed == true ? Manifest.theme.colorPrimary : grey,
                ),
        ),
      ],
    ).insideScroll();
  }

  void _toNextPage(BuildContext context) {
    if (pageControll != null) {
      pageControll!.animateToPage(
        pageControll!.page!.toInt() + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      HomeRoutes.doMotherHavePregnancyPage.goToPage(context);
    }
  }
}

import 'package:common/arch/data/local/dao/data_dao.dart';
import 'package:common/arch/data/local/source/account_local_source.dart';
import 'package:common/arch/di/config_di.dart';
import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/_model_template.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/usecase/baby_usecase.dart';
import 'package:common/arch/ui/adapter/id_string_adp.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/config/manifest.dart';
import 'package:common/res/string/_string.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/util/navigations.dart';
import 'package:common/util/ui.dart';
import 'package:core/domain/model/result.dart';
import 'package:core/ui/base/live_data.dart';
import 'package:core/ui/base/live_data_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PopupSuccess extends StatelessWidget {
  final String msg;
  final String actionMsg;
  final void Function()? onActionClick;

  PopupSuccess({
    required this.msg,
    required this.actionMsg,
    this.onActionClick,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 85 / 100;
    final height = screenSize.height * 40 / 100;
    final iconSize = screenSize.width * 30 / 100;

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: green_calm,
              ),
              child: Icon(
                Icons.check,
                size: iconSize,
                color: Colors.white,
              ),
            ),
            Text(
              msg,
              style: SibTextStyles.size_0,
              textAlign: TextAlign.center,
            ),
            TxtBtn(
              actionMsg,
              onTap: onActionClick,
            ),
          ],
        ),
      ),
    );
  }
}


class PopupImgPicker extends StatelessWidget {
  final void Function(XFile?)? onItemClick;
  final imgPicker = ImagePicker();

  PopupImgPicker({
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    /*
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 85 / 100;
    final height = screenSize.height * 40 / 100;
    final iconSize = screenSize.width * 30 / 100;
     */

    pickImg(ImageSource src) => onItemClick != null ? () async {
      final res = await imgPicker.pickImage(source: src);
      onItemClick!(res);
    } : null;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => backPage(context),
        child: Container(
          color: black_trans_most2,
          alignment: Alignment.center,
          child: Flexible(
            child: Container(
              margin: EdgeInsets.all(20),
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                //direction: Axis.horizontal,
                //spacing: 10,
                //runSpacing: 10,
                children: [
                  Expanded(
                    child: _PopupImgPickerPanel(
                      icon: Icons.add_photo_alternate_outlined,
                      text: Strings.pick_img_gallery,
                      onClick: pickImg(ImageSource.gallery),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: _PopupImgPickerPanel(
                      icon: Icons.add_a_photo_outlined,
                      text: Strings.pick_img_camera,
                      onClick: pickImg(ImageSource.camera),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class _PopupImgPickerPanel extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onClick;

  _PopupImgPickerPanel({
    required this.icon,
    required this.text,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Manifest.theme.colorPrimary,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Manifest.theme.colorOnPrimary,
                size: 35,
              ),
              SizedBox(height: 10,),
              Text(
                text,
                style: SibTextStyles.size_min_1_colorOnPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class PopupError extends StatelessWidget {
  final Object error;
  //final Fail? failure;

  PopupError({
    required this.error,
    //this.failure,
  });

  @override
  Widget build(BuildContext context) {
    /*
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 85 / 100;
    final height = screenSize.height * 40 / 100;
    final iconSize = screenSize.width * 30 / 100;
     */

    final errorStr = error.toString();
    final stackStr =
        (error is Fail ? (error as Fail).stack
        : StackTrace.current).toString();

    return Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => backPage(context),
          child: Container(
            color: black_trans_most2,
            alignment: Alignment.center,
            child: Flexible(
              child: GestureDetector(
                onTap: () {
                  //Just to cancel parent on tap.
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkResponse(
                          onTap: () => backPage(context),
                          child: Icon(
                            Icons.clear,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                errorStr,
                                style: TextStyle(
                                  fontFamily: fontFamily_firaCode_common,
                                  color: yellow,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Stack Trace:",
                                style: TextStyle(
                                  fontFamily: fontFamily_firaCode_common,
                                  color: yellow,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: EdgeInsets.only(left: 10,),
                                child: Text(
                                  stackStr,
                                  style: TextStyle(
                                    fontFamily: fontFamily_firaCode_common,
                                    color: yellow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Material(
                        color: Colors.transparent,
                        child: InkResponse(
                          onTap: () {
                            final data = ClipboardData(
                              text: "$errorStr\n\n"
                                  "Stack Trace:\n"
                                  "$stackStr",
                            );
                            Clipboard.setData(data);
                            showToast(msg: "Error copied!");
                          },
                          child: Icon(
                            Icons.copy,
                            color: white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}



class IdStringPopup extends StatelessWidget {
  final List<IdStringModel> dataList;
  final void Function(int id, String name)? onItemClick;
  final bool showId;

  IdStringPopup({
    required this.dataList,
    this.onItemClick,
    this.showId = true,
  });

  @override
  Widget build(BuildContext context) {
    final txtControl = TextEditingController();
    return Column(
      children: [
        TxtInput(
          label: Strings.search,
          textController: txtControl,
        ),
        SizedBox(height: 15,),
        Expanded(
          child: IdStringListView(
            dataList: dataList,
            searchTxtControl: txtControl,
            onItemClick: onItemClick,
            showId: showId,
          ),
        ),
      ],
    );
  }
}


Future<XFile?> showPickImgPopup({
  required BuildContext context,
}) => showDialog(
  context: context,
  builder: (ctx) => PopupImgPicker(
    onItemClick: (imgFile) {
      backPage(ctx, result: imgFile);
    },
  ),
);

Future<void> showErrorPopup({
  required BuildContext context,
  required Object error,
}) => showDialog(
  context: context,
  builder: (ctx) => PopupError(error: error,),
);


Future<IdStringModel?> showIdStringPopup({
  required BuildContext context,
  required List<IdStringModel> dataList,
  String? title,
  bool showId = true,
}) => showDialog<IdStringModel>(
  context: context,
  builder: (ctx) => AlertDialog(
    title: title != null
        ? Text(title, style: SibTextStyles.size_0_bold,)
        : null,
    content: IdStringPopup(
      dataList: dataList,
      showId: showId,
      onItemClick: (id, str) => backPage<IdStringModel>(
        ctx,
        result: IdStringModel(id: id, name: str),
      ),
    ),
  ),
);

Future<IdStringModel?> showLazyIdStringPopup({
  required BuildContext context,
  required Future<List<IdStringModel>> Function() dataSrc,
  String? title,
  bool showId = true,
}) async {
  final isReady = MutableLiveData(false);

  List<IdStringModel>? dataList;
  dataSrc().then((data) {
    dataList = data;
    isReady.value = true;
  });

  return showDialog<IdStringModel>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: title != null
          ? Text(title, style: SibTextStyles.size_0_bold,)
          : null,
      content: LiveDataObserver<bool>(
        liveData: isReady,
        builder: (ctx, isReady) {
          final size = MediaQuery.of(ctx).size;
          final maxWidth = size.width *8 /10;
          final maxHeight = size.height *8 /10;
          return isReady == true ? Container(
            width: maxWidth,
            height: maxHeight,
/*
            constraints: BoxConstraints(
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
 */
            child: IdStringPopup(
              dataList: dataList!,
              showId: showId,
              onItemClick: (id, str) => backPage<IdStringModel>(
                ctx,
                result: IdStringModel(id: id, name: str),
              ),
            ),
          ) : defaultLoading(
            height: 100,
            width: 100,
          );
        },
      ),
    ),
  );
}


Future<IdStringModel?> showCitySelectionPopup({
  required BuildContext context,
  required CityDao dao,
}) => showLazyIdStringPopup(
  context: context,
  title: Strings.select_city,
  showId: false,
  dataSrc: () async {
    final cities = await dao.get();
    final list = cities.map((e) => IdStringModel(id: e.id, name: e.name)).toList(growable: false);
    return list;
  },
);

Future<IdStringModel?> showBabySelectionPopup({
  required BuildContext context,
  required GetBornBabyList getBornBabyList,
}) => showLazyIdStringPopup(
  context: context,
  title: Strings.select_city,
  showId: false,
  dataSrc: () async {
    final bornBabiesRes = await getBornBabyList(VarDi.motherNik.getOrElse());
    if(bornBabiesRes is Success<List<BabyOverlayData>>) {
      final bornBabies = bornBabiesRes.data;
      final list = bornBabies.map((e) => IdStringModel(id: e.id, name: e.name)).toList(growable: false);
      return list;
    } else {
      throw "Can't get born baby list data in `showBabySelectionPopup()`; e= $bornBabiesRes";
    }
  },
);

Future<IdStringModel?> showGenderSelectionPopup({
  required BuildContext context,
}) => showLazyIdStringPopup(
  context: context,
  title: Strings.select_gender,
  showId: false,
  dataSrc: () async => [
    IdStringModel(id: 0, name: "-"),
    ...genderSelectionList,
  ],
);

Future<IdStringModel?> showBloodTypeSelectionPopup({
  required BuildContext context,
}) => showLazyIdStringPopup(
  context: context,
  title: Strings.select_blood_type,
  showId: false,
  dataSrc: () async => bloodTypeSelectionList,
);
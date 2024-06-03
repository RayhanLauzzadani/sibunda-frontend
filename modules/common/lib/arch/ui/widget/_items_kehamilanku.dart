import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/domain/model/kehamilanku_data.dart';
import 'package:common/arch/ui/adapter/child_overlay_adp.dart';
import 'package:common/arch/ui/model/immunization.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/txt_suffix_icon.dart';
import 'package:common/config/manifest.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/arch/ui/widget/_item_template.dart';
import 'package:common/util/assets.dart';
import 'package:core/ui/base/live_data.dart';
import 'package:core/ui/base/live_data_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '_item_immunization.dart';
import 'overlay_widget.dart';

final _cornerRadius = 10.0;
final _paddingSmall = 10.0;

class ItemMotherUnbornOverview extends StatelessWidget {
  final ImgData img;
  final int pregnancyAge; // in weeks
  final int pregnancyAgeRem; // in days
  //final BabyOverlayData? bornBaby;

  ItemMotherUnbornOverview({
    required this.img,
    required this.pregnancyAge,
    required this.pregnancyAgeRem,
    //this.bornBaby,
  });

  ItemMotherUnbornOverview.fromData({
    MotherPregnancyAgeOverview? data,
    //this.bornBaby,
  })  : img = data?.img ?? dummyImg,
        pregnancyAge = data?.weekAge ?? -1,
        pregnancyAgeRem = data?.daysRemaining ?? -1;

  ItemMotherUnbornOverview.def()
      : img = dummyImg,
        pregnancyAge = -1,
        pregnancyAgeRem = -1
  //bornBaby = null
  ;

  @override
  Widget build(BuildContext context) {
    print(pregnancyAge);
    return pregnancyAge == -1
        ? defaultLoading()
        : ItemModuleHomeOverview(
            image: SibImages.resolve(img),
            upperText: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: SibTextStyles.size_0_bold_black,
                children: [
                  TextSpan(text: "Bunda sekarang sudah masuk ke usia "),
                  TextSpan(
                      text: "$pregnancyAge Minggu ",
                      style: SibTextStyles.size_0_bold_colorPrimary),
                  TextSpan(text: "kehamilan ya"),
                ],
              ),
            ),
            lowerText: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: SibTextStyles.size_0_bold_black,
                children: [
                  TextSpan(
                      text: "$pregnancyAgeRem hari ",
                      style: SibTextStyles.size_0_bold_colorPrimary),
                  TextSpan(text: "lagi menuju kelahiran ya Bun"),
                ],
              ),
            ),
          );
  }
}

class ItemMotherBornOverview extends StatelessWidget {
  final ImgData img;
  final BabyOverlayData? bornBaby;
  final void Function()? onActionClick;

  ItemMotherBornOverview({
    required this.bornBaby,
    this.onActionClick,
    ImgData? img,
    //this.bornBaby,
  }) : img = img ?? imgPregnancyAgeOverview;

  @override
  Widget build(BuildContext context) {
    return ItemModuleHomeOverview(
      image: SibImages.resolve(img),
      upperText: Text(
        "Selamat Bunda!\n"
        "${bornBaby?.name ?? "Bayi"} sudah lahir.",
        style: SibTextStyles.size_0_bold,
      ),
      lowerText: TxtBtn(
        "Isi Data Pemeriksaan Bayi",
        onTap: onActionClick,
      ),
    );
  }
}

/*
class ItemMotherTrimester extends StatelessWidget {
  final Widget image;
  final int trimester;
  final int pregnancyAgeStart; //in weeks
  final int pregnancyAgeEnd; //in weeks
  final void Function()? onClick; //in weeks

  ItemMotherTrimester({
    required this.image,
    required this.trimester,
    required this.pregnancyAgeStart,
    required this.pregnancyAgeEnd,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {

  }
}
 */

///*
class ItemMotherTrimester extends StatelessWidget {
  final ImgData img;
  final int trimester;
  final int pregnancyAgeStart; //in weeks
  final int pregnancyAgeEnd; //in weeks
  final void Function()? onClick; //in weeks

  ItemMotherTrimester({
    required this.img,
    required this.trimester,
    required this.pregnancyAgeStart,
    required this.pregnancyAgeEnd,
    this.onClick,
    Key? key,
  }) : super(
          key: key,
        );

  ItemMotherTrimester.fromData(
    MotherTrimester data, {
    this.onClick,
    Key? key,
  })  : img = data.img,
        trimester = data.trimester,
        pregnancyAgeStart = data.startWeek,
        pregnancyAgeEnd = data.endWeek,
        super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return ItemHomeFormMenu(
      image: SibImages.resolve(img),
      title: "Trimester $trimester",
      desc: "Usia kehamilan $pregnancyAgeStart hingga $pregnancyAgeEnd Minggu",
      onClick: onClick,
    );
  }
}

// */

/*
class ItemMotherImmunizationHome extends StatelessWidget {
  final Widget image;
  final String title;
  final String action;
  final void Function()? onBtnClick;

  ItemMotherImmunizationHome({
    required this.image,
    this.title = "Jangan lupa ikut imunisasi ya Bunda",
    this.action = "Lihat imunisasi Bunda",
    this.onBtnClick,
  });

  @override
  Widget build(BuildContext context) {
    return ItemHomeImmunization(
      image: image,
      title: title,
      action: action,
      onBtnClick: onBtnClick,
    );
  }
}
 */

/*
class ItemMotherGraphMenu extends StatelessWidget {
  final Widget image;
  final String text;

  ItemMotherGraphMenu({
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ItemHomeGraphMenu(
      image: image,
      text: text,
    );
  }
}
 */

class ItemMotherRecomFood extends StatelessWidget {
  final ImgData img;
  final String foodName;
  final String desc;

  ItemMotherRecomFood({
    required this.img,
    required this.foodName,
    required this.desc,
  });

  ItemMotherRecomFood.fromData(MotherFoodRecom data)
      : img = data.img ?? dummyImg,
        foodName = data.food,
        desc = data.desc;

  @override
  Widget build(BuildContext context) {
    //final parentHeight = 10.0;
    final parentMinHeight = 80.0;

    final imgChild = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: parentMinHeight,
        maxWidth: 70,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 60,
                width: 60,
                child: SibImages.resolve(img),
              ),
            ),
          ),
          Text(
            foodName,
            style: SibTextStyles.size_min_1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    final txtChild = Expanded(
      child: Text(
        desc,
        style: SibTextStyles.size_min_1_bold,
        textAlign: TextAlign.start,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: parentMinHeight,
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                imgChild,
                Container(
                  constraints: BoxConstraints(
                    minHeight: parentMinHeight,
                    maxWidth: 2,
                    minWidth: 2,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: Manifest.theme.colorPrimary,
                ),
                txtChild
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///*
/// Used in mother pregnancy check form.
class ItemMotherBabySizeOverview extends StatelessWidget {
  final ImgData img;
  final String sizeString;
  final double? babyLen;
  final double? babyWeight;

  ItemMotherBabySizeOverview({
    required this.img,
    required this.sizeString,
    this.babyLen,
    this.babyWeight,
  });

  ItemMotherBabySizeOverview.fromData(PregnancyBabySize data)
      : img = data.img ?? dummyImg,
        sizeString = data.sizeString, //?? "<null>",
        babyLen = data.babyLen, // ?? -1,
        babyWeight = data.babyWeight // ?? -1
  ;

  @override
  Widget build(BuildContext context) {
    final imgChild = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        height: 70,
        width: 60,
        child: SibImages.resolve(
          img,
          fit: BoxFit.contain,
        ),
      ),
    );

    final descChild = Expanded(
      child: RichText(
        text: TextSpan(
          style: SibTextStyles.size_0_bold_black,
          children: [
            TextSpan(text: "Selamat Bunda!\nSekarang si Kecil sudah sebesar "),
            TextSpan(
                text: "$sizeString ",
                style: SibTextStyles.size_0_bold_colorPrimary),
            TextSpan(text: "ya Bun"),
          ],
        ),
      ),
    );

    final babyLenChild = babyLen != null
        ? RichText(
            text: TextSpan(
              style: SibTextStyles.size_min_2_black,
              children: [
                TextSpan(text: "Panjang Bayi : "),
                TextSpan(
                    text: "$babyLen inch",
                    style: SibTextStyles.size_min_2_bold_colorPrimary),
              ],
            ),
          )
        : null;

    final babyWeightChild = babyWeight != null
        ? RichText(
            text: TextSpan(
              style: SibTextStyles.size_min_2_black,
              children: [
                TextSpan(text: "Berat Bayi : "),
                TextSpan(
                    text: "$babyWeight pounds",
                    style: SibTextStyles.size_min_2_bold_colorPrimary),
              ],
            ),
          )
        : null;

    final sizeQuantitativeChildren = <Widget>[];
    if (babyLenChild != null) {
      sizeQuantitativeChildren.add(babyLenChild);
    }
    if (babyWeightChild != null) {
      sizeQuantitativeChildren.add(babyWeightChild);
    }
    if (sizeQuantitativeChildren.length == 2) {
      sizeQuantitativeChildren.insert(
        1,
        SizedBox(
          width: 15,
        ),
      );
    }
    final sizeQuantitativeRow = sizeQuantitativeChildren.isNotEmpty
        ? Row(
            children: sizeQuantitativeChildren,
          )
        : null;

    final colChildren = <Widget>[
      Row(
        children: [
          imgChild,
          Container(
            width: 10,
          ),
          descChild,
        ],
      ),
      Container(
        height: 10,
      ),
    ];
    if (sizeQuantitativeRow != null) {
      colChildren.add(sizeQuantitativeRow);
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        color: grey_calm,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: colChildren,
/*
            [
              Row(
                children: [
                  imgChild,
                  Container(width: 10,),
                  descChild,
                ],
              ),
              Container(height: 10,),
              Row(
                children: [
                  babyLenChild,
                  SizedBox(width: 15,),
                  babyWeightChild,
                ],
              ),
            ],
*/
          ),
        ),
      ),
    );
  }
}

class BabyOverlayControlBtn extends StatelessWidget {
  final String text;
  final MutableLiveData<bool> visibilityController;
  final void Function(bool isVisible)? onClick;

  BabyOverlayControlBtn({
    required this.text,
    required this.visibilityController,
    this.onClick,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return LiveDataObserver<bool>(
      liveData: visibilityController,
      builder: (ctx, vis) => Container(
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TxtSuffixIcon(
              color: Manifest.theme.primaryHighlightColor,
              txt: text,
              onClick: () {
                visibilityController.value = visibilityController.value != true;
                onClick?.call(visibilityController.value == true);
              },
              suffix: vis == true
                  ? Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: white,
                    )
                  : Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class BabySelectionOverlay extends StatelessWidget {
  final MutableLiveData<bool> visibilityController;
  final LiveData<List<BabyOverlayData>> bornBabyList;
  final LiveData<List<BabyOverlayData>> unbornBabyList;
  final void Function()? onCancel;
  final void Function(BabyOverlayData, bool isBorn)? onItemClick;
  final void Function(bool isBorn)? onAddItemClick;

  /// For all born and unborn baby.
  final LiveData<int>? selectedIndex;
  final bool isSelectedIndexOwner;

  BabySelectionOverlay({
    required this.visibilityController,
    required this.bornBabyList,
    required this.unbornBabyList,
    this.onCancel,
    this.onItemClick,
    this.onAddItemClick,
    this.selectedIndex,
    bool? isSelectedIndexOwner,
  }) : isSelectedIndexOwner = isSelectedIndexOwner ?? selectedIndex == null;

  @override
  Widget build(BuildContext context) {
    //final key = UniqueKey();
    return BelowTopBarOverlay(
        visibilityController: visibilityController,
        onCancel: onCancel,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: MultiLiveDataObserver<List<BabyOverlayData>>(
            //key: key,
            liveDataList: [unbornBabyList, bornBabyList],
            builder: (ctx, lists) => !lists.any((e) => e == null)
                ? ChildrenListOverlay(
                    isSelectedIndexOwner: isSelectedIndexOwner,
                    selectedIndex: selectedIndex,
                    unbornBabyList: lists[0]!,
                    bornBabyList: lists[1]!,
                    onItemClick: onItemClick,
                    onAddItemClick: onAddItemClick,
                  )
                : defaultLoading(height: double.infinity),
          ),
        ));
  }
}

// */
/*
class ItemMotherImmunizationFill extends StatelessWidget {
  final String immunizationName;
  final String? date;

  ItemMotherImmunizationFill({
    required this.immunizationName,
    this.date,
  });

  ItemMotherImmunizationFill.fromData(ImmunizationListItem data):
    immunizationName = data.core.name,
    date = data.core.date
  ;

  @override
  Widget build(BuildContext context) {
    return ItemImmunizationFill(
      immunizationName: immunizationName,
      date: date,
    );
  }
}
 */



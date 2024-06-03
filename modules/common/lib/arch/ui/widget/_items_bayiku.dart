import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/_item_template.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/util/assets.dart';
import 'package:common/util/text.dart';
import 'package:flutter/material.dart';

class ItemBabyOverview extends StatelessWidget {
  final ImgData img;
  final String ageString;
  final String name;

  ItemBabyOverview({
    required this.img,
    required this.ageString,
    required this.name,
  });

  factory ItemBabyOverview.fromData(
    BabyAgeOverview? data, {
    String? babyName,
  }) {
    final ageString = data?.desc ?? "<null>";
/*
    formatAgeString(
      year: data?.year ?? -1,
      month: data?.month ?? -1,
      day: data?.day ?? -1,
    );
 */
    return ItemBabyOverview(
      img: data?.img ?? dummyImg,
      ageString: ageString,
      name: babyName ?? "Bayi Bunda",
    );
  }

  @override
  Widget build(BuildContext context) {
    return ageString == "<null>"
        ? defaultLoading()
        : ItemModuleHomeOverview(
            image: SibImages.resolve(img),
            upperText: RichText(
              text: TextSpan(
                style: SibTextStyles.size_0_bold_black,
                children: [
                  TextSpan(text: "$name sekarang sudah berusia "),
                  TextSpan(
                      text: ageString,
                      style: SibTextStyles.size_0_bold_colorPrimary),
                  TextSpan(text: " ya Bun"),
                ],
              ),
            ),
          );
  }
}

class ItemBabyFormMenu extends StatelessWidget {
  final int year;
  final int ageStart; //In month
  final int ageEnd; //In month
  final ImgData img; //In month
  final void Function()? onClick;

  ItemBabyFormMenu({
    required this.year,
    required this.ageStart,
    required this.ageEnd,
    required this.img,
    this.onClick,
  });

  ItemBabyFormMenu.fromData(
    BabyFormMenuData data, {
    this.onClick,
  })  : img = data.img,
        year = data.year,
        ageStart = data.monthStart,
        ageEnd = data.monthEnd;

  @override
  Widget build(BuildContext context) {
    return ItemHomeFormMenu(
      image: SibImages.resolve(img),
      title: "Tahun ${toPeriodString(year)}",
      desc: "Usia bayi $ageStart hingga $ageEnd bulan",
      onClick: onClick,
    );
  }
}

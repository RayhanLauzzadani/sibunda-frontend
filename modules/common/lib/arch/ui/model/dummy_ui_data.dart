import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/ui/model/immunization.dart';
import 'package:common/config/_config.dart';
import 'package:flutter/material.dart';

import 'home_graph_menu.dart';

const ic_gender = IconData(0x26A4, fontFamily: 'NotoSymbols');

final motherHomeGraph_ui = <HomeGraphMenu>[
  HomeGraphMenu(name: 'Grafik Evaluasi Kehamilan', img: dummyImg,),
  HomeGraphMenu(name: 'Grafik Berat Badan', img: dummyImg,),
];

final babyHomeGraph_ui = <HomeGraphMenu>[
  HomeGraphMenu(name: 'Pertumbuhan Bayi', img: dummyImg,),
  HomeGraphMenu(name: 'Perkembangan Bayi', img: dummyImg,),
];


final motherHomeImmunization_ui = HomeImmunizationData(
  action: "Lihat imunisasi Bunda",
  title: "Jangan lupa ikut imunisasi ya Bunda",
  img: ImgData(
    link: "kehamilanku_imunisasipng.png",
    package: GlobalRoutes.common,
    src: ImgSrc.asset,
  ),
);

final babyHomeImmunization_ui = HomeImmunizationData(
  action: "Lihat imunisasi Bayi",
  title: "Jangan lupa ikut imunisasi Bayi ya Bun",
  img: ImgData(
    link: "bayi_imunisasi.png",
    package: GlobalRoutes.common,
    src: ImgSrc.asset,
  ),
);

final babyFormMenuList_ui = List<BabyFormMenuData>.generate(5, (i) => BabyFormMenuData(
  id: i+1,
  year: i+1,
  monthStart: i*12 +1,
  monthEnd: (i+1)*12,
  img: dummyImg
));

/*
final motherImmunizationOverview_ui = UiImmunizationOverview(text: "Yuk cek apakah Bunda sudah mendapatkan semua imunisasi ya Bun", imgLink: "");
final babyImmunizationOverview_ui = UiImmunizationOverview(text: "Yuk cek apakah Bayi sudah mendapatkan semua imunisasi ya Bun", imgLink: "");
 */

final motherImmunizationDetailList_ui = List<UiImmunizationListItem>.generate(
    motherImmunizationDetailList.length,
    (i) => UiImmunizationListItem.fromModelDetail(motherImmunizationDetailList[i])
);
final babyImmunizationDetailList_ui = List<UiImmunizationListItem>.generate(
    babyImmunizationDetailList.length,
    (i) => UiImmunizationListItem.fromModelDetail(babyImmunizationDetailList[i])
);

/*
TODO lanjutkan motherImmunizationGroupList_ui
final motherImmunizationGroupList_ui = List<ImmunizationListGroup>.generate(
    motherImmunizationDetailList.length,
        (i) => ImmunizationListItem.fromModelDetail(motherImmunizationDetailList[i])
);
 */
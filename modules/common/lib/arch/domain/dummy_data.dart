
import 'package:common/arch/data/local/db/app_db.dart';
import 'package:common/arch/data/remote/model/baby_check_form_api_model.dart';
import 'package:common/arch/data/remote/model/kehamilanku_overview_api_model.dart';
import 'package:common/arch/domain/model/_model_template.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/ui/model/home_graph_menu.dart';
import 'package:common/config/routes.dart';
import 'package:common/res/string/_string.dart';
import 'package:common/util/times.dart';
import 'package:common/util/type_util.dart';
import 'package:common/value/const_values.dart';
import 'package:common/value/db_const.dart';
import 'package:core/domain/model/range.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'model/auth.dart';
import 'model/chart_data_baby.dart';
import 'model/chart_data_mother.dart';
import 'model/child.dart';
import 'model/covid_data.dart';
import 'model/education_data.dart';
import 'model/father.dart';
import 'model/form_warning_status.dart';
import 'model/immunization.dart';
import 'model/kehamilanku_data.dart';
import 'model/home_data.dart';
import 'model/mother.dart';
import 'model/notif_data.dart';
import 'model/profile_data.dart';

final _faker = Faker();

final idStringList = List<IdStringModel>.generate(20, (index) => IdStringModel(
  id: index +1100,
  name: _faker.person.name(),
));

final genderSelectionList = <IdStringModel>[
  IdStringModel(id: 0, name: "-"),
  IdStringModel(id: 1, name: Strings.male),
  IdStringModel(id: 2, name: Strings.female),
];

final bloodTypeSelectionList = <IdStringModel>[
  IdStringModel(id: 1, name: "A"),
  IdStringModel(id: 2, name: "B"),
  IdStringModel(id: 3, name: "AB"),
  IdStringModel(id: 4, name: "O"),
];


final appLogoImg = ImgData(link: "logo_app_color.png", package: GlobalRoutes.common, src: ImgSrc.asset,);
final appLogoImgWhite = ImgData(link: "logo_app_white.png", package: GlobalRoutes.common, src: ImgSrc.asset,);

final imgPregnancyAgeOverview = ImgData(
  link: "kehamilanku_header.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);
final imgBabyAgeOverview = ImgData(
  link: "bayi_header.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);
final imgCovidFormOverview = ImgData(
  link: "covid_inner_header.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);
final imgCovidStatusMother = ImgData(
  link: "covid_mother.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);
final imgCovidStatusBaby = ImgData(
  link: "covid_baby.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);

final imgChartBabyWarning = ImgData(
  link: "bayiku_berat_badan.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);
final imgChartMotherWarning = ImgData(
  link: "mother_panel.png",
  package: GlobalRoutes.common,
  src: ImgSrc.asset,
);

final pregnancyWarningImgList = <String>[
  "kehamilanku_weight.png",
  "kehamilanku_djj.png",
  "kehamilanku_tfu.png",
  "kehamilanku_map.png",
  "kehamilanku_gerakan_bayi.png",
];

final babyWarningImgList = <String>[
  "bayiku_berat_badan.png",
  "bayiku_panjang_badan.png",
  "bayiku_panjang_badan_berat.png",
  "bayiku_lingkar_kepala.png",
  "bayiku_imt.png",
  "bayiku_perkembangan.png",
];

final imgPlaceholder = ImgData(link: "img_placeholder.png", package: GlobalRoutes.common, src: ImgSrc.asset);

final dummyImg = ImgData(link: "", src: ImgSrc.asset,);
final dummyImg_smillingCat = ImgData(link: "_smiling_cat.jpg", package: GlobalRoutes.common, src: ImgSrc.asset,);
final dummyImg_profile_sm = ImgData(link: "pic_profile_example.png", package: GlobalRoutes.common, src: ImgSrc.asset,);
final dummyImg_pick = ImgData(link: "ic_plus_color.png", package: GlobalRoutes.common, src: ImgSrc.asset,);
final dummyImg_profile = ImgData(link: "ic_profile.png", package: GlobalRoutes.common, src: ImgSrc.asset,);
final dummyImg_profile_preset = ImgData(
  link: "https://cdn.popbela.com/content-images/post/20180626/18095091-1852239135027406-6035530276199727104-n-b2395d94b5924b9c4f5e6a866acf7c99_750x500.jpg",
  src: ImgSrc.network,
);
final dummyImg_babyYellow = ImgData(link: "pic_baby_yellow_part.png", package: GlobalRoutes.bayiku, src: ImgSrc.asset,);

final dummyEmail = "a@a.a";
final dummyName = "ayu";
final dummyPswd = "ayu123";

final dummyMotherNik = "21903193183";
final dummyFatherNik = "82367917";
final dummyChildNik = "182401247";
final dummyChildNik2 = "12081398102";
final dummyChildNik3 = "9018391398";

final dummyAccessToken = "aagajki1831huhf1i38y13";
final dummyAccessTokenType = "Bearer";
final dummySignUpData1 = SignUpData(name: dummyName, email: dummyEmail, password: dummyPswd);
final dummyLoginData1 = LoginData(email: dummySignUpData1.email, password: dummySignUpData1.password, fcmToken: Const.DUMMY_FCM_TOKEN);
final dummySessionData1 = SessionData(token: dummyAccessToken, tokenType: dummyAccessTokenType,);


final dummyFather = Father(
  name: "Pak Jo",
  nik: dummyFatherNik,
  salary: "Asuransi",
  jkn: "JKN Kis 10",
  faskes1: "Kamar rumah",
  faskesRujukan: "Puskesmas 10",
  bloodType: "B",
  birthCity: 1101, //"Jonggol",
  birthDate: "1949-08-17",
  education: "S4",
  occupancy: "Buruh halus",
  address: "Jl. In Aja Dulu",
  phone: "08123123123123",
);

final dummyMother = Mother(
  name: "Bu Lan",
  nik: dummyMotherNik,
  salary: "Auransi",
  jkn: "JKN Kis 11",
  faskes1: "Kamar rumah",
  faskesRujukan: "Puskesmas 10",
  bloodType: "A",
  birthCity: 1101, //"Konoha",
  birthDate: "1973-06-06",
  education: "SD",
  occupancy: "Ibu aja",
  address: "Jl. In Aja Dulu",
  phone: "08123456789",
  puskesmasDomisili: "Puskesmas 11",
  cohortRegistNo: "12312345",
);
final dummyMotherHpl = DateTime(2021);
final dummyMotherHpht = DateTime(2020);

final dummyChild = Child(
  name: "Anak sinkong",
  childOrder: 1,
  gender: "M",
  nik: dummyChildNik,
  bloodType: "O",
  birthCity: 1101, //"Asgard",
  birthDate: "1999-07-12",
  jkn: "JKN a",
  jknStartDate: "2021-10-10",
  babyCohortRegistNo: "12381927921",
  toddlerCohortRegistNo: "123121424",
  hospitalMedicalNumber: "12312412412412",
  birthCertificateNo: "12123124",
);
final dummyChild2 = Child(
  name: "Anak jagung",
  childOrder: 2,
  gender: "M",
  nik: dummyChildNik2,
  bloodType: "O",
  birthCity: 1101, //"Asgard",
  birthDate: "2002-07-12",
  jkn: "JKN a",
  jknStartDate: "2021-10-10",
  babyCohortRegistNo: "12381927921",
  toddlerCohortRegistNo: "123121424",
  hospitalMedicalNumber: "12312412412412",
  birthCertificateNo: "12123124",
);
final dummyChild3 = Child(
  name: "Anak pohong",
  childOrder: 3,
  gender: "M",
  nik: dummyChildNik3,
  bloodType: "O",
  birthCity: 1101, //"Asgard",
  birthDate: "2020-07-12",
  jkn: "JKN a",
  jknStartDate: "2021-10-10",
  babyCohortRegistNo: "12381927921",
  toddlerCohortRegistNo: "123121424",
  hospitalMedicalNumber: "12312412412412",
  birthCertificateNo: "12123124",
);
final dummyChild4 = Child(
  name: "Msh bayi",
  childOrder: 3,
  gender: "M",
  nik: '',
  bloodType: "O",
  birthCity: 1101, //"Asgard",
  birthDate: "2021-07-12",
  jkn: "JKN a",
  jknStartDate: "2021-10-10",
  babyCohortRegistNo: "12381927921",
  toddlerCohortRegistNo: "123121424",
  hospitalMedicalNumber: "12312412412412",
  birthCertificateNo: "12123124",
);


final dummyPregnancyAgeOverview = MotherPregnancyAgeOverview(
  weekAge: 2,
  daysRemaining: 256,
  img: dummyImg,
);
final dummyBabyAgeOverview = BabyAgeOverview(
  desc: "10 Hari",
  img: imgBabyAgeOverview
);


/*
=====================
Kehamilanku
=====================
 */
PregnancyCheck dummyPregnancyCheck(int week) => PregnancyCheck(
  id: 1,
  visitDate: "2021-10-06",
  visitPlace: "Surabaya",
  checkerName: "Suster Ami",
  difficulty: "Boyok",
  pregnancyAge: week,
  babyGender: "L",
  futureVisitDate: "2021-10-13",
  HPHT: "2020-10-10",
  HPL: "2021-12-10",
  motherWeigth: 100,
  motherWeigthDiff: 10,
  motherHeight: 120,
  TFU: 10,
  DJJ: 100,
  systolicPressure: 110,
  diastolicPressure: 70,
  MAP: 120,
  babyMovement: 10,
  drugPrescript: 'Paracetamol',
  drugAllergy: "-",
  diseaseHistory: "-",
  note: "-",
);

final babyMonthlyFormBody = BabyMonthlyFormBody(
  id: null,
  yearId: 1,
  month: 3,
  date: "2021-10-10",
  location: "ITS",
  checker: "Pak yo",
  age: 10,
  weight: 14,
  height: 12,
  headCircum: 15,
  bmi: 10,
  perkembangan_ans: [],
);

final dummyTrimesterList = <MotherTrimester>[
  MotherTrimester(id: 1, trimester: 1, startWeek: 0, endWeek: 12, img: dummyImg,),
  MotherTrimester(id: 2, trimester: 2, startWeek: 13, endWeek: 24, img: dummyImg,),
  MotherTrimester(id: 3, trimester: 3, startWeek: 25, endWeek: 40, img: dummyImg,),
];

List<MotherFoodRecom> dummyFoodRecomList(int week) => [
  MotherFoodRecom(food: "Beras", desc: "Makan nasi biar kenyang", img: dummyImg), //imgLink: "https://begnimbe.com/wp-content/uploads/2021/03/Buford-FrenchRice.jpg"),
  MotherFoodRecom(food: "Kacang", desc: "Kacang dapat mengenyangkan jika dimakan dalam skala besar", img: dummyImg),//imgLink: "https://www.jessicagavin.com/wp-content/uploads/2020/05/how-to-cook-pinto-beans-6-1200.jpg"),
  MotherFoodRecom(food: "Susu", desc: "Biar pola makan sempurna, minum susu.", img: dummyImg),//imgLink: "https://www2.biomin.net/fileadmin/user_upload/Articles/2019/Boosting_milk_yield/Milk-production-in-heifers-fed-Digestarom-Dairy-increased-by-0.7-kg-per-day.jpg"),
];

final dummyPregnancyBabySizes = <PregnancyBabySize>[
  PregnancyBabySize(sizeString: "Selada Kampung", babyWeight: 18.3, babyLen: 5.1,),
  PregnancyBabySize(sizeString: "Selada Hijau", babyWeight: 28.3, babyLen: 6.1,),
  PregnancyBabySize(sizeString: "Selada Kuning", babyWeight: 58.3, babyLen: 9.1,),
  PregnancyBabySize(sizeString: "Selada Merah", babyWeight: 98.3, babyLen: 19.1,),
];

PregnancyBabySize dummyPregnancyBabySize(int week) => dummyPregnancyBabySizes[week % dummyPregnancyBabySizes.length];

final dummyProfile = Profile(
  id: 1,
  nik: "",
  name: dummyName,
  email: dummyEmail,
  birthDate: DateTime.now(),
  img: dummyImg_profile_sm,
);

final dummyProfileCred = ProfileCredential.fromProfile(dummyProfile);

final dummyStatusList = <HomeStatus>[
  HomeStatus(desc: "Selamat Berat Badan Bunda Normal", img: dummyImg, color: Colors.green,),
  HomeStatus(desc: "Gerakan Anak Bunda Kurang Nih Bun!", img: dummyImg, color: Colors.red,),
];

final dummyMenuList = <HomeMenu>[
  HomeMenu(name: Strings.my_pregnancy, moduleName: GlobalRoutes.kehamilanku,
    img: ImgData(link: "menu_kehamilanku.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  ),
  HomeMenu(name: Strings.my_baby, moduleName: GlobalRoutes.bayiku,
    img: ImgData(link: "menu_bayiku.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  ),
  // HomeMenu(name: Strings.covid_19, moduleName: GlobalRoutes.covid19,
  //   img: ImgData(link: "menu_covid19.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  // ),
];

final dummyTipsList = <Tips>[
  Tips(id: 1, title: "Nih Bun 5 Makanan Rekomendasi untuk Bunda Hamil Trimester 2", kind: "Kehamilan", img: dummyImg,),
  Tips(id: 2, title: "Perkembangan Janin Usia 9 Minggu Kehamilan, Yuk Bun Ketahui Selengkapnya!", kind: "Kehamilan", img: dummyImg_smillingCat,),
  Tips(id: 3, title: "Yuk Bun Ketahui Pola Asuh Bayi Baru Lahir Sampai Usia 1,5 Tahun", kind: "Kehamilan", img: dummyImg,),
  Tips(id: 4, title: "Bagaimana Cara Memberikan ASI ke Bayi Baru Lahir 0-28 Hari (Neonatus)?", kind: "Kehamilan", img: dummyImg,),
];

final List<TipsDetail> dummyTipsDetailList = List.generate(dummyTipsList.length, (i) => TipsDetail(
  tips: dummyTipsList[i],
  desc: _faker.lorem.words(700).join(" "),
  date: DateTime.now().add(Duration(days: i)),
));

final dummyNotifList = <HomeNotifMsg>[
  HomeNotifMsg(title: "Selamat Datang di SiBunda", desc: "Satu aplikasi untuk semua tahap kehamilan dan kesehatan bayi bunda, mulai dari usia 0 - 6 tahun", time: DateTime.now(), img: dummyImg,),
  HomeNotifMsg(title: "Sudahkah Anda Mandi?", desc: "Mandi dapat menyegarkan badan", time: DateTime.now(), img: dummyImg,),
  HomeNotifMsg(title: "Tahu kah Anda?", desc: "Minum air 1 liter per hari dapat menghilangkan rasa haus", time: DateTime.now(), img: dummyImg,),
];

final dummyMessageList = <HomeNotifMsg>[
  HomeNotifMsg(title: "Bunda, Pastikan Kehamilan Bunda Sehat Ya", desc: "Jangan lupa untuk periksa rutin ya, serta selalu isikan data perkembangan bunda dan calon buah hati di aplikasi ya.", time: DateTime.now(), img: dummyImg,),
  HomeNotifMsg(title: "Sudahkah Anda Mandi?", desc: "Mandi dapat menyegarkan badan", time: DateTime.now(), img: dummyImg,),
  HomeNotifMsg(title: "Tahu kah Anda?", desc: "Minum air 1 liter per hari dapat menghilangkan rasa haus", time: DateTime.now(), img: dummyImg,),
];


//============ FormWarningStatus ==============

final motherWarningStatusList = <FormWarningStatus>[
  FormWarningStatus(
    desc: "Berat Badan Bunda kurang sesuai ya Bun. ",
    action: "Lihat rekomendasi makanan",
    isSafe: false,
    img: dummyImg,
  ),
  FormWarningStatus(
    desc: "Denyut Jantung Janin Bunda kurang ya. Silahkan periksa ke faskes ya Bun",
    action: "Cari Faskes terdekat",
    isSafe: false,
    img: dummyImg,
  ),
  FormWarningStatus(
    desc: "Selamat Bunda! \nTinggi Fundus Uterus Bunda normal ya Bun.",
    action: "Cari Faskes terdekat",
    isSafe: true,
    img: dummyImg,
  ),
];

final babyWarningStatusList = <FormWarningStatus>[
  FormWarningStatus(
    desc: "Bunda, berat badan bayi tidak normal ya Bun menurut usia bayi.",
    action: "Cari Faskes terdekat",
    isSafe: false,
    img: dummyImg,
  ),
  FormWarningStatus(
    desc: "Selamat Bunda! \n Panjang badan atau tinggi badan menurut usia bayi normal.",
    action: "Cari Faskes terdekat",
    isSafe: true,
    img: dummyImg,
  ),
  FormWarningStatus(
    desc: "Bunda, berat badan bayi menurut panjang/tinggi badan tidak normal.",
    action: "Cari Faskes terdekat",
    isSafe: false,
    img: dummyImg,
  ),
  FormWarningStatus(
    desc: "Warning ini masih dummy dari local ya Bun",
    action: "Hubungi developer terdekat",
    isSafe: false,
    img: dummyImg,
  ),
];

final templateTetanusImmunization = ImmunizationData(
  name: "Tetanus",
  immunizationId: 1,
  occurrenceId: 1,
);

// ========== Immunization ============
final motherImmunizationList = <ImmunizationData>[
  templateTetanusImmunization.copy(occurrenceId: 1, date: "2020-12-13", location: "ITS"),
  templateTetanusImmunization.copy(occurrenceId: 2, date: "2020-12-17", location: "ITS"),
  templateTetanusImmunization.copy(occurrenceId: 3,),
  templateTetanusImmunization.copy(occurrenceId: 4,),
  templateTetanusImmunization.copy(occurrenceId: 5, date: "2020-11-14", location: "Your home"),
  templateTetanusImmunization.copy(occurrenceId: 6,),
];
final babyImmunizationList = <ImmunizationData>[
  ImmunizationData(
    immunizationId: 2,
    occurrenceId: 1,
    name: "Hepatitis B (<24 Jam)", date: "2020-12-13", location: "ITS", batchNo: "001",
  ),
  ImmunizationData(
    immunizationId: 3,
    occurrenceId: 2,
    name: "BCG", date: "2020-12-17", location: "ITS", batchNo: "001",
  ),
  ImmunizationData(
    immunizationId: 4,
    occurrenceId: 3,
    name: "Polio Tetes 1",
  ),
  ImmunizationData(
    immunizationId: 5,
    occurrenceId: 4,
    name: "DPT-HB-Hib 1",
  ),
  ImmunizationData(
    immunizationId: 6,
    occurrenceId: 5,
    name: "Polio Tetes 2", date: "2021-11-14", location: "ITS", batchNo: "001",
  ),
  ImmunizationData(
    immunizationId: 7,
    occurrenceId: 6,
    name: "DPT-HB-Hib 2",
  ),
];

final motherImmunizationDetailList = motherImmunizationList.map((e) => ImmunizationDetail(
  immunization: e,
  noDetail: true,
)).toList(growable: false);
final babyImmunizationDetailList = babyImmunizationList.map((e) => ImmunizationDetail(
  immunization: e,
  monthRange: IntRange(0, 4),
  //batchNo: e.date != null ? "001" : null,
)).toList(growable: false);


final motherImmunizationOverview = ImmunizationOverview(
  text: "Yuk cek apakah Bunda sudah mendapatkan semua imunisasi ya Bun",
  img: ImgData(
    link: "kehamilanku_imunisasi_inner.png",
    package: GlobalRoutes.common,
    src: ImgSrc.asset,
  ),
);
final babyImmunizationOverview = ImmunizationOverview(
  text: "Yuk cek apakah Bayi sudah mendapatkan semua imunisasi ya Bun",
  img: ImgData(
    link: "bayi_imunisasi_inner.png",
    package: GlobalRoutes.common,
    src: ImgSrc.asset,
  ),
);

final motherImmunizationGroupList = <ImmunizationDetailGroup>[
  ImmunizationDetailGroup(
    immunizationList: motherImmunizationDetailList.sublist(0, 2),
    header: "Trimester 1",
  ),
  ImmunizationDetailGroup(
    immunizationList: motherImmunizationDetailList.sublist(2, 4),
    header: "Trimester 2",
  ),
  ImmunizationDetailGroup(
    immunizationList: motherImmunizationDetailList.sublist(4, 6),
    header: "Trimester 3",
  ),
];

final babyImmunizationGroupList = <ImmunizationDetailGroup>[
  ImmunizationDetailGroup(
    immunizationList: babyImmunizationDetailList.sublist(0, 2),
    header: "Bulan ke 0 - 2",
  ),
  ImmunizationDetailGroup(
    immunizationList: babyImmunizationDetailList.sublist(2, 4),
    header: "Bulan ke 3 - 4",
  ),
  ImmunizationDetailGroup(
    immunizationList: babyImmunizationDetailList.sublist(4, 6),
    header: "Bulan ke 5 - 20++",
  ),
];

final dummyMotherImmunizationFill = ImmunizationFill(
  responsibleName: "Pak Ijo",
  date: "2020-07-08",
  place: "ITS",
);
final dummyBabyImmunizationFill = ImmunizationFill(
  responsibleName: "Pak Dasteen",
  date: "2020-07-08",
  place: "Ruang rapat",
  noBatch: "10 a",
);

final pregnancyHomeGraphMenu = <HomeGraphMenu>[
  HomeGraphMenu(name: "Grafik Evaluasi Kehamilan",
    img: ImgData(link: "kehamilanku_grafik_1.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  ),
  HomeGraphMenu(name: "Grafik Berat Badan",
    img: ImgData(link: "kehamilanku_grafik_2.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  ),
];

final babyHomeGraphMenu = <HomeGraphMenu>[
  HomeGraphMenu(name: "Pertumbuhan Bayi",
    img: ImgData(link: "bayi_grafik_1.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  ),
  HomeGraphMenu(name: "Perkembangan Bayi",
    img: ImgData(link: "bayi_grafik_2.png", package: GlobalRoutes.common, src: ImgSrc.asset,),
  ),
];

final covidHomeOverview = CovidHomeOverview(
  title: "Bunda, jangan lupa tetap jaga kesehatan Bunda dan si Kecil ya",
  img: ImgData(
    link: "covid_header.png",
    package: GlobalRoutes.common,
    src: ImgSrc.asset,
  ),
);

final covidHomeMenu = <HomeGraphMenu>[
  HomeGraphMenu(
    name: "Cek Covid-19 untuk Bayi",
    img: ImgData(
      link: "covid_form_bayi.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  HomeGraphMenu(
    name: "Cek Covid-19 untuk Bunda",
    img: ImgData(
      link: "covid_form_bunda.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
];

final covidHomeCheckHistory = <CovidCheckHistory>[
  CovidCheckHistory(
    date: DateTime.parse("2020-01-12"), //"12 Januari 2020",
    person: "Bayi",
    img: dummyImg,
    desc: "Terindaksi normal",
    longDesc: "Ini desc panjang",
    isNormal: true,
  ),
  CovidCheckHistory(
    date: DateTime.parse("2020-01-12"), //"12 Januari 2020",
    person: "Bunda",
    img: dummyImg,
    desc: "Terindaksi PDP",
    longDesc: "Ini desc panjang",
    isNormal: false,
  ),
];


final motherHomeData = List<MotherHomeBabyData>.generate(3, (i) => MotherHomeBabyData(
  babyId: i+1,
  babyName: _faker.person.name(),
  childOrder: i+1,
  pregnancyAge: MotherPregnancyAgeOverview(
    weekAge: i+1,
    daysRemaining: i+3,
    img: imgPregnancyAgeOverview,
  ),
  foodRecomList: dummyFoodRecomList(i+1),
  trimesterList: dummyTrimesterList,
));


final motherPregEvalGraphMenuList = <MotherChartMenuData>[
  MotherChartMenuData(
    title: "Grafik Tinggi Fundus Uterus",
    type: MotherChartType.tfu,
    img: ImgData(
      link: "kehamilanku_tfu.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  MotherChartMenuData(
    title: "Grafik Denyut Jantung Janin",
    type: MotherChartType.djj,
    img: ImgData(
      link: "kehamilanku_djj.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  MotherChartMenuData(
    title: "Grafik Denyut Nadi Bunda",
    type: MotherChartType.map,
    img: ImgData(
      link: "kehamilanku_map.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
];

final motherWeightGraphMenuList = <MotherChartMenuData>[
  MotherChartMenuData(title: "Grafik Peningkatan Berat Badan", img: dummyImg, type: MotherChartType.bmi),
];


final babyGrowthGraphMenuList = <BabyChartMenuData>[
  BabyChartMenuData(title: "Grafik KMS", type: BabyChartType.kms,
    img: ImgData(
      link: "bayi_grafik_kms.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  BabyChartMenuData(title: "Grafik Berat Badan Menurut Umur", type: BabyChartType.weight,
    img: ImgData(
      link: "bayi_grafik_berat_badan_umur.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  BabyChartMenuData(title: "Grafik Panjang Badan Menurut Umur", type: BabyChartType.len,
    img: ImgData(
      link: "bayi_grafik_panjang_badan_umur.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  BabyChartMenuData(title: "Grafik Berat Badan Menurut Panjang Badan", type: BabyChartType.weightToLen,
    img: ImgData(
      link: "bayi_grafik_berat_badan_panjang_badan.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  BabyChartMenuData(title: "Grafik Lingkar Kepala", type: BabyChartType.head,
    img: ImgData(
      link: "bayi_grafik_lingkar_kepala_imt.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
  BabyChartMenuData(title: "Grafik Indeks Massa Tubuh", type: BabyChartType.bmi,
    img: ImgData(
      link: "bayi_grafik_lingkar_kepala_imt.png",
      package: GlobalRoutes.common,
      src: ImgSrc.asset,
    ),
  ),
];

final babyDevGraphMenuList = <BabyChartMenuData>[
  BabyChartMenuData(title: "Grafik Perkembangan Bayi", img: dummyImg, type: BabyChartType.dev),
];


final babyGrowthCheck = BabyGrowthCheck(
  date: "1987-09-09",
  location: "ITS",
  age: 10,
  weight: 10,
  height: 11,
  headCircum: 12,
  bmi: 13,
  checkerName: "Dokter dia",
);

final neonatal6HourForm = Neonatal6HourForm(
  weight: 10,
  height: 120,
  headCircum: 10,
  q_imd: 1,
  q_vit_k1: 0,
  q_salep: 1,
  q_imunisasi_hb: 1,
  date: "2020-03-09",
  time: "10:10",
  no_batch: "80123456789",
  dirujuk_ke: "Dokter",
  petugas: "Perawat",
  catatan_penting: "Gakda",
);
Future<bool> Function(int groupPosition, String inputKey, dynamic response) neonatal6HourFormValidator({
  Future<bool> Function(int groupPosition, String inputKey, dynamic response)? defaultValidator,
}) => (groupPosition, inputKey, response) async {
  switch(inputKey) {
    case Const.KEY_WEIGHT:
    case Const.KEY_HEIGHT:
    case Const.KEY_HEAD_CIRCUM: return tryParseNum(response) != null;
/*
    case "q_imd":
    case "q_vit_k1":
    case "q_salep":
    case "q_imunisasi_hb": return tryParseInt(response) != null;
 */
  }
  return await defaultValidator?.call(groupPosition, inputKey, response) ?? true;
};

//Future<bool> validateField(int groupPosition, String inputKey, response)


final neonatalKn1Form = NeonatalKn1Form(
  q_menyusu: 1,
  q_tali_pusat: 0,
  q_vit_k1: 0,
  q_salep: 0,
  q_imunisasi_hb: 0,
  q_skrining_hipotiroid_kongenital: 0,
  date: "1798-03-02",
  time: "10:11",
  no_batch: "91037192",
  weight: 10,
  height: 10,
  headCircum: 30,
  dirujuk_ke: "Rumah bersalin",
  petugas: "Dia",
  catatan_penting: "Gakda",
  masalah: "Banyak",
);
Future<bool> Function(int groupPosition, String inputKey, dynamic response) neonatalKn1FormValidator({
  Future<bool> Function(int groupPosition, String inputKey, dynamic response)? defaultValidator,
}) => (groupPosition, inputKey, response) async {
  switch(inputKey) {
    case Const.KEY_WEIGHT:
    case Const.KEY_HEIGHT:
    case Const.KEY_HEAD_CIRCUM: return tryParseNum(response) != null;
/*
    case "q_menyusu":
    case "q_tali_pusat":
    case "q_vit_k1":
    case "q_salep":
    case "q_imunisasi_hb":
    case "q_skrining_hipotiroid_kongenital": return tryParseInt(response) != null;
 */
  }
  return await defaultValidator?.call(groupPosition, inputKey, response) ?? true;
};

final neonatalKn2Form = NeonatalKn2Form(
  q_menyusu: 1,
  q_tali_pusat: 0,
  q_tanda_bahaya: 0,
  q_identifikasi_kuning: 0,
  q_imunisasi_hb: 0,
  q_skrining_hipotiroid_kongenital: 0,
  date: "1798-03-02",
  time: "10:11",
  no_batch: "91037192",
  weight: 10,
  height: 10,
  headCircum: 30,
  dirujuk_ke: "Rumah bersalin",
  petugas: "Dia",
  catatan_penting: "Gakda",
  masalah: "Banyak",
);
Future<bool> Function(int groupPosition, String inputKey, dynamic response) neonatalKn2FormValidator({
  Future<bool> Function(int groupPosition, String inputKey, dynamic response)? defaultValidator,
}) => (groupPosition, inputKey, response) async {
  switch(inputKey) {
    case Const.KEY_WEIGHT:
    case Const.KEY_HEIGHT:
    case Const.KEY_HEAD_CIRCUM: return tryParseNum(response) != null;
/*
    case "q_menyusu":
    case "q_tali_pusat":
    case "q_tanda_bahaya":
    case "q_identifikasi_kuning":
    case "q_imunisasi_hb":
    case "q_skrining_hipotiroid_kongenital": return tryParseInt(response) != null;
 */
  }
  return await defaultValidator?.call(groupPosition, inputKey, response) ?? true;
};

final neonatalKn3Form = NeonatalKn3Form(
  q_menyusu: 1,
  q_tali_pusat: 0,
  q_tanda_bahaya: 0,
  q_identifikasi_kuning: 0,
  q_imunisasi_hb: 0,
  q_kuning1: 1,
  q_kuning2: 1,
  q_kuning3: 1,
  q_kuning4: 1,
  q_kuning5: 1,
  dirujuk_ke: "Rumah panti",
  petugas: "Kamu",
  catatan_penting: "Itu",
  masalah: "Banyak",
);
Future<bool> Function(int groupPosition, String inputKey, dynamic response) neonatalKn3FormValidator({
  Future<bool> Function(int groupPosition, String inputKey, dynamic response)? defaultValidator,
}) => (groupPosition, inputKey, response) async {
/*
  switch(inputKey) {
    case "q_menyusu":
    case "q_tali_pusat":
    case "q_tanda_bahaya":
    case "q_identifikasi_kuning":
    case "q_imunisasi_hb": return tryParseInt(response) != null;
  }
 */
  return await defaultValidator?.call(groupPosition, inputKey, response) ?? true;
};

final dummyWarningAction = "Cari faskes terdekat";

final dummyCovidCheckResult_mother = FormWarningStatus(
  desc: "Bunda, dari hasil form, bunda masuk kategori Pasien Dalam Pengawasan",
  action: dummyWarningAction,
  isSafe: false,
  img: imgPregnancyAgeOverview,
);
final dummyCovidCheckResult_baby = FormWarningStatus(
  desc: "Bunda, dari hasil form, bayi bunda masuk kategori Pasien Dalam Pengawasan",
  action: dummyWarningAction,
  isSafe: false,
  img: imgBabyAgeOverview,
);



// ============ entity ===========
final userRoles = <RoleEntity>[
  RoleEntity(id: DbConst.ROLE_ADMIN, name: "Admin"),
  RoleEntity(id: DbConst.ROLE_USER, name: "User"),
];
final profileTypes = <ProfileTypeEntity>[
  ProfileTypeEntity(id: DbConst.TYPE_MOTHER, name: "Ibu"),
  ProfileTypeEntity(id: DbConst.TYPE_FATHER, name: "Ayah"),
  ProfileTypeEntity(id: DbConst.TYPE_CHILD, name: "Anak"),
];
final dummyCities = List<CityEntity>.generate(20, (i) => CityEntity(
  id: i+1,
  name: _faker.person.name(),
));

final dummyCredential = CredentialEntity(
  id: 1,
  name: "Ayu", //_faker.person.name(),
  email: dummyEmail,
  role: userRoles[1].id,
);


final dummyProfileMother = ProfileEntity(
  userId: dummyCredential.id,
  type: DbConst.TYPE_MOTHER,
  serverId: 1,
  name: dummyCredential.name,
  birthDate: DateTime.now(),
  birthPlace: 1,
  nik: dummyMotherNik,
);
final dummyProfileMother_domain = Profile.fromEntity(
  entity: dummyProfileMother,
  email: dummyCredential.email,
);
final dummyProfileFather = ProfileEntity(
  userId: dummyCredential.id,
  type: DbConst.TYPE_FATHER,
  serverId: 2,
  name: _faker.person.name(),
  birthDate: DateTime.now(),
  birthPlace: 1,
  nik: dummyFatherNik,
);
final dummyProfileFather_domain = Profile.fromEntity(
  entity: dummyProfileFather,
  email: dummyCredential.email,
);
final dummyProfileChild = ProfileEntity(
  userId: dummyCredential.id,
  type: DbConst.TYPE_CHILD,
  serverId: 3,
  name: dummyChild.name,
  birthDate: parseDate(dummyChild.birthDate),
  birthPlace: 1,
  nik: dummyChild.nik,
);
final dummyProfileChild_domain = Profile.fromEntity(
  entity: dummyProfileChild,
  email: dummyCredential.email,
);
final dummyProfileChild2 = ProfileEntity(
  userId: dummyCredential.id,
  type: DbConst.TYPE_CHILD,
  serverId: 4,
  name: dummyChild2.name,
  birthDate: parseDate(dummyChild2.birthDate),
  birthPlace: 1,
  nik: dummyChild2.nik,
);
final dummyProfileChild2_domain = Profile.fromEntity(
  entity: dummyProfileChild2,
  email: dummyCredential.email,
);
final dummyProfileChild3 = ProfileEntity(
  userId: dummyCredential.id,
  type: DbConst.TYPE_CHILD,
  serverId: 5,
  name: dummyChild3.name,
  birthDate: parseDate(dummyChild3.birthDate),
  birthPlace: 1,
  nik: dummyChild3.nik,
);
final dummyProfileChild3_domain = Profile.fromEntity(
  entity: dummyProfileChild3,
  email: dummyCredential.email,
);
final dummyProfileChild4 = ProfileEntity(
  userId: dummyCredential.id,
  type: DbConst.TYPE_CHILD,
  serverId: 6,
  name: dummyChild4.name,
  birthDate: parseDate(dummyChild4.birthDate),
  birthPlace: 1,
  nik: dummyChild4.nik,
);
final dummyProfileChild4_domain = Profile.fromEntity(
  entity: dummyProfileChild4,
  email: dummyCredential.email,
);


final dummyBatchProfile = BatchProfileServer(
  mother: dummyProfileMother,
  father: dummyProfileFather,
  children: [
    dummyProfileChild,
    dummyProfileChild2,
    dummyProfileChild3,
    dummyProfileChild4,
  ],
  pregnancies: [
    PregnancyEntity(id: 1, credentialId: 1, hpl: DateTime.now()),
  ],
  motherHpl: getHpl(),
);

//============== For UI =============
final dummyChildOverlayData1 = BabyOverlayData(
  id: dummyProfileChild.serverId,
  nik: dummyProfileChild.nik,
  name: dummyProfileChild.name,
  date: dummyProfileChild.birthDate,
  img: dummyImg,
);
final dummyChildOverlayData2 = BabyOverlayData(
  id: dummyProfileChild2.serverId,
  nik: dummyProfileChild2.nik,
  name: dummyProfileChild2.name,
  date: dummyProfileChild2.birthDate,
  img: dummyImg,
);
final dummyChildOverlayData3 = BabyOverlayData(
  id: dummyProfileChild3.serverId,
  nik: dummyProfileChild3.nik,
  name: dummyProfileChild3.name,
  date: dummyProfileChild3.birthDate,
  img: dummyImg,
);
final dummyChildOverlayData4 = BabyOverlayData(
  id: dummyProfileChild4.serverId,
  nik: dummyProfileChild4.nik,
  name: dummyProfileChild4.name,
  date: dummyProfileChild4.birthDate,
  img: dummyImg,
);

final dummyBabyOverlayDataList_baby = <BabyOverlayData>[
  dummyChildOverlayData1, dummyChildOverlayData2, dummyChildOverlayData3,
];
final dummyBabyOverlayDataList_pregnancy = <BabyOverlayData>[
  dummyChildOverlayData4,
];

final dummyBabyOverlayDataList_all = <BabyOverlayData>[
  ...dummyBabyOverlayDataList_baby,
  ...dummyBabyOverlayDataList_pregnancy,
];
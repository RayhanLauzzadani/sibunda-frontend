
// import 'package:common/res/string/_string.dart';
// import 'package:common/res/theme/_theme.dart';
// import 'package:common/ui/widget/_basic_widget.dart';
// import 'package:sibunda_app/config/routes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:common/util/functions/assets_ext.dart';
// import 'package:flutter/material.dart';
// import 'package:common/util/functions/ui_ext.dart';

// class SplashPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) => Column(
//     //clipBehavior: Clip.none,
//     children: [
//       SibImages.get("ilstr_mother_pregnant_process.png", package: "common", fit: BoxFit.fill)
//           .withMargin(EdgeInsets.symmetric(horizontal: 50).copyWith(top: 70)),
//       Text(
//         Strings.ready_to_be_mother_assistant,
//         style: SibTextStyles.header1,
//       ).withMargin(EdgeInsets.only(top: 50)),
//       Text(
//         Strings.splash_motto_desc,
//         style: SibTextStyles.regular_grey,
//         textAlign: TextAlign.center,
//       ).withMargin(EdgeInsets.only(top: 30)),
//       TxtBtn(
//         Strings.get_started,
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         onTap: () => SibRoutes.signInPage.goToPage(context),
//       ).withMargin(EdgeInsets.only(top: 50)),
//       Text(
//         Strings.not_have_account,
//         style: SibTextStyles.regular_grey,
//         textAlign: TextAlign.center,
//       ).withMargin(EdgeInsets.only(top: 20)),
//       TxtLink(
//         Strings.register_here,
//         onTap: () => SibRoutes.signUpPage.goToPage(context),
//       ).withMargin(EdgeInsets.only(top: 5)),
//     ],
//   );
// }

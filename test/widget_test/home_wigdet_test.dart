import 'package:bayiku/ui/home/baby_home_page.dart';
import 'package:common/arch/ui/adapter/education_adp.dart';
import 'package:common/arch/ui/widget/_items_home.dart';
import 'package:common/arch/ui/widget/custom_bottom_nav_bar.dart';
import 'package:common/arch/ui/widget/custom_top_nav_bar.dart';
import 'package:common/config/keys.dart';
import 'package:common/test/__common_test_const.dart';
import 'package:core/util/_consoles.dart';
import 'package:covid19/ui/home/covid_home_page.dart';
import 'package:education/ui/detail/education_detail_page.dart';
import 'package:education/ui/home/education_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/config/home_key.dart';
import 'package:home/config/home_routes.dart';
import 'package:home/ui/home/home_page.dart';
import 'package:home/ui/home/notif_and_message_page.dart';
import 'package:kehamilanku/ui/home/kehamilanku_home_page.dart';
import 'package:profile/ui/home/profile_home_page.dart';

import '../util/test_util.dart';

void main() {
  TestUtil_Dev.init();
  ConfigUtil.init(isTest: true, isAllOffline: true,);

  WidgetController.hitTestWarningShouldBeFatal = true;
  _menuBtnNavTest();
  _infoNavTest();
  _notifNavTest();
  _profileNavTest();
}

Future<void> _setUpHomePage(WidgetTester tester) async {
  ConfigUtil.initFlutterErrorHandling(isTest: true);
  await tester.pumpWidget(
    defaultTestApp(
      Builder(builder: HomeRoutes.homePage.builder),
    ),
  );
  await tester.pumpAndSettle();
}

_menuBtnNavTest() {
  group("Menu btn nav test group", () {
    tearDown(() {
      TestUtil_Dev.postTestResult();
    });

    testWidgets("Given home page, "
        "When 'kehamilanku' menu button is pressed, "
        "Then `kehamilanku_home_page` is shown.",
    (tester) async {
      await _setUpHomePage(tester);

      final btn = find.byKey(HomeKeys.home_btnMenu_pregnancy).first;
      /*
      final topBar = find.byType(RoundedTopNavBarBg).first;
      final bottomBar = find.byType(BottomNavigationBar).first;
      final menuBtnRect = tester.getRect(btn);
      final topBarRect = tester.getRect(topBar);
      final bottomBarRect = tester.getRect(bottomBar);
      print("menuBtnRect= $menuBtnRect topBarRect= $topBarRect bottomBarRect= $bottomBarRect");
       */

      await tester.tap(btn);

      await tester.pumpAndSettle();

      expect(find.byType(KehamilankuHomePage), findsOneWidget);
    });

    testWidgets("Given home page, "
        "When 'bayiku' menu button is pressed, "
        "Then `bayiku_home_page` is shown.",
    (tester) async {
      await _setUpHomePage(tester);

      final btn = find.byKey(HomeKeys.home_btnMenu_baby).first;
      await tester.tap(btn);

      await tester.pumpAndSettle();

      expect(find.byType(BabyHomePage), findsOneWidget);
    });

    // testWidgets("Given home page, "
    //     "When 'covid-19' menu button is pressed, "
    //     "Then `covid-19_home_page` is shown.",
    // (tester) async {
    //   await _setUpHomePage(tester);
    //
    //   final btn = find.byKey(HomeKeys.home_btnMenu_covid).first;
    //   await tester.tap(btn);
    //
    //   await tester.pumpAndSettle();
    //
    //   expect(find.byType(CovidHomePage), findsOneWidget);
    // });
  });
}

_infoNavTest() {
  group("Info nav test group", () {
    tearDown(() {
      TestUtil_Dev.postTestResult();
    });

    testWidgets("Given home page, "
        "When info menu button is clicked, "
        "Then `info_home_page` is shown.",
      (tester) async {
        await _setUpHomePage(tester);

        final btn = find.byKey(HomeKeys.home_btnInfo_bottom).first;
        /*
        final rect = tester.getRect(btn);
        final scafRect = tester.getRect(find.byType(Scaffold));
        print("rect= $rect scafRect= $scafRect");
         */
        await tester.tap(btn);

        await tester.pumpAndSettle();

        expect(find.byType(EducationHomePage), findsOneWidget);
    });

    testWidgets("Given home page, "
        "When info item is clicked, "
        "Then `detail_page` is shown.",
      (tester) async {
        await _setUpHomePage(tester);

        final btn = find.byKey(CommonKeys.getItemInfoKey(0)).first;
        //final btn2 = find.byKey(CommonKeys.getItemInfoKey(0)).evaluate().toList();
        final scroll = find.byType(CustomScrollView).first;
        //final tipsList = find.byType(TipsSliverList).first.evaluate().first;
        //print("(tipsList.widget as TipsSliverList).onItemClick = ${(tipsList.widget as TipsSliverList).onItemClick}");

        final btnRect = tester.getRect(btn);

        /*
        final scroll2 = find.byType(CustomScrollView).evaluate().toList();
        final scroll3 = find.byType(Scrollable).evaluate().toList();
        print("scroll2= ${scroll2.single} scroll3= $scroll3 scroll3.size = ${scroll3.length}");
         */
        //await tester.ensureVisible(btn);
        /*
        final dragGesture = await tester.startGesture(Offset(0, 500));
        await dragGesture.moveBy(Offset(0, -300));
        await dragGesture.up();
         */
        await tester.dragFrom(Offset(0, 500), Offset(0, -300));
        await tester.pumpAndSettle();

        final btnRect2 = tester.getRect(btn);
        final scrollRect = tester.getRect(scroll);
        /*
        final x = (btnRect2.right + btnRect2.left) /2;
        final y = (btnRect2.bottom + btnRect2.top) /2;
        print("x= $x y= $y");
        final tapGesture = await tester.startGesture(Offset(x, y));
        await tapGesture.up();
         */

        final topBar = find.byType(RoundedTopNavBarBg).first;
        final bottomBar = find.byType(BottomNavigationBar).first;

        final menuBtn = find.byKey(HomeKeys.home_btnMenu_pregnancy).first;

        final menuBtnRect = tester.getRect(menuBtn);
        final topBarRect = tester.getRect(topBar);
        final bottomBarRect = tester.getRect(bottomBar);
        print("topBarRect= $topBarRect bottomBarRect= $bottomBarRect menuBtnRect= $menuBtnRect");

        print("btnRect= $btnRect btnRect2= $btnRect2 scrollRect= $scrollRect");
        //await tester.dragUntilVisible(btn, scroll, Offset(0, -10),);

        expect(btn, findsOneWidget);

        await tester.tap(btn);

        await tester.pumpAndSettle();

        final list = find.byType(HomePage).evaluate().toList();
        print("page list= $list");

        expect(find.byType(EducationDetailPage), findsOneWidget);
    });
  });
}

_notifNavTest() {
  group("Notification nav test group", () {
    tearDown(() {
      TestUtil_Dev.postTestResult();
    });

    testWidgets("Given home page, "
        "When notification button is clicked, "
        "Then `notif_page` is shown.",
      (tester) async {
        await _setUpHomePage(tester);

        final btn = find.byKey(HomeKeys.home_btnNotif).first;
        await tester.tap(btn);

        await tester.pumpAndSettle();

        /*
        final list = find.byType(HomePage).evaluate().toList();
        print("page list2= $list");
         */

        expect(find.byType(HomeNotifAndMessagePage), findsOneWidget);
    });
  });
}

_profileNavTest() {
  group("Profile nav test group", () {
    tearDown(() {
      TestUtil_Dev.postTestResult();
    });

    testWidgets("Given home page, "
        "When profile photo is clicked, "
        "Then `profile_home_page` is shown.",
      (tester) async {
        await _setUpHomePage(tester);

        final btn = find.byKey(HomeKeys.home_btnProfile_top).first;
        await tester.tap(btn);

        await tester.pumpAndSettle();

        /*
        final list = find.byType(HomePage).evaluate().toList();
        print("page list2= $list");
         */

        expect(find.byType(ProfileHomePage), findsOneWidget);
    });
    testWidgets("Given home page, "
        "When profile button in bottom nav bar is clicked, "
        "Then `profile_home_page` is shown.",
      (tester) async {
        await _setUpHomePage(tester);

        final btnFinder = find.byType(BottomNavigationBar).first;
        expect(btnFinder, findsOneWidget);

        final btn = btnFinder.evaluate().single.widget as BottomNavigationBar;

        btn.onTap!(1);
        await tester.pumpAndSettle();

        /*
        final list = find.byType(HomePage).evaluate().toList();
        print("page list2= $list");
         */

        expect(find.byType(ProfileHomePage), findsOneWidget);
    });
  });
}
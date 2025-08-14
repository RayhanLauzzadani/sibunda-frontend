
import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/education_data.dart';
import 'package:common/arch/domain/model/home_data.dart';
import 'package:common/arch/domain/model/profile_data.dart';
import 'package:common/arch/ui/adapter/education_adp.dart';
import 'package:common/arch/ui/page/secondary_frames.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/_item_template.dart';
import 'package:common/arch/ui/widget/_items_home.dart';
import 'package:common/arch/ui/widget/custom_bottom_nav_bar.dart';
import 'package:common/arch/ui/widget/popup_widget.dart';
import 'package:common/config/_config.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/util/assets.dart';
import 'package:core/ui/base/async_view_model_observer.dart';
import 'package:core/ui/base/live_data_observer.dart';
import 'package:core/ui/base/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/config/home_key.dart';
import 'package:home/config/home_routes.dart';
import 'package:home/ui/home/home_vm.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final vm = ViewModelProvider.of<HomeVm>(context)
      ..getProfile()
      ..getStatusList()
      ..getMenuList()
      ..getTipsList();

    final actionBtnChild = InkWell(
      key: HomeKeys.home_btnNotif,
      onTap: () => HomeRoutes.homeNotifAndMessagePage.goToPage(context),
      child: Icon(
        Icons.notifications_none_rounded,
        color: Colors.white,
        size: 40,
      ),
    );

    final profileWidget = Align(
      alignment: Alignment.centerLeft,
      child: LiveDataObserver<Profile>(
        liveData: vm.profile,
        builder: (ctx, data) => data != null
            ? InkWell(
              key: HomeKeys.home_btnProfile_top,
              child: ItemProfile.fromData(data),
              onTap: () => HomeRoutes.obj.goToModule(context, GlobalRoutes.profile),
            ) : defaultLoading(),
      ),
    );

    return TopBarPlainFrame(
      withTopOffset: true,
      bgColor: grey_calmer,
      topBarChildren: [
        profileWidget,
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(top: 15, right: 15),
            child: SizedBox(
              width: 50,
              height: 50,
              child: actionBtnChild,
            ),
          ),
        ),
      ],
      body: BelowTopBarScrollContentArea(slivers: [
        SliverList(
          delegate: SliverChildListDelegate.fixed([
            LiveDataObserver<List<HomeStatus>>(
              liveData: vm.homeStatusList,
              builder: (ctx, data) {
                if(data == null) return defaultLoading();
                if(data.isEmpty) return defaultEmptyWidget();
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 20, top: 30),
                      child: Text(
                        "Yuk Lihat Kesehatan Keluarga",
                        style: SibTextStyles.size_0_bold,
                      ),
                    ),
                    _StatusList(data),
                    SizedBox(height: 40,),
                  ],
                );
              },
            ),
            LiveDataObserver<List<HomeMenu>>(
              liveData: vm.homeMenuList,
              builder: (ctx, data) {
                if(data == null) return defaultLoading();
                if(data.isEmpty) return defaultEmptyWidget();
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 20,),
                      child: Text(
                        "Jelajahi Menu siBunda",
                        style: SibTextStyles.size_0_bold,
                      ),
                    ),
                    _MenuList(data),
                  ],
                );
              },
            ),
            LiveDataObserver<List<Tips>>(
              liveData: vm.homeTipsList,
              builder: (ctx, data) => data?.isNotEmpty == true ? Container(
                margin: EdgeInsets.only(left: 20, bottom: 20, top: 40,),
                child: Text(
                  "Baca Tips dan Info untuk Bunda",
                  style: SibTextStyles.size_0_bold,
                ),
              ) : defaultEmptyWidget(),
            )
          ]),
        ),
        LiveDataObserver<List<Tips>>(
          liveData: vm.homeTipsList,
          initBuilder: (ctx) => SliverToBoxAdapter(child: defaultLoading()),
          builder: (ctx, data) => TipsSliverList(
            data ?? List.empty(),
            onItemClick: (data) => HomeRoutes.obj.goToExternalRoute(
              context, GlobalRoutes.education_detailPage,
              args: GlobalRoutes.makeEducationDetailPageData(data),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed([
            LiveDataObserver<List<Tips>>(
              liveData: vm.homeTipsList,
              builder: (ctx, data) => data?.isNotEmpty == true ? Column(
                children: [
                  InkWell(
                    key: HomeKeys.home_btnInfo_list,
                    onTap: () => HomeRoutes.obj.goToModule(context, GlobalRoutes.education),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        "Lihat Selengkapnya",
                        style: SibTextStyles.size_min_1_colorPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                ],
              ) : defaultEmptyWidget(),
            ),
          ]),
        ),
      ]),
      bottomBar: MiddleBtnBottomNavBar(
        midBtnKey: HomeKeys.home_btnInfo_bottom,
        midBtnOnClick: () => HomeRoutes.obj.goToModule(context, GlobalRoutes.education),
        midBtnChild: Padding(
          padding: EdgeInsets.all(3),
          child: Column(
            children: [
              Expanded(
                child: SibImages.get("ic_home_mid_btn.png", package: GlobalRoutes.common,),
              ),
              SizedBox(height: 2,),
              Text(
                "Info",
                style: SibTextStyles.size_min_2.copyWith(
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        onTap: (index) {
          if(index == 1) {
            HomeRoutes.obj.goToModule(context, GlobalRoutes.profile,);
          }
        },
        items: [
          BottomNavigationBarItem(
            label: "Beranda",
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: "Profil",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}



class _StatusList extends StatelessWidget {
  final List<HomeStatus> dataList;

  _StatusList(this.dataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataList.length,
        itemBuilder: (ctx, i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ItemDashboardStatus.fromData(dataList[i]),
        ),
      ),
    );
  }
}

class _MenuList extends StatelessWidget {
  final List<HomeMenu> dataList;
  final keyList = <Key>[
    HomeKeys.home_btnMenu_pregnancy,
    HomeKeys.home_btnMenu_baby,
    // HomeKeys.home_btnMenu_covid,
  ];

  _MenuList(this.dataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(dataList.length, (i) {
          final data = dataList[i];
          return ItemDashboardMenu.fromData(
            data,
            onClick: () => HomeRoutes.obj.goToModule(context, data.moduleName),
            key: keyList[i % keyList.length],
          );
        }
      ),),
    );
  }
}
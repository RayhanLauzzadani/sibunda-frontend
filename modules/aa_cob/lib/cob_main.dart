/// This is just experimental file
///
import 'package:aa_cob/cob_fields.dart';
import 'package:aa_cob/cob_widget.dart';
import 'package:common/arch/data/local/dao/data_dao.dart';
import 'package:common/arch/data/local/db/app_db.dart';
import 'package:common/arch/data/local/db/executor/shared.dart';
import 'package:common/arch/data/remote/api/data_api.dart';
import 'package:common/arch/di/db_di.dart';
import 'package:common/arch/domain/dummy_data.dart';
import 'package:common/arch/domain/model/_model_template.dart';
import 'package:common/arch/domain/model/baby_data.dart';
import 'package:common/arch/domain/model/form_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/ui/adapter/child_overlay_adp.dart';
import 'package:common/arch/ui/model/form_data.dart';
import 'package:common/arch/ui/page/secondary_frames.dart';
import 'package:common/arch/ui/vm/form_vm_group.dart';
import 'package:common/arch/ui/widget/_basic_widget.dart';
import 'package:common/arch/ui/widget/_items_education.dart';
import 'package:common/arch/ui/widget/_items_kehamilanku.dart';
import 'package:common/arch/ui/widget/form_generic_group.dart';
import 'package:common/arch/ui/widget/form_generic_vm_group_observer.dart';
import 'package:common/arch/ui/widget/img_widget.dart';
import 'package:common/arch/ui/widget/overlay_widget.dart';
import 'package:common/arch/ui/widget/popup_widget.dart';
import 'package:common/arch/ui/widget/splash_widget.dart';
import 'package:common/arch/ui/widget/txt_suffix_icon.dart';
import 'package:common/config/_config.dart';
import 'package:common/res/theme/_theme.dart';
import 'package:common/test/__common_test_const.dart';
import 'package:common/util/assets.dart';
import 'package:common/util/navigations.dart';
import 'package:common/util/ui.dart';
import 'package:core/domain/model/result.dart';
import 'package:core/ui/base/live_data.dart';
import 'package:core/ui/base/live_data_observer.dart';
import 'package:core/ui/base/view_model.dart';
import 'package:core/util/_consoles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
/*
  await initializeDateFormatting("id_ID");
  //await TestUtil.nukeDb();
  await ConfigUtil.init();
  //await DbDi.db.reset();
/*
  final res = await DbDi.db.getAllTableName();
  res.forEach((e) {
    prin("e.data = ${e}");
  });
 */
  //await destroyDb(logStatements: true);
  //await DbDi.db.reset();
  await ConfigUtil.init();
// */
  //await DbDi.db.deleteAllTable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final visibility = MutableLiveData(true);
  final bornBabyList = MutableLiveData<List<BabyOverlayData>>();
  final unbornBabyList = MutableLiveData<List<BabyOverlayData>>();

  @override
  Widget build(BuildContext context) {
/*
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.visitChildElements((e) {
        prind("context.visitChildElements e= $e type= ${e.runtimeType}");
      });
    });
 */
    //final db = constructDb();

    //final cityDao = db.cityDao;

    final txtC = TextEditingController();

    _resetBabyOverlayData();

    return MaterialApp(
      title: 'Flutter Cob',
      theme: Manifest.theme.materialData,
      home: Scaffold(
        body: Builder(
          builder: (ctx) {
            final url = "https://i.imgflip.com/qk533.jpg";
            final svgUrl =
                "https://www.babycenter.com/ims/2019/04/8-weeks-fruit-fetus-size-01.svg";
            final img = ImgData(
              src: ImgSrc.asset,
              link: svgUrl,
              // isLocal: false,
            );
            prind("cob main img= $img");
            return SibImages.resolve(img);
          },
        ),
      ),
      /*
      home: Scaffold(
        body: Builder(
          builder: (ctx) {
            final cities = DbDi.cityDao.get();
            return FutureBuilder<List<CityEntity>>(
              future: cities,
              builder: (ctx, snap) {
                prind("snap.data = ${snap.data}");
                if(snap.hasData) {
                  return IdStringPopup(
                    dataList: snap.data!.map((e) => IdStringModel(id: e.id, name: e.name)).toList(),
                  );
                } else {
                  return defaultError();
                }
              },
            );
          },
        ),
      ),
       */

      //home: Scaffold(body: _Splash2(),),
/*
      home: Scaffold(
        body: Builder(
          builder: (ctx) {
            final list = DbDi.cityDao.get();
            return FutureBuilder<List<CityEntity>>(
              future: list,
              builder: (ctx, snapshot) {
                if(snapshot.hasData) {
                  return Text("data len = ${snapshot.data?.length} \n"
                      "data = ${snapshot.data}");
                }
                return defaultNoData();
              },
            );
          },
        ),
      ),
 */
/*
      home: Scaffold(
        body: Builder(
          builder: (ctx) => CobFieldFaker(
            child: Column(
              children: [
                CobField(),
                SibImages.resolve(dummyImg_smillingCat),
                CobField(),
              ],
            ),
          ),
        ),
      ),
// */
/*
      home: Scaffold(
        body: Builder(
          builder: (ctx) => TopBarTitleAndBackFrame(
            withTopOffset: true,
            title: "Haloa",
            topBarChild: BabyOverlayControlBtn(
              text: "Tekan aku",
              visibilityController: visibility,
              onClick: (isVisible) {
                if(isVisible) {
                  _resetBabyOverlayData();
                }
              },
            ),
            contentOverlay: Stack(
              children: [
                BabySelectionOverlay(
                  visibilityController: visibility,
                  onCancel: () => showSnackBar(ctx, "Cancel overlay"),
                  onItemClick: (data, isBorn) => showSnackBar(ctx, "Bayi = ${data.name} isBorn = $isBorn"),
                  bornBabyList:  bornBabyList,
                  unbornBabyList: unbornBabyList,
                ),
/*
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () => visibility.value = visibility.value != true,
                    child: Text("Tekan"),
                  ),
                ),
 */
              ],
            ),
            body: BelowTopBarScrollContentArea(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (ctx, i) => ListTile(
                        title: Text("Halio $i"),
                        subtitle: Text("Sub $i", style: SibTextStyles.size_0_colorPrimary,),
                      ),
                    childCount: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
// */
/*
      home: Scaffold(
        body: Builder(
          builder: (ctx) => IdStringPopup(
            dataList: idStringList,
            onItemClick: (id, name) => showSnackBar(ctx, "id = $id name = $name"),
          ),
        ),
      ),
// */

      //_FormPage(),
      /*
      home: Scaffold(
        body: Column(
          children: [
            ItemTipsHeaderPanel(
              img: ImgData(
                link: "smiling_cat.jpg",
                package: "aa_cob",
                isLocal: true,
              ),
              kind: "Halo",
              headline: "Nih Bun 5 Makanan Rekomendasi untuk Bunda Hamil Trimester 2",  //afafijaoiga agiuoigaja afjaifan gagi",
            ),

            TextField(
              keyboardType: TextInputType.emailAddress,
/*
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
 */
            ),
            SizedBox(height: 10,),
            FormVmGroupObserver<_Vm>(
              vm: _Vm()..init(),
              submitBtnBuilder: (ctx, canProceed) => TxtBtn(
                "Kirim",
                color: canProceed == true ? Manifest.theme.colorPrimary : grey,
              ),
            ),
          ],
        ),
      ),
       */
    );
  }

  void _resetBabyOverlayData() {
    bornBabyList.value = null;
    unbornBabyList.value = null;
    Future.delayed(Duration(seconds: 5), () {
      bornBabyList.value = [
        ...dummyBabyOverlayDataList_baby,
        ...dummyBabyOverlayDataList_baby,
      ];
      unbornBabyList.value = [
        ...dummyBabyOverlayDataList_pregnancy,
        //...dummyBabyOverlayDataList_pregnancy
      ];
    });
  }
}

class _SplashPage extends StatelessWidget {
  final CityDao cityDao;
  _SplashPage(this.cityDao);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      child: Center(
        child: Column(
          children: [
            FlutterLogo(
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Ini SPlash screen"),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
      pageBuilder: (ctx) => Scaffold(
        body: SizedBox(
          height: 300,
          child: _CityList(cityDao),
        ),
      ),
      computation: () async {
        final api = DataApi(await TestUtil.getDummySession());
        final resp = await api.getCity();

        final ent = resp
            .map((e) => e.toEntityJson())
            .map((e) => CityEntity.fromJson(e))
            .toList(growable: false);
        cityDao.insertAll(ent);
      },
    );
  }
}

class _CityList extends StatelessWidget {
  final CityDao dao;
  _CityList(this.dao);

  @override
  Widget build(BuildContext context) {
    final citiesFuture = dao.get(limit: 20);
    return FutureBuilder<List<CityEntity>>(
      future: citiesFuture,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          final cities = snapshot.data;
          return ListView.builder(
            itemCount: cities?.length ?? 0,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(cities![i].name),
              subtitle: Text(cities[i].id.toString()),
            ),
          );
        }
        return defaultLoading();
      },
    );
  }
}

class _FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ViewModelProvider(
          creators: [
            (ctx) => _Vm()..init(),
          ],
          child: FormVmGroupObserver<_Vm>(
            submitBtnBuilder: (ctx, canProceed) => TxtBtn(
              "Kirim",
              color: canProceed == true ? Manifest.theme.colorPrimary : grey,
            ),
          ),
        ),
      ),
    );
  }
}

class _Vm extends FormVmGroup {
  @override
  Future<Result<String>> doSubmitJob() async => Success("ok");

  @override
  Future<List<FormUiGroupData>> getFieldGroupList() async => [
        FormUiGroupData(
          header: "header",
          data: [
            FormUiTxt(
                key: "key1",
                question: "question 1",
                input: FieldInputMethod.pickDate),
            FormUiTxt(
                key: "key1.1",
                question: "question 1.1",
                input: FieldInputMethod.pickDate,
                answer: "aha",
                isInputEnabled: false),
            FormUiRadio(
              key: "key2",
              question: "question 2",
              selectedAnswer: 0,
              answerItems: [
                "ya",
                "tidak",
              ],
            ),
            FormUiRadio(
              key: "key3",
              question: "question 3",
              isInputEnabled: false,
              selectedAnswer: 1,
              answerItems: [
                "ya",
                "tidak",
              ],
            ),
            FormUiCheck(
              key: "key4",
              question: "question 4",
              isInputEnabled: false,
              selectedAnswers: {1, 2},
              answerItems: [
                "ya",
                "tidak",
                "ok",
              ],
            ),
            FormUiCheck(
              key: "key5",
              question: "question 5",
              answerItems: [
                "ya",
                "tidak",
                "ok",
              ],
            ),
          ],
        ),
      ];

  @override
  List<LiveData> get liveDatas => [];

  @override
  Future<bool> validateField(
      int groupPosition, String inputKey, response) async {
    prind(
        "validateField() response?.runtimeType = ${response?.runtimeType} resp = $response");
    if (response is String) return response.isNotEmpty;
    if (response is Set) return response.isNotEmpty;
    return response != null;
  }
}

class _Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      stayDuration: Duration(seconds: 3),
      computation: () => Future.delayed(Duration(seconds: 1), () {
        prind("_Splash2 Future.delayed");
      }),
      child: defaultLoading(),
      pageBuilder: (ctx) {
        prind("_Splash2 halaman 2");
        return Scaffold(
          body: Container(
            color: Colors.blue,
            child: Text("halaman 2"),
          ),
        );
      },
    );
  }
}

class _Splash extends StatefulWidget {
  @override
  State createState() => _SplashState();
}

class _SplashState extends State<_Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (ctx, anim, secAnim, child) {
              final start = Offset(0, -1);
              final end = Offset.zero;
              final tween = Tween(begin: start, end: end);

              final curve = Curves.bounceOut;
              final ct = CurveTween(curve: curve);
              final t = tween.chain(ct);

              final off = anim.drive(ct);

              return RotationTransition(
                turns: anim.drive(ct),
                child: child,
              );
            },
            pageBuilder: (ctx, anim, secAnim) {
              prind("to _NextPage");
              return _NextPage();
            },
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    prind("_Splash");
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.green,
        child: Expanded(
          child: Text(
            "Ini Splash",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    prind("_NextPage");
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Expanded(
          child: Text(
            "Ini halaman slanjutnya",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/*
class MatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: PopupSuccess(
            msg: "Data Pemeriksaan Bunda berhasil disimpan",
            actionMsg: "Lihat hasil pemeriksaan",
            onActionClick: () {
              showSnackBar(context, "Dipencet");
              backPage(context);
            },
          ),
        ),
      ),
      child: Text("Click me"),
    );
  }
}

 */

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


 */
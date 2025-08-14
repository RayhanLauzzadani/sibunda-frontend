import 'dart:io';

import 'package:common/arch/domain/model/form_data.dart';
import 'package:common/arch/domain/model/form_warning_status.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/domain/model/kehamilanku_data.dart';
import 'package:common/arch/domain/model/profile_data.dart';
import 'package:common/arch/domain/usecase/baby_usecase.dart';
import 'package:common/arch/domain/usecase/mother_usecase.dart';
import 'package:common/arch/ui/model/form_data.dart';
import 'package:common/arch/ui/vm/vm_auth.dart';
import 'package:common/res/string/_string.dart';
import 'package:common/util/times.dart';
import 'package:common/util/type_util.dart';
import 'package:common/value/const_values.dart';
import 'package:core/domain/model/result.dart';
import 'package:core/ui/base/live_data.dart';
import 'package:core/util/_consoles.dart';
import 'package:core/util/val_util.dart';
import 'package:flutter/material.dart';
import 'package:kehamilanku/core/domain/usecase/pregnancy_check_use_case.dart';

class KehamilankuCheckFormVm extends FormAuthVmGroup {
  static const getPregnancyCheckKey = "getPregnancyCheck";
  static const getMotherFormWarningStatusKey = "getMotherFormWarningStatus";
  static const getPregnancyBabySizeKey = "getPregnancyBabySize";

  KehamilankuCheckFormVm({
    BuildContext? context,
    required this.pregnancyId,
    //required GetMotherNik getMotherNik,
    //required GetCurrentMotherHpl getCurrentMotherHpl,
    //required GetCurrentMotherHpht getCurrentMotherHpht,
    required GetMotherHpl getMotherHpl,
    required GetPregnancyCheckUpId getPregnancyCheckUpId,
    required SavePregnancyCheck savePregnancyCheck,
    required SaveUsgImg saveUsgImg,
    required GetPregnancyCheck getPregnancyCheck,
    required GetMotherFormWarningStatus getMotherFormWarningStatus,
    required GetPregnancyBabySize getPregnancyBabySize,
    required GetPregnancyCheckForm getPregnancyCheckForm,
    required IsBabyBorn isBabyBorn,
  }):
    //_getMotherNik = getMotherNik,
    //_getCurrentMotherHpl = getCurrentMotherHpl,
    //_getCurrentMotherHpht = getCurrentMotherHpht,
    _getMotherHpl = getMotherHpl,
    _getPregnancyCheckUpId = getPregnancyCheckUpId,
    _savePregnancyCheck = savePregnancyCheck,
    _saveUsgImg = saveUsgImg,
    _getPregnancyCheck = getPregnancyCheck,
    _getMotherFormWarningStatus = getMotherFormWarningStatus,
    _getPregnancyBabySize = getPregnancyBabySize,
    _getPregnancyCheckForm = getPregnancyCheckForm,
    _isBabyBornUseCase = isBabyBorn, super(context: context) {

    _currentWeek.observe(this, (week) {
      prind("_currentWeek.observe week = $week");
      setResponse(0, Const.KEY_WEEK, week);
    });
    _isBabyBorn.observe(this, (isBorn) {
      prind("PregTrimesterVm _isBabyBorn.observe() isBorn= $isBorn");
      setFormEnabled(isEnabled: isBorn != true);
    }, tag: toString());
    onSubmit.observe(this, (success) {
      if(success is Success<String>) {
        setFormEnabled(isEnabled: false);
      }
    }, tag: toString());
    _pregnancyCheck.observe(this, (data) {
      if(data != null) {
        final map = data.toJson();
        final usgUrl = map[Const.KEY_IMG_USG];
        prind("KehamilankuCheckFormVm usgUrl= $usgUrl");
        if(usgUrl is String) {
          map[Const.KEY_IMG_USG] = ImgData(
            link: usgUrl,
            src: ImgData.getSrcFromLink(usgUrl),
          );
        }
        patchResponse([map]);
      } else {
        resetResponses(skippedKeys: {
          Const.KEY_HPL,
          Const.KEY_HPHT,
          Const.KEY_WEEK,
        });
        setFieldValidity(0, Const.KEY_IMG_USG, true);
      }
      setFormEnabled(isEnabled: data == null && _isBabyBorn.value != true);
      //Future.sync(() async {});
      //_isFormEnabled = data == null;
    }, tag: toString());
    _pregnancyBabySize.observe(this, (data) {
      _isBabySizeInit.value = true;
      prind("PregnFormVm _pregnancyBabySize.observe data= $data _isBabySizeInit= $_isBabySizeInit");
    }, tag: toString());
    isFormReady.observe(this, (isReady) {
      if(isReady == true) {
        //prind("Trimester VM isFormReady.observe isReady= $isReady");
        setFieldValidity(0, Const.KEY_IMG_USG, true);
        //prind("Trimester VM _responseGroupList[group][key]!.isValid = ${responseGroupList[0][Const.KEY_IMG_USG]!.isValid}");
      }
    }, tag: toString());
    _lateInit();
  }

  final ProfileCredential pregnancyId;

  final GetMotherHpl _getMotherHpl;
  final GetPregnancyCheckUpId _getPregnancyCheckUpId;
  final SavePregnancyCheck _savePregnancyCheck;
  final SaveUsgImg _saveUsgImg;
  final GetPregnancyCheck _getPregnancyCheck;
  final GetMotherFormWarningStatus _getMotherFormWarningStatus;
  final GetPregnancyBabySize _getPregnancyBabySize;
  final GetPregnancyCheckForm _getPregnancyCheckForm;
  final IsBabyBorn _isBabyBornUseCase;
  //final GetMotherNik _getMotherNik;
  //final GetCurrentMotherHpl _getCurrentMotherHpl;
  //final GetCurrentMotherHpht _getCurrentMotherHpht;

  final MutableLiveData<PregnancyCheck> _pregnancyCheck = MutableLiveData();
  final MutableLiveData<List<FormWarningStatus>> _formWarningStatusList = MutableLiveData();
  final MutableLiveData<PregnancyBabySize> _pregnancyBabySize = MutableLiveData();
  final MutableLiveData<bool> _isBabyBorn = MutableLiveData();

  LiveData<PregnancyCheck> get pregnancyCheck => _pregnancyCheck;
  LiveData<List<FormWarningStatus>> get formWarningStatusList => _formWarningStatusList;
  LiveData<PregnancyBabySize> get pregnancyBabySize => _pregnancyBabySize;
  LiveData<bool> get isBabyBorn => _isBabyBorn;

  /// Cuz there are some week with no baby size
  final MutableLiveData<bool> _isBabySizeInit = MutableLiveData(false);
  final MutableLiveData<int> _currentWeek = MutableLiveData();

  LiveData<bool> get isBabySizeInit => _isBabySizeInit;
  LiveData<int> get currentWeek => _currentWeek;
  late int currentTrimesterId;

  @override
  List<LiveData> get liveDatas => [
    _pregnancyCheck, _formWarningStatusList,
    _pregnancyBabySize, _currentWeek, _isBabySizeInit,
    _isBabyBorn,
  ];

  void _lateInit() async {
    final hplRes = await _getMotherHpl(pregnancyId.id);

    prind("MotherCHeckFormVm._lateInit() hplRes= $hplRes");

    if(hplRes is Success<DateTime>) {
      final hpl = hplRes.data;
      final hpht = getHpht(hpl);

      setResponse(0, Const.KEY_HPL, hpl);
      setResponse(0, Const.KEY_HPHT, hpht);
    }
  }

  @override
  Future<Result<String>> doSubmitJob() async {
    //prind("KehamilankuCheckFormVm doSubmitJob() ==== AWAL");
    final response = getResponse();
    final responseMap = response.responseGroups.values.first;
    final imgFile = responseMap.remove(Const.KEY_IMG_USG);

    //prind("KehamilankuCheckFormVm doSubmitJob() ==== responseMap = ${responseMap.responseGroups}");
    final data = PregnancyCheck.fromJson(responseMap);
    //prind("KehamilankuCheckFormVm doSubmitJob() ==== data = ${data.toJson()}");
    //final motherNik = VarDi.motherNik.getOrElse();
    final submitRes = await _savePregnancyCheck(pregnancyId.id, data, currentTrimesterId);
    if(submitRes is Success<int>) {
      final checkUpId = submitRes.data;
      prind("imgFile= $imgFile");
      if(imgFile != null) {
        final res2 = await _saveUsgImg(
          pregnancyId: pregnancyId.id,
          checkUpId: checkUpId,
          imgFile: imgFile,
        );
        if(res2 is Success<File?>) {
          return Success("ok");
        } else {
          return Fail(msg: "Can't submit USG img");
        }
      }
      return Success("ok");
    } else {
      return Fail(msg: "Can't submit pregnancy check form");
    }
  }

  @override
  Set<String>? get mappedKey => {
    Const.KEY_VISIT_DATE,
    Const.KEY_FUTURE_VISIT_DATE,
    Const.KEY_HPHT,
    Const.KEY_HPL,

    Const.KEY_WEEK,
    Const.KEY_BABY_GENDER,
    Const.KEY_WEIGHT,
    Const.KEY_WEIGHT_DIFF,
    Const.KEY_HEIGHT,
    Const.KEY_BABY_MOVEMENT,
    Const.KEY_TFU,
    Const.KEY_DJJ,
    Const.KEY_SYSTOLIC_PRESSURE,
    Const.KEY_DIASTOLIC_PRESSURE,
    Const.KEY_MAP,
  };
  @override
  mapResponse(int groupPosition, String key, response) {
    switch(key) {
      case Const.KEY_VISIT_DATE:
      case Const.KEY_FUTURE_VISIT_DATE:
      case Const.KEY_HPHT:
      case Const.KEY_HPL: return response?.toString();

      case Const.KEY_WEEK:
      case Const.KEY_BABY_MOVEMENT: return parseInt(response);

      case Const.KEY_WEIGHT:
      case Const.KEY_WEIGHT_DIFF:
      case Const.KEY_HEIGHT:
      case Const.KEY_TFU:
      case Const.KEY_DJJ:
      case Const.KEY_SYSTOLIC_PRESSURE:
      case Const.KEY_DIASTOLIC_PRESSURE:
      case Const.KEY_MAP: return parseNum(response);

      case Const.KEY_BABY_GENDER:
        final str = response?.toString() ?? "";
        // Map '-' (unknown) to empty string so backend can accept it
        return str.trim() == '-' ? "" : str;
    }
    return super.mapResponse(groupPosition, key, response);
  }

  @override
  Future<bool> validateField(int groupPosition, String inputKey, response) async {
    //prind("PregTrimFormVm validateField() group=$groupPosition key=$inputKey resp=$response");
    switch(inputKey) {
      case Const.KEY_WEEK:
      case Const.KEY_BABY_MOVEMENT: return tryParseInt(response) != null;
      case Const.KEY_WEIGHT:
      case Const.KEY_WEIGHT_DIFF:
      case Const.KEY_HEIGHT:
      case Const.KEY_TFU:
      case Const.KEY_DJJ:
      case Const.KEY_SYSTOLIC_PRESSURE:
      case Const.KEY_DIASTOLIC_PRESSURE:
      case Const.KEY_MAP: return tryParseNum(response) != null;
      case Const.KEY_IMG_USG: return true; // this param is optional.
    }
    return super.validateField(groupPosition, inputKey, response);
  }

  @override
  String getResponseStringRepr(int groupPosition, String inputKey, response) {
    if(response is DateTime) {
      return syncFormatTime(response);
    }
    return super.getResponseStringRepr(groupPosition, inputKey, response);
  }

  @override
  String getInvalidMsg(String inputKey, response) {
    switch(inputKey) {
      case Const.KEY_WEEK:
      case Const.KEY_WEIGHT:
      case Const.KEY_WEIGHT_DIFF:
      case Const.KEY_HEIGHT:
      case Const.KEY_TFU:
      case Const.KEY_DJJ:
      case Const.KEY_SYSTOLIC_PRESSURE:
      case Const.KEY_DIASTOLIC_PRESSURE:
      case Const.KEY_MAP: return (response is String) && response.isNotEmpty == true
        ? Strings.field_must_be_number
        : Strings.field_can_not_be_empty;
    }
    return super.getInvalidMsg(inputKey, response);
  }

  @override
  Future<List<FormUiGroupData>> getFieldGroupList() async {
    final res = await _getPregnancyCheckForm();
    if(res is Success<List<FormGroupData>>) {
      final data = res.data;
      return data.map((e) => FormUiGroupData.fromModel(e)).toList(growable: false);
    } else {
      return List.empty();
    }
  }

  void initVm({ bool forceLoad = false }) {
    init(isOneShot: !forceLoad);
    _isBabyBornUseCase(pregnancyId.id).then((res) {
      if(res is Success<bool>) {
        _isBabyBorn.value = res.data;
      } else {
        _isBabyBorn.value = false;
      }
    });
  }

  void initPage({
    required int week,
    bool forceLoad = false,
  }) {
    //prind("KehamilankuCheckFormVm.initPage() week = $week forceLoad = $forceLoad _currentWeek.value = ${_currentWeek.value}");
    if(!forceLoad && _currentWeek.value == week) return;
    _currentWeek.value = week;

    _pregnancyCheck.value = null;
    _formWarningStatusList.value = null;
    _pregnancyBabySize.value = null;
    _isBabySizeInit.value = false;

    init(isOneShot: false);
    isFormReady.observeOnce((isReady) {
      if(isReady == true) {
        getPregnancyCheck(week: week, forceLoad: true);
        getMotherFormWarningStatus(week: week, forceLoad: true);
        getPregnancyBabySize(week: week, forceLoad: true);
        _lateInit();
        _currentWeek.notifyObservers();
      }
    }, immediatelyGet: false,);
    //prind("KehamilankuCheckFormVm.initPage() AKHIR!!! week = $week forceLoad = $forceLoad _currentWeek.value = ${_currentWeek.value}");
  }

  void getPregnancyCheck({
//    required String motherNik,
    required int week,
    bool forceLoad = false,
  }) {
    if(!forceLoad && _pregnancyCheck.value != null) return;
    startJob(getPregnancyCheckKey, (isActive) async {
      //final motherNik = VarDi.motherNik.getOrElse();
      //final res = await _getPregnancyCheckUpId(pregnancyId.id, week);
      //final checkUpId = tryGetResultValue(res);
      //prind("getPregnancyCheck() checkUpId = $checkUpId pregnancyId = $pregnancyId week = $week res = $res");
      //if(checkUpId != null) {}
      final checkUpWeek = PregnancyCheckUpWeek(
        pregnancyId: pregnancyId.id,
        trimesterId: currentTrimesterId,
        week: week,
      );
      _getPregnancyCheck(checkUpWeek).then((value) {
        prind("getPregnancyCheck() _getPregnancyCheck() value= $value checkUpWeek= $checkUpWeek");
        if(value is Success<PregnancyCheck>) {
          final data = value.data;
          _pregnancyCheck.value = data;
        } else {
          _pregnancyCheck.value = null;
        }
      });
    });
  }
  void getMotherFormWarningStatus({
    //required String motherNik,
    required int week,
    bool forceLoad = false,
  }) {
    if(!forceLoad && _formWarningStatusList.value != null) return;
    startJob(getMotherFormWarningStatusKey, (isActive) async {
      final checkUpWeek = PregnancyCheckUpWeek(
        pregnancyId: pregnancyId.id,
        trimesterId: currentTrimesterId,
        week: week,
      );
      _getMotherFormWarningStatus(checkUpWeek).then((value) {
        if(value is Success<List<FormWarningStatus>>) {
          final data = value.data;
          _formWarningStatusList.value = data;
        } else {
          _formWarningStatusList.value = List.empty();
        }
      });
    });
  }
  void getPregnancyBabySize({
    required int week,
    bool forceLoad = false,
  }) {
    if(!forceLoad && _pregnancyBabySize.value != null) return;
    startJob(getPregnancyBabySizeKey, (isActive) async {
      final checkUpWeek = PregnancyCheckUpWeek(
        pregnancyId: pregnancyId.id,
        trimesterId: currentTrimesterId,
        week: week,
      );
      final res = await _getPregnancyBabySize(checkUpWeek);
      prind("KehamilankuCheckFormVm.getPregnancyBabySize() _getPregnancyBabySize(checkUpId).then week = $week res= $res");
      if(res is Success<PregnancyBabySize?>) {
        prind("KehamilankuCheckFormVm.getPregnancyBabySize() MASUK _getPregnancyBabySize(checkUpId).then week = $week res= $res");
        final data = res.data;
        _pregnancyBabySize.value = data;
      } else {
        _pregnancyBabySize.value = null;
      }
    });
  }
}
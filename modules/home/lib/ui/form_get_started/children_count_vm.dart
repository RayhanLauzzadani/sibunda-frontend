import 'package:common/util/times.dart';
import 'package:core/domain/model/result.dart';
import 'package:core/ui/base/async_vm.dart';
import 'package:core/ui/base/live_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/core/domain/usecase/form_get_started_usecase.dart';

class ChildrenCountVm extends AsyncVm {
  static const proceedKey = "proceed";

  ChildrenCountVm({
    //required SaveLastChildBirthDate saveLastChildBirthDate,
    required SaveChildrenCount saveChildrenCount,
  }) :
        //_saveLastChildBirthDate = saveLastChildBirthDate,
        _saveChildrenCount = saveChildrenCount {
    _init();
  }

  final SaveChildrenCount _saveChildrenCount;

  final MutableLiveData<bool> _canProceed = MutableLiveData();
  final MutableLiveData<bool> _onSubmit = MutableLiveData();
  //final MutableLiveData<DateTime> lastChildBirthDate = MutableLiveData();
  final MutableLiveData<int> childrenCount = MutableLiveData();

  LiveData<bool> get canProceed => _canProceed;
  LiveData<bool> get onSubmit => _onSubmit;

  @override
  List<LiveData> get liveDatas => [];

  void _init() {
/*
    lastChildBirthDate.observe(this, (date) {
      if(date != null) {
        formatTime(date).then((str) =>
          lastChildBirthDateTxtControl.text = str
        );
      }
      _canProceed.value = date != null && childrenCount.value != null;
    });
 */
    childrenCount.observe(this, (count) {
      _canProceed.value =
          count != null && count >= 1; //&& lastChildBirthDate.value != null;
    });
  }

  void proceed() {
    startJob(proceedKey, (isActive) async {
      final count = childrenCount.value;
      //final lastChildBirth = lastChildBirthDate.value;
      if (count == null) {
        throw "`count` == null";
      }
      /*
      if(lastChildBirth == null) {
        throw "`lastChildBirth` == null";
      }
       */

      final res1 = await _saveChildrenCount(count);
      //final res2 = await _saveLastChildBirthDate(lastChildBirth);

      if (res1 is Success<bool> /*&& res2 is Success<bool>*/) {
        final data = res1.data; //&& res2.data;
        _onSubmit.value = data;
      } else {
        return (res1 as Fail<bool>).copy(msg: "Can't save children count");
      }
    });
  }
}

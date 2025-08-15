import 'package:common/arch/domain/model/_model_template.dart';
import 'package:common/res/string/_string.dart';
import 'package:core/ui/base/expirable.dart';
import 'package:core/util/_consoles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdStringListView extends StatefulWidget {
  final List<IdStringModel> dataList;
  final TextEditingController searchTxtControl;
  final void Function(int id, String name)? onItemClick;
  final bool showId;

  IdStringListView({
    required this.dataList,
    this.onItemClick,
    this.showId = true,
    TextEditingController? searchTxtControl,
  }): this.searchTxtControl = searchTxtControl ?? TextEditingController();

  @override
  State createState() => _IdStringListViewState(
    dataList: dataList,
    searchTxtControl: searchTxtControl,
    onItemClick: onItemClick,
    showId: showId,
  );
}


class _IdStringListViewState
    extends State<IdStringListView>
    implements Expirable
{
  final List<IdStringModel> dataList;
  final TextEditingController searchTxtControl;
  final void Function(int id, String name)? onItemClick;
  late final void Function() onSearchChange;
  final bool showId;

  _IdStringListViewState({
    required this.dataList,
    required this.searchTxtControl,
    required this.onItemClick,
    required this.showId,
  }): _usedDataList = List.unmodifiable(
    dataList.where((e) => e.name.trim() != '-' && e.name.trim().isNotEmpty).toList(),
  ) {
    onSearchChange = () {
      if(isActive) {
        final keyword = searchTxtControl.text;
        if(keyword.isNotEmpty) {
          _usedDataList = dataList
              .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
              .where((e) => e.name.trim() != '-' && e.name.trim().isNotEmpty)
              .toList(growable: false);
        } else {
          _usedDataList = List.unmodifiable(
            dataList.where((e) => e.name.trim() != '-' && e.name.trim().isNotEmpty).toList(),
          );
        }
        setState(() {});
      }
    };
  }

  List<IdStringModel> _usedDataList;
/*
  @override
  void initState() {
    //prind("IdStringAdp initState()");
    super.initState();
  }
 */

  @override
  Widget build(BuildContext context) {
    //prind("IdStringAdpState.build() isActive = $isActive");

    searchTxtControl.removeListener(onSearchChange);
    searchTxtControl.addListener(onSearchChange);

    final child = _usedDataList.isEmpty
        ? Text(Strings.no_data)
        : ListView.builder(
          itemCount: _usedDataList.length,
          itemBuilder: (ctx, i) => ListTile(
            onTap: onItemClick == null ? null
                : () => onItemClick!.call(_usedDataList[i].id, _usedDataList[i].name),
            title: Text(_usedDataList[i].name),
            subtitle: showId ? Text(_usedDataList[i].id.toString()) : null,
          ),
        );
    return child;
  }

  bool _isActive = true;
  @override
  bool get isActive => _isActive;

  @override
  void dispose() {
    _isActive = false;
    super.dispose();
  }
}
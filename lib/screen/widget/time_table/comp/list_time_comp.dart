import 'package:base_pm2/screen/widget/time_table/comp/item_time_comp.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTimeComp extends StatefulWidget {
  const ListTimeComp({Key? key, this.id = 1, this.onChange, this.activeColor, this.inActiveColor, this.activeTextColor, this.inActiveTextColor})
      : super(key: key);
  final int id;
  final Function(TimeModel model)? onChange;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? activeTextColor;
  final Color? inActiveTextColor;

  @override
  State<ListTimeComp> createState() => _ListTimeCompState();
}

class _ListTimeCompState extends State<ListTimeComp> {
  List<TimeModel> mTimes = [];

  @override
  void initState() {
    mTimes = [
      TimeModel(id: 1, title: 'T2', isActive: true),
      TimeModel(id: 2, title: 'T3', isActive: false),
      TimeModel(id: 3, title: 'T4', isActive: false),
      TimeModel(id: 4, title: 'T5', isActive: false),
      TimeModel(id: 5, title: 'T6', isActive: false),
      TimeModel(id: 6, title: 'T7', isActive: false),
      TimeModel(id: 7, title: 'CN', isActive: false),
    ];
    _activeTime();
    super.initState();
  }

  void _activeTime() {
    mTimes.singleWhere((element) => element.id == widget.id).isActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: mTimes.mapIndexed(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(int index, TimeModel element) {
    TimeModel model = mTimes[index];
    return ItemTimeComp(
      timeModel: model,
      activeColor: widget.activeColor,
      inActiveColor: widget.inActiveColor,
      activeTextColor: widget.activeTextColor,
      inActiveTextColor: widget.inActiveTextColor,
      onChangePress: () => _onChange(model),
    );
  }

  void _onChange(TimeModel model) {
    mTimes.forEach((element) => element.isActive = false);
    model.isActive = true;
    setState(() {});
    widget.onChange?.call(model);
  }
}

class TimeModel {
  int? id;
  String? title;
  bool? isActive = false;

  TimeModel({this.id, this.title, this.isActive});
}

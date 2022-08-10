import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class HeaderPicker extends StatefulWidget {
  const HeaderPicker({Key? key, this.month, this.year, this.onSelected}) : super(key: key);
  final int? month;
  final int? year;
  final Function(int month, int year)? onSelected;

  @override
  State<HeaderPicker> createState() => _HeaderPickerState();
}

class _HeaderPickerState extends State<HeaderPicker> {
  GlobalKey<PopupMenuButtonState> monthPopup = GlobalKey();
  GlobalKey<PopupMenuButtonState> yearPopup = GlobalKey();
  int currentMonth = 0;
  int currentYear = 0;

  @override
  void initState() {
    super.initState();
    currentMonth = widget.month ?? DateTime.now().month;
    currentYear = widget.year ?? DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
       /*     InkWell(
              onTap: () => monthPopup.currentState?.showButtonMenu(),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff585757).withOpacity(.1),
                          const Color(0xff888888).withOpacity(.1)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    children: [
                      Text(
                        'Tháng $currentMonth',
                        style: appStyle.textTheme.bodyText1
                            ?.copyWith(fontWeight: FontWeight.w500, color: ColorResource.tabIndicator),
                      ),
                      const SizedBox(width: 8),
                      const ImageViewer(ImageResource.ic_arrow_down, color: ColorResource.day_section)
                    ],
                  )),
            ),
            SizedBox(
              width: 0,
              height: 0,
              child: PopupMenuButton<int>(
                  key: monthPopup,
                  offset: const Offset(-90, 10),
                  icon: const SizedBox(),
                  itemBuilder: _buildMonthMenu,
                  onSelected: _onMonthSelected,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),*/
          /*  const SizedBox(width: 4),
            InkWell(
              onTap: () => yearPopup.currentState?.showButtonMenu(),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff585757).withOpacity(.1),
                          const Color(0xff888888).withOpacity(.1)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    children: [
                      Text('$currentYear',
                          style: appStyle.textTheme.bodyText1
                              ?.copyWith(fontWeight: FontWeight.w500, color: ColorResource.tabIndicator)),
                      const SizedBox(width: 8),
                      const ImageViewer(ImageResource.ic_arrow_down, color: ColorResource.day_section)
                    ],
                  )),
            ),*/
            SizedBox(
              width: 0,
              height: 0,
              child: PopupMenuButton<int>(
                  key: yearPopup,
                  offset: const Offset(-90, 10),
                  icon: const SizedBox(),
                  itemBuilder: _buildYearMenu,
                  onSelected: _onYearSelected,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'].mapIndexed<Widget>(_buildItem).toList(),
        ),
      ],
    );
  }

  Widget _buildItem(int index, String element) {
    return Expanded(
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 6 ? ColorResource.bottomBarItem : ColorResource.secondPrimary.withOpacity(.6)),
        child: Text(
          element,
          style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  List<PopupMenuEntry<int>> _buildMonthMenu(BuildContext context) {
    List<PopupMenuItem<int>> items = [];
    for (int i = 1; i <= 12; i++) {
      items.add(PopupMenuItem(
          value: i,
          child: Text(
            'Tháng $i',
            style: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator),
          ),
          height: 35));
    }
    return items;
  }

  List<PopupMenuEntry<int>> _buildYearMenu(BuildContext context) {
    List<PopupMenuItem<int>> items = [];
    for (int i = 0; i < 100; i++) {
      items.add(PopupMenuItem(
          value: DateTime.now().year - i,
          child: Text(
            'Năm ${DateTime.now().year - i}',
            style: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator),
          ),
          height: 35));
    }
    return items;
  }

  void _onYearSelected(int value) {
    currentYear = value;
    widget.onSelected?.call(currentMonth, currentYear);
    setState(() {});
  }

  void _onMonthSelected(int value) {
    currentMonth = value;
    widget.onSelected?.call(currentMonth, currentYear);
    setState(() {});
  }
}

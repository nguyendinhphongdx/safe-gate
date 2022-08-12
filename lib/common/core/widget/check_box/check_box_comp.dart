import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';

class ListCheckBoxComp<T> extends StatefulWidget {
  final List<OptionCheckBox<T>> listCheckBox;
  final Function(List<T> listSelected) onChange;

  const ListCheckBoxComp({
    Key? key,
    required this.listCheckBox,
    required this.onChange,
  }) : super(key: key);

  @override
  _ListCheckBoxCompState<T> createState() => _ListCheckBoxCompState<T>();
}

class _ListCheckBoxCompState<T> extends State<ListCheckBoxComp<T>> {
  List<T> listCheckBoxSelected = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: index == 0 ? 16 : 0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13)
            ),
              child: CheckBoxComp(
                  isListTile: true,
                  title: Text(widget.listCheckBox[index].title),
                  value: widget.listCheckBox[index].isCheck,
                  onChanged: (value) {
                    widget.listCheckBox[index].isCheck = value ?? false;
                    setState(() {
                      if (widget.listCheckBox[index].isCheck) {
                        listCheckBoxSelected.add(widget.listCheckBox[index].data);
                      } else {
                        listCheckBoxSelected.remove(widget.listCheckBox[index].data);
                      }
                    });
                    widget.onChange.call(listCheckBoxSelected);
                  }),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
      itemCount: widget.listCheckBox.length,
    );
  }
}

class CheckBoxComp extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final double? scale, splashRadius;
  final bool? tristate, isListTile, isThreeLine;
  final Color? activeColor, checkColor, selectedTileColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? title, secondary, subtitle;

  const CheckBoxComp({
    Key? key,
    required this.value,
    required this.onChanged,
    this.shape,
    this.side,
    this.scale,
    this.tristate,
    this.splashRadius,
    this.activeColor,
    this.checkColor,
    this.isListTile = false,
    this.isThreeLine,
    this.contentPadding,
    this.selectedTileColor,
    this.title,
    this.secondary,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isListTile!
        ? Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              shape: shape,
              side: side,
              tristate: tristate ?? false,
              activeColor: activeColor,
              splashRadius: splashRadius,
              checkColor: checkColor,
            ),
          )
        : CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: value,
            onChanged: onChanged,
            shape: shape,
            side: side,
            tristate: tristate ?? false,
            activeColor: activeColor,
            title: title,
            contentPadding: contentPadding,
            isThreeLine: isThreeLine ?? false,
            secondary: secondary,
            subtitle: subtitle,
            selectedTileColor: selectedTileColor,
            checkColor: checkColor,
          );
  }
}

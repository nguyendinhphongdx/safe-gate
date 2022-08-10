import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:flutter/material.dart';

class DropDownDevice extends StatelessWidget {
  const DropDownDevice({Key? key, this.options, this.onSelected, this.hint, this.currentValue}) : super(key: key);
  final String? hint;
  final String? currentValue;
  final List<BaseOptionDropdown>? options;
  final Function(dynamic value)? onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownComp(
      currentValue: currentValue,
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      style:
          appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.primary, fontWeight: FontWeight.w600),
      selectionStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.black),
      icon: const ImageViewer(
        ImageResource.ic_arrow_down,
        color: ColorResource.primary,
      ),
      listItems: options ?? [],
      hintStyle: appStyle.textTheme.subtitle1?.apply(color: ColorResource.hint),
      hint: hint,
      onTapCallBack: (v,index) => onSelected?.call(v), onChange: (value) {  },
    );
  }
}

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ItemStepComp extends StatelessWidget {
  const ItemStepComp({Key? key, this.isLast = false, this.title, this.isActive = false}) : super(key: key);
  final bool isLast;
  final String? title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: isActive ? ColorResource.primary : ColorResource.inActiveStep),
          child: Text(title ?? '',style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 18,fontWeight: FontWeight.w600),),
        ),
        Visibility(
          visible: !isLast,
          child: Expanded(
            child: Container(
              height: 2,
              color: /*!isActive ?*/ ColorResource.primary /*: ColorResource.inActiveStep*/,
            ),
          ),
        )
      ],
    );
  }
}

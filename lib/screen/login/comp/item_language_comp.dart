import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/material.dart';

class ItemLanguageComp extends StatelessWidget {
  const ItemLanguageComp({Key? key, this.isVietnamese = false, this.onChangeLanguage}) : super(key: key);
  final bool isVietnamese;
  final Function()? onChangeLanguage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChangeLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        width: 42,
        height: 20,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(100)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                transitionBuilder: _buildTransition,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.only(left:2.0),
                  child: Text(
                    isVietnamese ? '' : 'EN',
                    style: appStyle.textTheme.bodyText2
                        ?.apply(color: Colors.white),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              child: const Padding(

                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ImageViewer(
                  ImageResource.ic_language_change,
                  color: Colors.white,
                  width: 14,
                  height: 14,
                ),
              ),
              left: isVietnamese ? 0 : 22,
              right: isVietnamese ? 22 : 0,
            ),


            Align(
              alignment: Alignment.centerRight,
              child: AnimatedSwitcher(
                transitionBuilder: _buildTransition,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.only(right:2.0),
                  child: Text(
                    isVietnamese ? 'VN' : '',
                    style: appStyle.textTheme.bodyText2
                        ?.apply(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  }
}

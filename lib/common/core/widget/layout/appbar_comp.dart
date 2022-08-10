import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../button/icon_button_comp.dart';

class  AppBarComp extends PreferredSize {
  final dynamic title;
  final TextStyle? style;
  final List<Widget>? action;
  final Color? backgroundColor;
  final Color? colorIcon;
  final double? elevation;
  final double? height;
  final bool isLight;
  final bool? isLeading;
  final bool centerTitle;
  final Widget? flexibleSpace;
  final Widget? iconLeading;
  final Function? onLeading;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final PreferredSizeWidget? bottom;

  AppBarComp({
    Key? key,
    this.systemOverlayStyle,
    this.title = '',
    this.style,
    this.height,
    this.action,
    this.backgroundColor,
    this.colorIcon,
    this.elevation = 0,
    this.isLight = true,
    this.isLeading = true,
    this.flexibleSpace,
    this.iconLeading,
    this.onLeading,
    this.centerTitle = true,
    this.bottom,
  }) : super(key: key, preferredSize: Size(double.infinity, height ?? kToolbarHeight), child: Container());

  @override
  Size get preferredSize => Size(double.infinity, height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        systemOverlayStyle: isLight ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        toolbarHeight: height,
        title: title is Widget
            ? title
            : Text(
                title,
                style: style ?? appStyle.textTheme.bodyText1?.copyWith(fontSize: 16,fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
        flexibleSpace: flexibleSpace ?? SizedBox(),
        backgroundColor: backgroundColor ?? Colors.transparent,
        leading: Visibility(
          visible: isLeading ?? true,
          child: iconLeading ??
              IconButtonComp(
                icon: Icons.arrow_back_ios_rounded,
                size: 20,
                color: colorIcon ?? Colors.white,
                onPress: () => _onBackPress(context),
              ),
        ),
        leadingWidth: Navigator.canPop(context) ? null : 0,
        iconTheme: IconThemeData(color: colorIcon),
        centerTitle: centerTitle,
        actions: action,
        bottom: bottom,
      );

  void _onBackPress(BuildContext context) {
    if (onLeading == null) Navigator.maybePop(context);

    onLeading?.call();
  }
}

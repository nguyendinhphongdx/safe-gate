import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ItemAddUser extends StatelessWidget {
  const ItemAddUser({Key? key, this.onAddUser, this.colorIcon = ColorResource.primary}) : super(key: key);
  final Function()? onAddUser;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: onAddUser,
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
      isTransparent: true,
      child: Icon(
        Icons.add_circle,
        color: colorIcon,
        size: 32,
      ),
    );
  }
}

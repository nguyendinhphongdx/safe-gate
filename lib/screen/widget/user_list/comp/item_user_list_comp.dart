import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemUserListGComp extends GetView<UserListController> {
  const ItemUserListGComp({Key? key, this.profileModel}) : super(key: key);
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: TextButtonComp(
          isTransparent: true,
          onPressed: () => controller.onItemClick(profileModel),
          borderRadius: 12,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              ImageViewer(
                Utils.concatImageLink(profileModel?.profileAvatar) ?? ImageResource.ic_account,
                width: 60,
                fit: BoxFit.cover,
                height: 60,
                borderRadius: BorderRadius.circular(500),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileModel?.profileName ?? '',
                      style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${KeyLanguage.connecting.tr}: ${profileModel?.deviceConnecting ?? 0} ${KeyLanguage.device.tr}',
                      style: appStyle.textTheme.subtitle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   '${KeyLanguage.timeUsed.tr}: ${profileModel?.spentTime ?? 0} phút',
                    //   style: appStyle.textTheme.subtitle1,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
              Text(
                profileModel?.dnsMode == DNSMode.ADULT
                    ? KeyLanguage.adult.tr
                    : profileModel?.dnsMode == DNSMode.CHILD
                        ? KeyLanguage.child.tr
                        : '',
                maxLines: 1,
                style: appStyle.textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

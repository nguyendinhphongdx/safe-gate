import 'dart:typed_data';
import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickAvatarComp extends StatefulWidget {
  final String? url;
  final String? name;
  final bool isPick;
  final bool shouldShowName;
  final Size imageSize;
  final Size iconSize;
  final Offset editPosition;
  final Color? textColor;
  final Function(XFile? file)? callBackFile;
  final EdgeInsets? inkwellPadding;
  final double? namePadding;

  const PickAvatarComp({
    Key? key,
    //required
    this.url,
    this.isPick = true,
    //required
    this.name = 'Con gái',
    this.textColor,
    this.namePadding,
    this.inkwellPadding,
    this.imageSize = const Size(70, 70),
    this.iconSize = const Size(70, 70),
    this.editPosition = const Offset(0, 0),
    this.shouldShowName = true,
    this.callBackFile,
  }) : super(key: key);

  @override
  State<PickAvatarComp> createState() => _PickAvatarCompState();
}

class _PickAvatarCompState extends State<PickAvatarComp> {
  XFile? file;

  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWellComp(
          padding: widget.inkwellPadding,
          isTransparent: true,
          onTap: () async {
            file = await showModalBottomSheet(
                context: context,
                builder: (_) => const PickImgBottomSheetDialog(),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))));
            if(file == null) return;
            if (kIsWeb) {
              imageBytes = await file?.readAsBytes();
            }
            widget.callBackFile?.call(file);
            setState(() {});
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.3),blurRadius: 10)
                ],shape: BoxShape.circle),
                child: ImageViewer(
                  file?.path ?? widget.url ?? ImageResource.ic_account,
                  bytes: imageBytes,
                  width: widget.imageSize.width,
                  height: widget.imageSize.height,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
              Positioned(
                right: widget.editPosition.dx,
                bottom: widget.editPosition.dy,
                child: SvgComp(
                  url: ImageResource.ic_pick_avt,
                  width: widget.iconSize.width,
                  height: widget.iconSize.height,
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: widget.shouldShowName,
            child: Column(
              children: [
                SizedBox(height: widget.namePadding ?? 6),
                Text(
                  widget.name ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: widget.textColor),
                )
              ],
            ))
      ],
    );
  }
}

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/text_field/edit_text.dart';
import 'package:flutter/material.dart';

class ItemEditTextComp extends StatelessWidget {
  const ItemEditTextComp(
      {this.title,
      this.hint,
      this.maxLine,
      this.right,
      this.edtController,
      this.onValidator,
      Key? key,
      this.minLine})
      : super(key: key);
  final String? title;
  final String? hint;
  final int? maxLine;
  final int? minLine;
  final Widget? right;
  final TextEditingController? edtController;
  final String? Function(String? s)? onValidator;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            title ?? '',
          ),
        )),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          flex: 3,
          child: EditText(
            controller: edtController,
            maxLines: maxLine ?? 1,
            minLines: minLine ?? 1,
            hint: hint,
            rightIcon: right,
            textStyle: appStyle.textTheme.bodySmall
                ?.apply(fontSizeDelta: 3, color: Colors.white),
            borderRadius: 16,
            onValidator: onValidator,
          ),
        ),
      ],
    );
  }
}

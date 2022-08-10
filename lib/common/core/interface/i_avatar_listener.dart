import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class IAvatarListener{
  RxString name = ''.obs;
  RxString avatar = ''.obs;

  void onImagePicked(XFile? file);

  void setAvatar(String? s) => avatar.value = s ?? '';

  void setName(String? s) => name.value = s ?? '';
}
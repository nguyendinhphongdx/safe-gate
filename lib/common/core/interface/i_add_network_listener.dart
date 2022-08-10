import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/data/model/widget/body_model.dart';
import 'package:get/get.dart';

abstract class IAddNetWorkListener {
  RxList<BodyModel> bodyModels = <BodyModel>[].obs;
  RxList<BaseOptionDropdown> hashOptions = [
    BaseOptionDropdown(data: 'Mã hóa 1', name: 'Mã hóa 1'),
    BaseOptionDropdown(data: 'Mã hóa 2', name: 'Mã hóa 2')
  ].obs;
  RxList<BaseOptionDropdown> frequenlyOptions = [
    BaseOptionDropdown(data: 'Tần số 1', name: 'Tần số 1'),
    BaseOptionDropdown(data: 'Tần số 2', name: 'Tần số 2')
  ].obs;
  RxList<BaseOptionDropdown> brandOptions = [
    BaseOptionDropdown(data: 'Băng thông 1', name: 'Băng thông 1'),
    BaseOptionDropdown(data: 'Băng thông 2', name: 'Băng thông 2')
  ].obs;


  void onChangeUseStatus(BodyModel? bodyModel) {
    bodyModel?.useEnable?.value = !(bodyModel.useEnable?.value ?? false);
  }

  void onChangeNameStatus(BodyModel? bodyModel) {
    bodyModel?.noShowNameWifi?.value = !(bodyModel.noShowNameWifi?.value ?? false);
  }
}

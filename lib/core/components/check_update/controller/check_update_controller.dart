import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:twafok/core/core.dart';

class CheckUpdateController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    final newVersion = NewVersionPlus(
        iOSId: 'com.twafok.twafok', androidId: 'com.twafok.twafok');
    if (Get.context != null) {
      final status = await newVersion.getVersionStatus();
      if (status != null) {
        await CacheHelper.put(key: 'localVersion', value: status.localVersion);
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
            context: Get.context!,
            versionStatus: status,
            dialogTitle: 'تحديثات التطبيق',
            dialogText: 'رجاء تحديث التطبيق',
            allowDismissal: false,
            updateButtonText: 'تحديث',
          );
        }
      }
    }
  }
}

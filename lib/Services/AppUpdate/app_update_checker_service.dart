// ignore_for_file: use_build_context_synchronously

import 'package:campuspro/Screens/splash_screen.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';

class AppUpdateCheckerService extends GetxService {
  final newVersion = NewVersionPlus(
    iOSId: 'com.campuspro.campuspro',
    androidId: 'com.campuspro.campurPro_EdTech',
    androidPlayStoreCountry: "es_ES",
    androidHtmlReleaseNotes: true,
  );

  void appupdatechecker(BuildContext context) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      if (status.canUpdate == true) {
        newVersion.showUpdateDialog(
          updateButtonText: "Update Now",
          dismissButtonText: "Later",
          context: context,
          versionStatus: status,
          dialogTitle: 'Update Available',
          dialogText: 'A new version ${status.storeVersion} is available. '
              'You are using ${status.localVersion}. Please update to continue.',
          launchModeVersion: LaunchModeVersion.external,
          allowDismissal: true,
        );
      }
    }
  }
}

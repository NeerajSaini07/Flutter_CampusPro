// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/weburl_model.dart';
import 'package:campuspro/Repository/gerenateurl_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebController extends GetxController {
  late final PlatformWebViewControllerCreationParams params;

  var viewcontroller = Rxn<WebViewController>();
  var currentUrl = ''.obs;
  var pageLoader = false.obs;
  var appBarName = ''.obs;

  @override
  void onClose() {
    super.onClose();
    viewcontroller.value = null;
  }

  Future<void> initializeWebViewController(url) async {
    currentUrl.value = url;
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            pageLoader.value = true;
            if (url != currentUrl.value && currentUrl.isNotEmpty) {
              controller.reload();
              currentUrl.value = url;
            }
          },
          onPageFinished: (String url) async {
            controller.runJavaScript("""
        var style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = '.topbar { display: none !important; }';
        document.getElementsByTagName('head')[0].appendChild(style);
      """);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('    ')) {
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {},
      )
      ..loadRequest(Uri.parse(url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    viewcontroller.value = controller;
  }

  // **************************************** redirecting to web app ******************

  gotoWebview(url) async {
    await initializeWebViewController(url);
    //viewcontroller.close();
  }

  // ******************************** generating url  foer web

  generateWebUrl(pageurl, pageName) async {
    final FcmTokenController fcmTokenController = Get.put(FcmTokenController());
    await fcmTokenController.getFCMToken();
    await GenerateUrlRepository.getGenerateUrl(pageurl, pageName).then((value) {
      if (value != null) {
        WebUrlModel webUrlModel = WebUrlModel.fromJson(value);
        WebUrlList.urlListProperties = [webUrlModel];
        gotoWebview(WebUrlList.urlListProperties[0].url);
        currentUrl.value = WebUrlList.urlListProperties[0].url.toString();
      }
    });
  }
}

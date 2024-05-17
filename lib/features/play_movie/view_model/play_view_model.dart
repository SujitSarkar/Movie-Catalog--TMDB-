import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/router/router_imports.dart';

class PlayViewModel extends GetxController {
  PlayViewModel(this._url);
  final String _url;

  RxDouble progress = 0.0.obs;
  RxBool reloading = false.obs;
  RxString url = ''.obs;
  RxString title = ''.obs;

  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController =
      PullToRefreshController(
    settings: PullToRefreshSettings(
        color: AppColors.primaryColor, backgroundColor: Colors.white),
    onRefresh: () async => await onRefresh(),
  );

  @override
  void onInit() {
    configureWebViewController();
    super.onInit();
  }

  @override
  void dispose() {
    webViewController?.dispose();
    pullToRefreshController.dispose();
    super.dispose();
  }

  Future<void> configureWebViewController() async {
    url.value = _url;
    webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri.uri(Uri.parse(url.value))));
    title.value = await webViewController?.getTitle() ?? '';
  }

  Future<void> goBack(BuildContext context) async {
    bool canBack = await webViewController!.canGoBack();
    if (canBack) {
      webViewController!.goBack();
    } else {
      popScreen();
    }
  }

  void updateUrl(String newUrl) async {
    url.value = newUrl;
  }

  Future<void> onRefresh() async {
    if (Platform.isAndroid) {
      webViewController?.reload();
    } else if (Platform.isIOS) {
      webViewController?.loadUrl(
          urlRequest: URLRequest(url: await webViewController?.getUrl()));
    }
  }

  void updateProgress(
      InAppWebViewController? controller, int? newProgress) async {
    if (progress.value == 100) {
      pullToRefreshController.endRefreshing();
    }
    pullToRefreshController.isRefreshing().then((value) {
      if (value) {
        reloading.value = true;
      } else {
        reloading.value = false;
      }
    });
    progress.value = (newProgress! / double.parse('100'));
    title.value = await controller?.getTitle() ?? '';
  }
}

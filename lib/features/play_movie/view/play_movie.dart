import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../core/router/router_imports.dart';
import '../../../core/constants/app_color.dart';
import '../view_model/play_view_model.dart';

class PlayMovie extends StatelessWidget {
  const PlayMovie({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayViewModel>(
        init: PlayViewModel(url),
        builder: (playViewModel) => Scaffold(
            appBar: AppBar(
              title: Obx(() => Text(
                    playViewModel.title.value,
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
              titleSpacing: 0.0,
              leading: IconButton(
                onPressed: () {
                  popScreen();
                },
                icon: const Icon(CupertinoIcons.back),
              ),
            ),
            body: _bodyUI(playViewModel)));
  }

  Obx _bodyUI(PlayViewModel playViewModel) => Obx(() => Stack(
        alignment: Alignment.center,
        children: [
          Column(children: [
            if (playViewModel.progress.value != 1.0 &&
                playViewModel.reloading.value == false)
              LinearProgressIndicator(
                value: playViewModel.progress.value,
                color: AppColors.secondaryColor,
              ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse(playViewModel.url.value))),
                pullToRefreshController: playViewModel.pullToRefreshController,
                onWebViewCreated: (updatedController) {
                  playViewModel.webViewController = updatedController;
                },
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  allowsInlineMediaPlayback: true,
                  preferredContentMode: UserPreferredContentMode.MOBILE,
                ),
                onProgressChanged:
                    (InAppWebViewController? updatedController, int? progress) {
                  playViewModel.updateProgress(updatedController, progress);
                },
                onLoadStop: (updatedController, url) async {
                  playViewModel.pullToRefreshController.endRefreshing();
                },
                onReceivedError: (updatedController, url, error) {
                  playViewModel.pullToRefreshController.endRefreshing();
                },
                onUpdateVisitedHistory:
                    (updatedController, url, androidIsReload) async {
                  playViewModel.updateUrl(url.toString());
                },
              ),
            )
          ]),
        ],
      ));
}

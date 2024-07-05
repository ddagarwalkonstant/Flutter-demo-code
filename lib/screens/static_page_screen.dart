import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/debug_utils/debug_utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant/AppStrings.dart';
import '../utils/commonWidget.dart';

class StaticPageScreen extends StatefulWidget {
  String title;

  StaticPageScreen(this.title, {super.key});

  @override
  State<StatefulWidget> createState() => StaticPageScreenState();
}

class StaticPageScreenState extends State<StaticPageScreen> {

  var urlRequest = '';
  final _controller = WebViewController();
  CommonWidget commonWidget=CommonWidget();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCommonFeatures().contextInit(context);
    _loadData();
  }

  _loadData() async {


    String baseUrl = "${AppCommonFeatures.instance.baseUrlApp}/api/static-pages/";
    if (widget.title == AppStrings.terms_condition) {
      urlRequest = '${baseUrl}terms-condition';
    } else if (widget.title == AppStrings.privacy_policy) {
      urlRequest = '${baseUrl}privacy-policy';
    } else if (widget.title == AppStrings.faq) {
      urlRequest = '${baseUrl}about-us';
    }

    DebugUtils.showLog(urlRequest);

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // print the loading progress to the console
            // you can use this value to show a progress bar if you want
            debugPrint("Loading: $progress%");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(urlRequest));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonWidget.getAppBar(context, widget.title),
      body: WebViewWidget(controller: _controller),
    );
  }

}

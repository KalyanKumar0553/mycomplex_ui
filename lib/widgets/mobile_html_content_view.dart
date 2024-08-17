import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class MobileHtmlContentView extends StatefulWidget {
  
  final String urlToDisplay;
  
  const MobileHtmlContentView({
    Key? key,
    required this.urlToDisplay,
  }) : super(key: key);

  @override
  _MobileHtmlContentViewState createState() => _MobileHtmlContentViewState();
}

class _MobileHtmlContentViewState extends State<MobileHtmlContentView> {
    
  late final PlatformWebViewController _webViewController;
  

  void _loadHtmlFromApi() async {
    _webViewController = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
      LoadRequestParams(
        uri: Uri.parse(widget.urlToDisplay),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadHtmlFromApi();
  }



  @override
  Widget build(BuildContext context) {
    return PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _webViewController),
    ).build(context);
  }
}
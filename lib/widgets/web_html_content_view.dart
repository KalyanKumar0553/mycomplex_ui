import 'dart:io' as io; // For detecting mobile platforms (iOS/Android)
import 'package:flutter/material.dart'; // Core Flutter package
import 'dart:ui' as ui; // For web-based HTML rendering
import 'dart:html' as html; // For using HTML elements in Flutter web

class WebHtmlContentView extends StatefulWidget {
  
  final String urlToDisplay;
  
  const WebHtmlContentView({
    Key? key,
    required this.urlToDisplay,
  }) : super(key: key);

  @override
  _WebHtmlContentViewState createState() => _WebHtmlContentViewState();
}

class _WebHtmlContentViewState extends State<WebHtmlContentView> {
  @override
  void initState() {
    super.initState();

    // Register a view type for rendering the HTML content in web
    ui.platformViewRegistry.registerViewFactory(
      'html-view',
      (int viewId) => html.IFrameElement()
        ..src = widget.urlToDisplay
        ..style.border = 'none',
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: 'html-view');
  }
}
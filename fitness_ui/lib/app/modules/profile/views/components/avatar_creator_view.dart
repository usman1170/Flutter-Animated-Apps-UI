import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';

class AvatarCreatorView extends StatefulWidget {
  final Function(String) onAvatarExported;

  const AvatarCreatorView({super.key, required this.onAvatarExported});

  @override
  State<AvatarCreatorView> createState() => _AvatarCreatorViewState();
}

class _AvatarCreatorViewState extends State<AvatarCreatorView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..addJavaScriptChannel(
        'ReadyPlayerMe',
        onMessageReceived: (JavaScriptMessage message) {
          widget.onAvatarExported(message.message);
          Get.back();
        },
      )
      ..loadHtmlString(_getHtmlContent());
  }

  String _getHtmlContent() {
    return '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Ready Player Me</title>
          <style>
              html, body {
                  margin: 0;
                  padding: 0;
                  width: 100%;
                  height: 100%;
                  overflow: hidden;
              }
              iframe {
                  width: 100%;
                  height: 100%;
                  border: none;
              }
          </style>
      </head>
      <body>
          <iframe id="frame" src="https://demo.readyplayer.me/avatar?frameApi&clearCache" allow="camera *; microphone *; clipboard-write"></iframe>
          <script>
              const frame = document.getElementById('frame');
              
              window.addEventListener('message', subscribe);
              document.addEventListener('message', subscribe);

              function subscribe(event) {
                  const json = parse(event);
                  if (json?.source !== 'readyplayerme') {
                      return;
                  }

                  // Subscribe to all events
                  if (json.eventName === 'v1.frame.ready') {
                      frame.contentWindow.postMessage(
                          JSON.stringify({
                              target: 'readyplayerme',
                              type: 'subscribe',
                              eventName: 'v1.**'
                          }),
                          '*'
                      );
                  }

                  // Intercept avatar URL
                  if (json.eventName === 'v1.avatar.exported') {
                      ReadyPlayerMe.postMessage(json.data.url);
                  }
              }

              function parse(event) {
                  try {
                      return typeof event.data === 'string' ? JSON.parse(event.data) : event.data;
                  } catch (error) {
                      return null;
                  }
              }
          </script>
      </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Customize Avatar',
          style: TextStyle(fontFamily: 'Orbitron'),
        ),
        backgroundColor: AppColors.navBarBackground,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

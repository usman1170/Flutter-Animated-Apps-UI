import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import 'avatar_model_loader.dart';

class AvatarModelStage extends StatefulWidget {
  const AvatarModelStage({
    super.key,
    required this.avatarPath,
    required this.goalMode,
  });

  final String avatarPath;
  final bool goalMode;

  @override
  State<AvatarModelStage> createState() => _AvatarModelStageState();
}

class _AvatarModelStageState extends State<AvatarModelStage> {
  bool _isModelReady = false;

  @override
  void initState() {
    super.initState();
    _isModelReady = false;
  }

  @override
  void didUpdateWidget(covariant AvatarModelStage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.avatarPath != widget.avatarPath) {
      setState(() {
        _isModelReady = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ModelViewer(
          key: ValueKey(widget.avatarPath),
          backgroundColor: Colors.transparent,
          src: widget.avatarPath,
          alt: 'A 3D model of a rigged human',
          ar: false,
          autoRotate: !widget.goalMode,
          cameraControls: true,
          disableZoom: true,
          id: 'playerfit-avatar',
          javascriptChannels: {
            JavascriptChannel(
              'PlayerFitAvatarState',
              onMessageReceived: (message) {
                if (message.message == 'ready' && mounted && !_isModelReady) {
                  setState(() {
                    _isModelReady = true;
                  });
                }
              },
            ),
          },
          relatedJs: '''
            const playerfitAvatar = document.getElementById('playerfit-avatar');
            const playerfitNotifyReady = () => {
              PlayerFitAvatarState.postMessage('ready');
            };
            if (playerfitAvatar) {
              playerfitAvatar.addEventListener('load', playerfitNotifyReady, { once: true });
              playerfitAvatar.addEventListener('model-visibility', playerfitNotifyReady, { once: true });
            }
          ''',
        ),
        IgnorePointer(
          ignoring: _isModelReady,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 280),
            opacity: _isModelReady ? 0 : 1,
            child: const AvatarModelLoader(),
          ),
        ),
      ],
    );
  }
}

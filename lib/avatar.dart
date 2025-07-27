import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key, required this.title});

  final String title;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String? srcGlb;
  String? lastValidSrcGlb;

  @override
  void initState() {
    super.initState();
    loadAvatar(widget.title);
  }

  // Add didUpdateWidget to handle title changes
  @override
  void didUpdateWidget(covariant Avatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title) {
      loadAvatar(widget.title);
    }
  }

  void loadAvatar(String title) {
    debugPrint("Loading avatar for: $title");
    if (title == "ask") {
      srcGlb = 'assets/ask.glb';
    } else if (title == "wait") {
      srcGlb = 'assets/wait.glb';
    } else if (title == "wrong") {
      srcGlb = 'assets/wrong.glb';
    } else if (title == "correct") {
      srcGlb = 'assets/waving.glb';
    } else {
      srcGlb = null;
    }
    if (srcGlb != null) {
      lastValidSrcGlb = srcGlb;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Always show the last valid model if available
    if (lastValidSrcGlb == null) {
      return const SizedBox.shrink(); // Show nothing if no model ever loaded
    }
    return SafeArea(
      child: SizedBox(
        width: 500,
        height: 300,
        child: ModelViewer(
          key: ValueKey(lastValidSrcGlb),
          src: lastValidSrcGlb!,
          alt: "3D avatar model",
          cameraControls: false,
          autoPlay: true,
          backgroundColor: Colors.transparent,
          cameraOrbit: '0deg 90deg 100m',
          fieldOfView: '40deg',
          cameraTarget: "0m 0.7m 0m",
        ),
      ),
    );
  }
}
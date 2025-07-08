import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class BearAnimationWidget extends StatefulWidget {
  final void Function(BearAnimationController controller)? onControllerReady;

  const BearAnimationWidget({Key? key, this.onControllerReady}) : super(key: key);

  @override
  State<BearAnimationWidget> createState() => _BearAnimationWidgetState();
}

class _BearAnimationWidgetState extends State<BearAnimationWidget> {
  Artboard? _artboard;
  late BearAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final data = await rootBundle.load('assets/wave,_hear_and_talk.riv');
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;

    final stateMachineController =
    StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (stateMachineController != null) {
      artboard.addController(stateMachineController);
      _controller = BearAnimationController(stateMachineController);

      widget.onControllerReady?.call(_controller);
    }

    setState(() {
      _artboard = artboard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _artboard != null
        ? Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 500, // You can increase this to 450 or 500
          height: 400,
          child: Rive(artboard: _artboard!),
        ),
      ),
    )
        : const SizedBox(height: 250);

  }
}

// Controller to expose animation triggers
class BearAnimationController {
  final StateMachineController controller;

  late final SMIInput<bool>? _talk = controller.findInput('Talk');
  late final SMIInput<bool>? _hear = controller.findInput('Hear');
  late final SMIInput<bool>? _check = controller.findInput('Check');
  late final SMIInput<bool>? _success = controller.findInput('success');
  late final SMIInput<bool>? _fail = controller.findInput('fail');

  BearAnimationController(this.controller);

  void playTalk() => _trigger(_talk);
  void playHear() => _trigger(_hear);
  void playSuccess() => _trigger(_success);
  void playFail() => _trigger(_fail);

  void _trigger(SMIInput<bool>? input) {
    if (input == null) return;
    input.value = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      input.value = false;
    });
  }
}

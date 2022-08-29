import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullPageImageView extends StatefulWidget {
  const FullPageImageView({Key? key, required this.snap}) : super(key: key);
  final snap;

  @override
  State<FullPageImageView> createState() => _FullPageImageViewState();
}

class _FullPageImageViewState extends State<FullPageImageView> {
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        clipBehavior: Clip.none,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          // color: Colors.red,
          child: Image.network(widget.snap["postUrl"]),
        ),
      ),
    );
  }
}

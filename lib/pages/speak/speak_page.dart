import 'package:flutter/material.dart';

class SpeakPage extends StatefulWidget {
  const SpeakPage({super.key});

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> {
  String speakTips = "长按说话";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_bottomItem()],
          ),
        ),
      ),
    );
  }

  _bottomItem() {
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (e) {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    speakTips,
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            right: 0,
            bottom: 26,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 26,
                color: Colors.grey,
              ),
            ))
      ],
    );
  }
}

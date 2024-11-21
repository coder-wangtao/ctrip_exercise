import 'package:flutter/material.dart';

class GridNavWidget extends StatefulWidget {
  const GridNavWidget({super.key});

  @override
  State<GridNavWidget> createState() => _GridNavWidgetState();
}

class _GridNavWidgetState extends State<GridNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 72,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xfffa5956),
              Color(0xffef9c76).withAlpha(45)
            ])),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 110,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: Colors.white, width: 1))),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image.asset(
                          "images/grid-nav-items-hotel.png",
                          width: 70,
                          fit: BoxFit.contain,
                          alignment: AlignmentDirectional.bottomEnd,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            "酒店",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

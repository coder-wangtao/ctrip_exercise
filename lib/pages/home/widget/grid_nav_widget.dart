import 'package:flutter/material.dart';

class GridNavWidget extends StatefulWidget {
  const GridNavWidget({super.key});

  @override
  State<GridNavWidget> createState() => _GridNavWidgetState();
}

class _GridNavWidgetState extends State<GridNavWidget> {
  @override
  Widget build(BuildContext context) {
    //PhysicalModel做圆角
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias, //图形边缘会更加平滑，避免锯齿效果。
      child: Container(
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
                      //设置边框
                      decoration: BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(color: Colors.white, width: 1))),
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.white, width: 1))),
                        child: Stack(
                          children: [
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: Image.asset(
                                  "images/grid-nav-items-minsu.png",
                                  width: 32,
                                  fit: BoxFit.contain,
                                )),
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "民宿·客栈",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xffffbc49),
                            Color(0xffffd252)
                          ])),
                          child: Stack(
                            children: [
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    "images/grid-nav-items-jhj.png",
                                    width: 90,
                                    fit: BoxFit.contain,
                                  )),
                              Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "机票/火车票+酒店",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xffa05416)),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 24,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(4, 0, 4, 2),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff54c45),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(5),
                                      )),
                                  child: Text(
                                    "方便又便宜",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 1)),
            Container(
              height: 72,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff4b8fed),
                Color(0xff53bced),
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
                              right:
                                  BorderSide(color: Colors.white, width: 1))),
                      child: Stack(
                        children: [
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                "images/grid-nav-items-flight.png",
                                width: 70,
                                fit: BoxFit.contain,
                              )),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "机票",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(width: 1, color: Colors.white))),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 0,
                                child: Image.asset(
                                  "images/grid-nav-items-train.png",
                                  width: 32,
                                  fit: BoxFit.contain,
                                )),
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                '火车票',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: double.infinity,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(width: 1, color: Colors.white))),
                        child: Text(
                          '汽车·船票',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(width: 1, color: Colors.white))),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            '专车·租车',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 1)),
            Container(
              height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff34c2aa),
                  Color(0xff6cd557),
                ]),
              ),
              child: Row(children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1, color: Colors.white))),
                    child: Stack(
                      children: [
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image.asset(
                              'images/grid-nav-items-travel.png',
                              width: 80,
                              fit: BoxFit.contain,
                            )),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            "旅游",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: Image.asset(
                                'images/grid-nav-items-dingzhi.png',
                                width: 40,
                                fit: BoxFit.contain,
                              )),
                          Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "高铁游",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "邮轮游",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "定制游",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

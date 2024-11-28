import 'package:flutter/material.dart';

class VerticalTabView extends StatefulWidget {
  final int? initialIndex;
  final double? tabsWidth; //左侧tab的宽度
  final List<Tab>? tabs; //左侧tab的列表项
  final List<Widget>? contents;
  final TextDirection direction;
  final bool? disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color? selectedTabBackgroundColor; //选中时左侧tab的背景颜色
  final Color? tabBackgroundColor; //左侧tab的背景颜色
  final TextStyle? selectedTabTextStyle;
  final TextStyle? tabTextStyle;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final Color? tabsShadowColor; ////左侧tab的阴影的颜色
  final double? tabsElevation; //左侧tab的阴影
  final Function(int tabIndex)? onSelect;
  final Color? backgroundColor;
  const VerticalTabView(
      {super.key,
      this.initialIndex = 0,
      this.tabsWidth,
      this.tabs,
      this.contents,
      this.direction = TextDirection.ltr,
      this.disabledChangePageFromContentView = false,
      this.contentScrollAxis = Axis.horizontal,
      this.selectedTabBackgroundColor = const Color(0x1100ff00),
      this.tabBackgroundColor = const Color(0xfff8f8f8),
      this.selectedTabTextStyle,
      this.tabTextStyle,
      this.changePageDuration = const Duration(microseconds: 300),
      this.changePageCurve = Curves.easeInOut,
      this.tabsShadowColor,
      this.tabsElevation,
      this.onSelect,
      this.backgroundColor});

  @override
  State<VerticalTabView> createState() => _VerticalTabViewState();
}

class _VerticalTabViewState extends State<VerticalTabView>
    with TickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController animationController;
  List<AnimationController> animationControllers = [];
  ScrollPhysics pageScrollPhysics = AlwaysScrollableScrollPhysics();
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = widget.initialIndex!;
    for (int i = 0; i < widget.tabs!.length; i++) {
      animationControllers.add(AnimationController(
          vsync: this, duration: const Duration(microseconds: 400)));
    }
    _selectTab(widget.initialIndex);

    //是否禁用滚动
    if (widget.disabledChangePageFromContentView == true) {
      pageScrollPhysics = NeverScrollableScrollPhysics();
    }
    super.initState();

    //这段代码的主要目的是在构建页面完成后，立即跳转到指定的初始页面
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.initialIndex!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      //从左到右布局
      textDirection: widget.direction,
      child: Container(
        color: widget.backgroundColor ?? Theme.of(context).canvasColor,
        child: Row(
          children: [
            Material(
              child: Container(
                width: widget.tabsWidth,
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: widget.tabs?.length,
                        itemBuilder: (context, index) {
                          Tab? tab = widget?.tabs?[index];
                          Alignment alignment = Alignment.centerLeft;
                          if (widget.direction == TextDirection.rtl) {
                            alignment = Alignment.centerRight;
                          }
                          Widget? child;
                          if (tab?.child != null) {
                            child = tab?.child;
                          } else {
                            child = Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  tab?.icon != null
                                      ? Row(
                                          children: [
                                            tab!.icon!,
                                            SizedBox(width: 5)
                                          ],
                                        )
                                      : Container(),
                                  tab?.text != null
                                      ? Container(
                                          width: widget.tabsWidth! - 50,
                                          child: Text(
                                            tab!.text!,
                                            softWrap: true,
                                            style: _selectedIndex == index
                                                ? widget.selectedTabTextStyle
                                                : widget.tabTextStyle,
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            );
                          }

                          Color? itemBGColor = widget.tabBackgroundColor;
                          if (_selectedIndex == index) {
                            itemBGColor = widget.selectedTabBackgroundColor;
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectTab(index);
                              });
                              pageController.animateToPage(index,
                                  duration: widget.changePageDuration,
                                  curve: widget.changePageCurve);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: itemBGColor,
                              ),
                              alignment: alignment,
                              padding: EdgeInsets.all(5),
                              child: child,
                            ),
                          );
                        })),
              ),
              elevation: widget.tabsElevation ?? 0,
              shadowColor: widget.tabsShadowColor,
              shape: const BeveledRectangleBorder(), //矩形边框
            ),
            Expanded(
                child: PageView.builder(
                    scrollDirection: widget.contentScrollAxis,
                    physics: pageScrollPhysics,
                    onPageChanged: (index) {
                      setState(() {
                        _selectTab(index);
                      });
                    },
                    controller: pageController,
                    itemCount: widget.contents!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.contents![index];
                    }))
          ],
        ),
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    if (animationControllers.length != 0) {
      animationControllers[index].forward();
    }
    if (widget.onSelect != null) {
      widget.onSelect!(_selectedIndex);
    }
  }
}

import 'package:flutter/material.dart' hide Action;
import 'package:places/res/decorations.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:relation/relation.dart';

/// [TabIndicator] displays the indication of tabs for the "Favorites" page.
/// Accepts a [tabController] tab controller as parameters.
class TabIndicator extends StatefulWidget {
  final TabController tabController;

  final Action<void> clickOnTabAction;

  const TabIndicator({
    Key key,
    this.tabController,
    this.clickOnTabAction,
  }) : super(key: key);

  @override
  _TabIndicatorState createState() => _TabIndicatorState();
}

class _TabIndicatorState extends State<TabIndicator>
    with SingleTickerProviderStateMixin {
  // Animation controller
  AnimationController _animationController;

  // Animation of the offset when swiping
  Animation<Offset> _swipeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    _swipeAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    super.initState();
  }

  void _changeActiveTab() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    // Invert the current value of the tab controller
    widget.tabController.index == 1
        ? widget.clickOnTabAction(0)
        : widget.clickOnTabAction(1);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: AppDecorations.tabIndicatorContainer.copyWith(
          color: Theme.of(context)
              .tabBarTheme
              .unselectedLabelStyle
              .backgroundColor,
        ),
        width: double.infinity,
        height: 40,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return GestureDetector(
              // Tracking horizontal swipe
              onHorizontalDragEnd: (_) => _changeActiveTab(),
              child: Stack(
                children: [
                  // Container for text tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int tabIndex = 0;
                          tabIndex < widget.tabController.length;
                          tabIndex++)
                        Expanded(
                          child: InkWell(
                            // Track the click
                            onTap: () => _changeActiveTab(),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Center(
                              child: Opacity(
                                opacity: widget.tabController.index == tabIndex
                                    ? 0
                                    : _swipeAnimation.value.distance + 0.5,
                                child: Text(
                                  tabIndex == 0
                                      ? AppTextStrings.visitedTab
                                      : AppTextStrings.toVisitTab,
                                  style: AppTextStyles.visitingScreenInactiveTab
                                      .copyWith(
                                    color: Theme.of(context)
                                        .tabBarTheme
                                        .unselectedLabelStyle
                                        .color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // The container of the switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _swipeAnimation,
                        child: Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            child: FlatButton(
                              onPressed: () => _changeActiveTab(),
                              height: 40,
                              shape:
                                  AppDecorations.tabIndicatorContainerElement,
                              color: Theme.of(context)
                                  .tabBarTheme
                                  .labelStyle
                                  .backgroundColor,
                              child: Center(
                                child: Text(
                                  _swipeAnimation.value.dx <= 0
                                      ? AppTextStrings.visitedTab
                                      : AppTextStrings.toVisitTab,
                                  style: AppTextStyles.visitingScreenActiveTab
                                      .copyWith(
                                    color: Theme.of(context)
                                        .tabBarTheme
                                        .labelStyle
                                        .color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

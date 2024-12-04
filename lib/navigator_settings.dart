/// This file contains the app settings for Navigation

import 'package:flutter/material.dart';

// cool page transition
import 'package:page_transition/page_transition.dart';
export 'package:page_transition/page_transition.dart' show PageTransitionType;

/// all the logic related to navigation is here
abstract class AppNavigationHandler {
  /// The Navigator Key will be used to navigate in the app
  static final GlobalKey<NavigatorState> appNavigatorKey =
      GlobalKey<NavigatorState>();

  /// get the main app context to use to look up the widget tree
  static BuildContext get getBuildContext =>
      appNavigatorKey.currentState!.context;

  /// The app pages Transitions speeds
  ///
  /// The fastest is [pageTransitionSpeed1] the slowest is [pageTransitionSpeed5]
  ///
  /// ```Duration(milliseconds: 200)```
  static const Duration pageTransitionSpeed1 = Duration(milliseconds: 200);

  /// ```Duration(milliseconds: 300)```
  static const Duration pageTransitionSpeed2 = Duration(milliseconds: 300);

  /// ```Duration(milliseconds: 400)```
  static const Duration pageTransitionSpeed3 = Duration(milliseconds: 400);

  /// ```Duration(milliseconds: 600)```

  static const Duration pageTransitionSpeed4 = Duration(milliseconds: 600);

  /// ```Duration(milliseconds: 800)```

  static const Duration pageTransitionSpeed5 = Duration(milliseconds: 800);

  /// ```Duration(milliseconds: 1000)```

  static const Duration pageTransitionSpeed6 = Duration(milliseconds: 1000);

  /// The app Curves
  static const Curve curveEaseInOut = Curves.easeInOut;

  /// push a page
  ///
  /// bool [popAllScreenFirst] pop all screen before bush. Note: [usePushReplacement] will
  /// be true if [popAllScreenFirst] is true
  ///
  /// bool [usePushReplacement] mean use [pushReplacement] when push
  static Future pushPage({
    required Widget childPageToPage,
    bool popAllScreenFirst = false,

    // push duration animation
    Duration pageTransitionSpeed = pageTransitionSpeed1,
    bool usePushReplacement = false,
    PageTransitionType transitionType = PageTransitionType.fade,
    Curve curve = Curves.linear,
    bool opaque = false,
  }) async {
    // pop all screens
    if (popAllScreenFirst) {
      popAllPagesExceptFirstScreen();
      usePushReplacement = true;
    }

    if (usePushReplacement) {
      return await appNavigatorKey.currentState!.pushReplacement(
        PageTransition(
          type: transitionType,
          opaque: opaque,
          child: childPageToPage,
          duration: pageTransitionSpeed,
          reverseDuration: pageTransitionSpeed,
          curve: curve,
        ),
      );
    } else {
      return await appNavigatorKey.currentState!.push(
        PageTransition(
          type: transitionType,
          opaque: opaque,
          child: childPageToPage,
          duration: pageTransitionSpeed,
          reverseDuration: pageTransitionSpeed,
          curve: curve,
        ),
      );
    }
  }

  /// pop one page
  static void popPage([popResult]) {
    return appNavigatorKey.currentState!.pop(popResult);
  }

  /// pop all screens except the first one
  static void popAllPagesExceptFirstScreen() {
    return appNavigatorKey.currentState!.popUntil((p) => p.isFirst);
  }

  /// is the page can be popped
  static bool canPopPage() {
    return appNavigatorKey.currentState!.canPop();
  }

  /// pushes a Dialog screen with [showDialog]
  static Future pushDialog({
    required Widget childPageToPage,
    bool barrierDismissible = true,
  }) async {
    return await showDialog(
      context: AppNavigationHandler.getBuildContext,
      barrierDismissible: barrierDismissible,
      builder: (context) => childPageToPage,
    );
  }

  /// close the Keyboard
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

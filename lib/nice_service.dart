library nice_service;

import 'package:flutter/material.dart';
import 'package:nice_service/nice_service.dart';

export './src/utils/exports.dart';
export './src/extensions/exports.dart';
export './src/locale/exports.dart';

class NSNavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    NS._routeHistory.add(route.settings);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    NS._routeHistory.removeLast();
    NS._routeHistory.add(newRoute?.settings);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    NS._routeHistory.removeLast();
  }
}

class NS {
  const NS._();
  static final List<RouteSettings?> _routeHistory = [];
  static List<RouteSettings?> get routeHistory => _routeHistory;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;
//  static RouteSettings? get routeSettings =>
//       context != null ? ModalRoute.of(context!)?.settings : null;
  static RouteSettings? get routeSettings => routeHistory.lastOrNull;

  static String? get currentRoute => routeSettings?.name;
  static Object? get arguments => routeSettings?.arguments;

  static Locale? get locale => NSRoot.of(context)?.locale;
  // static Locale? get locale =>
  //     context != null ? Localizations.maybeLocaleOf(context!) : null;
  static set locale(Locale? v) => NSRoot.of(context)?.setLocale(v);
  static setLocale(Locale? v, {BuildContext? context}) =>
      NSRoot.of(context ?? NS.context)?.setLocale(v);

  static ThemeData? get theme => context != null ? Theme.of(context!) : null;
  static MediaQueryData? get mediaQuery =>
      context != null ? MediaQuery.of(context!) : null;

  static bool get isDarkMode => (theme?.brightness == Brightness.dark);

  static ThemeMode? get themeMode => NSRoot.of(context)?.themeMode;
  static set themeMode(ThemeMode? v) => NSRoot.of(context)?.setTheme(v);
  static setThemeMode(ThemeMode? v, {BuildContext? context}) =>
      NSRoot.of(context ?? NS.context)?.setTheme(v);

  static NavigatorState? _nState(BuildContext? context) {
    return (context != null && context.mounted)
        ? Navigator.of(context)
        : navigatorKey.currentState;
  }

  // Navigation Methods
  static void pop({BuildContext? context, dynamic result}) {
    return _nState(context)?.pop(result);
  }

  static Future<T?>? push<T extends Object?>(
    Route<T> route, {
    BuildContext? context,
  }) {
    return _nState(context)?.push<T>(route);
  }

  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    BuildContext? context,
  }) {
    return _nState(context)?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static void popUntil(
    RoutePredicate predicate, {
    BuildContext? context,
  }) {
    return _nState(context)?.popUntil(predicate);
  }

  static Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
    BuildContext? context,
  }) {
    return _nState(context)?.popAndPushNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static Future<T?>?
      pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
    BuildContext? context,
  }) {
    return _nState(context)?.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static Future<T?>? pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
    BuildContext? context,
  }) {
    return _nState(context)?.pushReplacement<T, TO>(
      newRoute,
      result: result,
    );
  }

  static void replace<T extends Object?>({
    required Route<dynamic> oldRoute,
    required Route<T> newRoute,
    BuildContext? context,
  }) {
    return _nState(context)?.replace<T>(
      oldRoute: oldRoute,
      newRoute: newRoute,
    );
  }

  static void replaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required Route<T> newRoute,
    BuildContext? context,
  }) {
    return _nState(context)?.replaceRouteBelow<T>(
      anchorRoute: anchorRoute,
      newRoute: newRoute,
    );
  }

  static bool? get canPop => _nState(context)?.canPop();

  static Future<bool>? maybePop<T extends Object?>({
    T? result,
    BuildContext? context,
  }) {
    return _nState(context)?.maybePop<T>(result);
  }

  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
    BuildContext? context,
  }) {
    return _nState(context)?.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static Future<T?>? pushAndRemoveUntil<T extends Object?>(
    Route<T> newRoute,
    RoutePredicate predicate, {
    BuildContext? context,
  }) {
    return _nState(context)?.pushAndRemoveUntil<T>(
      newRoute,
      predicate,
    );
  }

  // Dialog Methods
  static Future<T?> dialog<T extends Object?>(
    Widget child, {
    String? name,
    Object? arguments,
    bool barrierDismissible = true,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    Color? barrierColor,
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    // Use exist context
    BuildContext? context,
  }) async {
    final BuildContext? bc = context ?? navigatorKey.currentContext;
    if (bc != null) {
      final theme = Theme.of(bc);
      return await showGeneralDialog<T>(
        context: bc,
        pageBuilder: (buildContext, animation, secondaryAnimation) {
          final pageChild = child;
          Widget dialog = Builder(builder: (context) {
            return Theme(data: theme, child: pageChild);
          });
          if (useSafeArea) {
            dialog = SafeArea(child: dialog);
          }
          return dialog;
        },
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor ?? const Color(0x80000000),
        barrierLabel: MaterialLocalizations.of(bc).modalBarrierDismissLabel,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder ??
            (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInCubic,
                ),
                child: Transform.scale(
                  scale: (animation.value * 0.5 + 0.5).clamp(0, 1),
                  child: child,
                ),
              );
            },
        routeSettings: routeSettings ??
            (name != null || arguments != null
                ? RouteSettings(
                    name: name,
                    arguments: arguments,
                  )
                : null),
        useRootNavigator: useRootNavigator,
        anchorPoint: anchorPoint,
      );
    }
    return null;
  }

  static Future<T?> bottomSheet<T extends Object?>(
    Widget child, {
    String? name,
    Object? arguments,
    // Extras
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    double scrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
    // BuildContext
    BuildContext? context,
  }) async {
    final BuildContext? bc = context ?? navigatorKey.currentContext;
    if (bc != null) {
      return await showModalBottomSheet<T>(
        context: bc,
        builder: (_) => child,
        backgroundColor: backgroundColor,
        barrierLabel: barrierLabel,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        scrollControlDisabledMaxHeightRatio:
            scrollControlDisabledMaxHeightRatio,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings ??
            (name != null || arguments != null
                ? RouteSettings(name: name, arguments: arguments)
                : null),
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
        sheetAnimationStyle: sheetAnimationStyle,
      );
    }
    return null;
  }

  /// Conversion methods 数据转换为Flutter
  static FontWeight fontWeightFromData(
    dynamic data, {
    FontWeight defaultValue = FontWeight.normal,
  }) {
    final String str = tString(data).toLowerCase().trim();
    switch (str) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      default:
    }
    final int number = tInt(data);
    if (number > 0) {
      if (number >= 100 && number < 350) {
        return FontWeight.w300;
      }
      if (number >= 350 && number < 450) {
        return FontWeight.w400;
      }
      if (number >= 450 && number < 550) {
        return FontWeight.w500;
      }
      if (number >= 550 && number < 650) {
        return FontWeight.w600;
      }
      if (number >= 650 && number < 750) {
        return FontWeight.w700;
      }
      if (number >= 750 && number < 850) {
        return FontWeight.w800;
      }
    }
    return defaultValue;
  }

  static TextAlign textAlignFromData(
    dynamic data, {
    TextAlign defaultValue = TextAlign.left,
  }) {
    final String str = tString(data).toLowerCase().trim();
    switch (str) {
      case 'left':
        return TextAlign.left;
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return defaultValue;
    }
  }

  static Color? colorFromHex(String? hexString) {
    if (hexString != null && hexString.isNotEmpty) {
      String validHex = hexString.replaceAll("#", "");

      if (validHex.length == 6) {
        validHex = "ff$validHex";
      }
      if (validHex.length == 8) {
        final buffer = StringBuffer();
        buffer.write(validHex);
        return Color(int.parse(buffer.toString(), radix: 16));
      }
    }
    return null;
  }
}

import 'package:flutter/widgets.dart';
import 'package:nice_service/nice_service.dart';

extension NSLocaleStringExt on String {
  String get tsl {
    return NSLocalizations.of(NS.context).translate(this);
  }

  String tslParams(
    Map<String, String> params, {
    String? pluralKey,
    num? plural,
  }) {
    return NSLocalizations.of(NS.context).translate(
      this,
      params: params,
      pluralKey: pluralKey,
      plural: plural,
    );
  }

  String translate(
    BuildContext? context, {
    Map<String, String>? params,
    String? pluralKey,
    num? plural,
  }) {
    return NSLocalizations.of(context ?? NS.context).translate(
      this,
      params: params,
      pluralKey: pluralKey,
      plural: plural,
    );
  }
}

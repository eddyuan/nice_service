import 'package:nice_service/nice_service.dart';

extension NSMapExt on Map {
  dynamic wild(List<String> keys) {
    dynamic result;
    for (String key in keys) {
      result = this[key] ??
          this[NSStringUtil.toCamelCase(key)] ??
          this[NSStringUtil.toSnakeCase(key)] ??
          this[key.toLowerCase()];
      if (result != null) {
        break;
      }
    }
    return result;
  }
}

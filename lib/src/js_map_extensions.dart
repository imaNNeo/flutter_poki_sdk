import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'flutter_poki_sdk_interop.dart' as interop;

extension JSObjectToMapExtension on JSObject {
  Map<String, String> get toDartMap => Map.fromIterable(
        interop.getKeysOfObject(this).toDart.map((e) => e.toDart),
        value: (key) => getProperty(key),
      );
}

extension JSMapToObjectExtension on Map<String, String> {
  JSObject get toJSObject {
    final jsObject = JSObject();
    for (var entry in entries) {
      jsObject.setProperty(entry.key.toJS, entry.value.toJS);
    }
    return jsObject;
  }
}

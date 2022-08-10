class JsonParser {
  JsonParser._internal();

  static final JsonParser _parser = JsonParser._internal();

  factory JsonParser() => _parser;

  List<T?>? parse<T>(dynamic json, {T? Function(Map<String, dynamic> data)? fromJson}) {
    return (json['keys'] as List).map((e) => fromJson?.call(json[e])).toList();
  }
}

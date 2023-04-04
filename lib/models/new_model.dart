import 'dart:convert';

class NewModel {
  final String new_content;

  final String new_img;

  final String new_subtitle;

  final String new_title;

  final String new_type;

  NewModel(
      {required this.new_content,
      required this.new_img,
      required this.new_subtitle,
      required this.new_title,
      required this.new_type});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'new_content': new_content});
    result.addAll({'new_img': new_img});
    result.addAll({'new_subtitle': new_subtitle});
    result.addAll({'new_title': new_title});
    result.addAll({'new_type': new_type});

    return result;
  }

  factory NewModel.fromMap(Map<String, dynamic> map) {
    return NewModel(
        new_content: map['new_content'] ?? '',
        new_img: map['new_img'] ?? '',
        new_subtitle: map['new_subtitle'] ?? '',
        new_title: map['new_title'] ?? '',
        new_type: map['new_type'] ?? '');
  }
  String toJson() => json.encode(toMap());

  factory NewModel.fromJson(String source) =>
      NewModel.fromMap(json.decode(source));
}

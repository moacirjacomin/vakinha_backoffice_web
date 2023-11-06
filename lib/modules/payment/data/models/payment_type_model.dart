import 'dart:convert';

import '../../domain/entities/payment_type_entity.dart';

class PaymentTypeModel extends PaymentTypeEntity {
  PaymentTypeModel({
    int? id,
    required String name,
    required String acronym,
    required bool enable,
  }) : super(
          id: id,
          name: name,
          acronym: acronym,
          enable: enable,
        );

  PaymentTypeModel copyWith({
    int? id,
    String? name,
    String? acronym,
    bool? enable,
  }) {
    return PaymentTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
      enable: enable ?? this.enable,
    );
  }

  @override
  String toString() {
    return 'PaymentTypeModel(id: $id, name: $name)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
      'acronym': acronym,
      'enable': enable,
    };
  }

  static List<PaymentTypeModel> fromJsonList(List<dynamic> json) {
    var list = <PaymentTypeModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => PaymentTypeModel.fromMap(jsomItem)).toList();
    }

    return list;
  }

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
      enable: map['enabled'] ?? true,
    );
  }

    toEntity() {
    return PaymentTypeEntity(
      id: id,
      name:name,
      acronym: acronym,
      enable: enable,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypeModel.fromJson(String source) => PaymentTypeModel.fromMap(json.decode(source));
}

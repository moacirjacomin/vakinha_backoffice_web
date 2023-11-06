

import 'package:equatable/equatable.dart';

class PaymentTypeEntity extends Equatable {
  final int? id;
  final String name;
  final String acronym;
  final bool enable;

  PaymentTypeEntity({
    this.id,
    required this.name,
    required this.acronym,
    required this.enable,
  });

  @override
  List<Object> get props => [name, acronym, enable];


}

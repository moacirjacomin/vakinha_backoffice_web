import 'package:flutter/material.dart';

enum OrderStatus {
  pendente('Pending', 'P', Colors.blue),
  confirmado('Confirmed', 'C', Colors.green),
  finalizado('Finalized', 'F', Colors.black),
  cancelado('Cancelled', 'R', Colors.red);

  final String name;
  final String acronym;
  final Color color;

  const OrderStatus(this.name, this.acronym, this.color);

  static OrderStatus parse(String acronym){
    return values.firstWhere((element) => element.acronym == acronym);
  }
}

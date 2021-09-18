import 'package:flutter/material.dart';

class AssociatedDrug {
  String? name;
  String? dose;
  String? strength;

  AssociatedDrug({
    this.name,
    this.dose,
    this.strength});

  AssociatedDrug.fromJson(Map<String, dynamic> json) {

    debugPrint('AssociatedDrug.fromJson :: $json');

    name = json['name'];
    dose = json['dose'];
    strength = json['strength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dose'] = dose;
    data['strength'] = strength;
    return data;
  }
}



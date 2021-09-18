import 'package:flutter/material.dart';
import 'package:volv_message/models/associated_drug.dart';

class MedicineNotifier with ChangeNotifier {

  List<AssociatedDrug> dragList = [];

  setDragList(List<AssociatedDrug> dragList) {
    this.dragList = dragList;
    notifyListeners();
  }

  List<AssociatedDrug> getDragList() {
    return dragList;
  }
}

import 'package:volv_message/models/associated_drug.dart';

class DrugViewModel  {
  AssociatedDrug? _drug;

  setDrag(AssociatedDrug drag) {
    _drug = drag;
  }

  AssociatedDrug? get drug => _drug;
}

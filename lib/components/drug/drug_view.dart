import 'package:flutter/material.dart';
import 'package:volv_message/components/drug/drug_view_model.dart';
import 'package:volv_message/models/associated_drug.dart';

class DragView extends StatelessWidget {
  final AssociatedDrug drug;
  late DrugViewModel drugViewModel;

  DragView(this.drug) {
    drugViewModel = DrugViewModel();
    drugViewModel.setDrag(drug);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(drugViewModel.drug!.name!,
                style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),

          const Expanded(
            flex: 0,
            child: Divider(
              height: 1,
            ),
          ),

          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Dose: ${drugViewModel.drug!.dose!}",
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Strength: ${drugViewModel.drug!.strength!}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

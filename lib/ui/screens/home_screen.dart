import 'package:flutter/material.dart';
import 'package:volv_message/components/drug/drug_view.dart';
import 'package:volv_message/data/services/api_service.dart';
import 'package:volv_message/notifiers/home_notifier.dart';
import 'package:volv_message/notifiers/medicine_notifier.dart';
import 'package:provider/provider.dart';
import 'package:volv_message/utils/greeting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    MedicineNotifier medicineNotifier =
        Provider.of<MedicineNotifier>(context, listen: false);
    ApiService.getMedicine(medicineNotifier, context);

    context.read<HomeNotifier>().getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Volv MVVM"),
          actions: [
            TextButton(
                onPressed: () =>
                    context.read<HomeNotifier>().logoutTap(context),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: Column(
          children: [
            Container(
                height: 100,
                alignment: Alignment.center,
                child: Text('${greeting()} ${context.watch<HomeNotifier>().username}')),
            Expanded(
              child: context.watch<MedicineNotifier>().dragList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount:
                          context.watch<MedicineNotifier>().dragList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final drag =
                            context.watch<MedicineNotifier>().dragList[index];
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          key: ObjectKey(drag),
                          child: DragView(
                            drag,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}

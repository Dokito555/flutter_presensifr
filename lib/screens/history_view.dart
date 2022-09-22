import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensifr/provider/history_provider.dart';
import 'package:presensifr/widgets/attendance_card.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/login_provider.dart';
import '../util/status_state.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _historyCheckIn(context),
    );
  }

  Widget _historyCheckIn(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, _) {
        if (historyProvider.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (historyProvider.status == Status.success) {
          final history = historyProvider.historyResult.data!.result!;
          return history.checkIn!.isEmpty
          ? const Center(
            child: Text('Data masih kosong'),
          )
          : ListView.builder(
            itemCount: historyProvider.historyResult.data!.result!.checkIn!.length,
            itemBuilder: (context, index) {
              final historyCheckIn = historyProvider.historyResult.data!.result!.checkIn![index];
              return Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CheckInCard(result: historyCheckIn),
                ),
              );
            },
          );
        } else if (historyProvider.status == Status.failed) {
          return Center(
            child: Material(
              child: Text(historyProvider.message),
            ),
          );
        } else if (historyProvider.status == Status.error) {
          return Center(
            child: Material(
              child: Text(historyProvider.message),
            ),
          );
        } else {
          return const Text('Ada kesalahan');
        }
      }
    );
  }
}
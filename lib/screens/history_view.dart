import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensifr/provider/history_provider.dart';
import 'package:presensifr/widgets/checkin_card.dart';
import 'package:presensifr/widgets/checkout_card.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/login_provider.dart';
import '../util/status_state.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: ColorPalette.whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  )
                ]
              ),
              child: Column(
                children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TabBar(
                        unselectedLabelColor: ColorPalette.primaryColor,
                        labelColor: Colors.white,
                        indicatorColor: ColorPalette.primaryColor,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: ColorPalette.primaryColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Check In',
                          ),
                          Tab(
                            text: 'Check Out',
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                 _historyCheckIn(context),
                 _historyCheckOut(context),
              ],
            ),
          )
        ],
      )
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

  Widget _historyCheckOut(BuildContext context) {
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
            itemCount: historyProvider.historyResult.data!.result!.checkOut!.length,
            itemBuilder: (context, index) {
              final historyCheckOut = historyProvider.historyResult.data!.result!.checkOut![index];
              return Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CheckOutCard(result: historyCheckOut)
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
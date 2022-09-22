import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';

import '../data/model/response_model/history_response_model.dart';
import '../util/status_state.dart';

class HistoryProvider extends ChangeNotifier {

  final String nik;
  final String nip;

  HistoryProvider({
    required this.nik,
    required this.nip
  }) {
    fetchHistory(nik, nip);
  }

 late Status _status;
 late HistoryResult _historyResult;
 String _message = '';

 Status get status => _status;
 HistoryResult get historyResult => _historyResult;
 String get message => _message;

 Future<dynamic> fetchHistory(String nik, String nip) async {
  try {
    _status = Status.loading;
    notifyListeners();
    final response = await ApiService.getHistory(nik, nip);
    if (response.errCode != 0) {
      _status = Status.failed;
      notifyListeners();
      return _message = 'Failed to get history';
    } else {
      _status = Status.success;
      notifyListeners();
      return _historyResult = response;
    }
  } catch (e) {
    _status = Status.error;
    notifyListeners();
    return _message = 'Error --> $e';
  }
 }

}
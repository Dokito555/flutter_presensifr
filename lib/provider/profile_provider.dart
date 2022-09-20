import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';

import '../data/model/response_model/profile_response_model.dart';
import '../util/status_state.dart';

class ProfileProvider extends ChangeNotifier {

  final String nik;
  final String nip;

  ProfileProvider({
    required this.nik,
    required this.nip
  }) {
    fetchProfile(nik, nip);
  }

  late Status _status;
  late ProfileResult _profileResult;
  String _message = '';

  Status get status => _status;
  ProfileResult get profileResult => _profileResult;
  String get message => _message;

  Future<dynamic> fetchProfile(String nik, String nip) async {
    try {
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.getProfile(nik, nip);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to get profile info';
      } else {
        _status = Status.success;
        notifyListeners();
        return _profileResult = response;
      }
    } catch (e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

}
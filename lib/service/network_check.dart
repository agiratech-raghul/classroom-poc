import 'package:classroom_poc/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<void> checkNetworkAndShowSnackBar(BuildContext context) async {
    bool isNetWorkAvailable = await check();
    if (!isNetWorkAvailable) {
      AppSnackBar(
          message: 'Check Your Internet Connection',
          actionText: 'Ok',
          onPressed: () => {}).showAppSnackBar(context);
    }
  }

  void showNoInternetMessage(BuildContext context) {
    AppSnackBar(
        message: 'Check Your Internet Connection',
        actionText: 'Ok',
        onPressed: () => {}).showAppSnackBar(context);
  }
}

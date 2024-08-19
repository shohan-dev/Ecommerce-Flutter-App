import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  // Observable variable to hold the network status
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Check initial connectivity
    _checkConnectivity();
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectivityStatus(result);
    });
  }

  // Method to check the current connectivity status
  Future<void> _checkConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(result);
  }

  // Update the connectivity status
  void _updateConnectivityStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
  }
}

import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkOn() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  // Se não ouver internet devolve false, caso contrario true
  return connectivityResult == ConnectivityResult.none;
}

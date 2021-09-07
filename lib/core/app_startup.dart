import 'package:product_hunt/core/api/dio_client.dart';
import 'package:product_hunt/service/local_state.dart';

abstract class AppStartupLogic {
  static Future<void> initialize() async {
    await LocalState.instance.init();
    DioClient.instance.refresh();
  }
}

import '../service/local_state.dart';
import 'api/dio_client.dart';

abstract class AppStartupLogic {
  static Future<void> initialize() async {
    await LocalState.instance.init();
    DioClient.instance.refresh();
  }
}

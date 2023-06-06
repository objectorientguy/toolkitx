import 'package:permission_handler/permission_handler.dart';

class CameraUtils {
  Future<void> permission() async {
    var status = await Permission.camera.status;
  }
}

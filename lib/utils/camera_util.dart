import 'package:permission_handler/permission_handler.dart';

class CameraUtils {
  Future<void> permission(PermissionStatus status) async {
    var status = await Permission.camera.request();

    return permission(status);
  }
}

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';

class InstallerService {
  // GitHub Release URL (Apnar repo onujayi update korun)
  final String rootfsUrl = "https://github.com/cybernahid-dev/AeonDesk/releases/download/v1.0/aeondesk-core-arm64.tar.gz";

  Future<void> installLinux(Function(String) onStatusUpdate) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final rootfsPath = "\${directory.path}/aeondesk-rootfs";
      final tarFile = File("\${directory.path}/core.tar.gz");

      // 1. Download
      onStatusUpdate("Downloading Core (1GB+)...");
      var response = await http.get(Uri.parse(rootfsUrl));
      if (response.statusCode == 200) {
        await tarFile.writeAsBytes(response.bodyBytes);
      } else {
        throw "Download Failed!";
      }

      // 2. Extraction
      onStatusUpdate("Extracting Files...");
      final bytes = await tarFile.readAsBytes();
      final archive = TarDecoder().decodeBytes(gzip.decode(bytes));

      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          File("\$rootfsPath/\$filename")
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory("\$rootfsPath/\$filename").createSync(recursive: true);
        }
      }

      onStatusUpdate("Installation Complete!");
    } catch (e) {
      onStatusUpdate("Error: \$e");
    }
  }

  String getLaunchCommand(String rootfsPath) {
    // Proot command setup
    return "proot -0 -r \$rootfsPath -b /dev -b /proc -b /sys -w /root /usr/bin/aeon-desktop";
  }
}

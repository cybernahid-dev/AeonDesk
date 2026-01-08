import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstallerService {
  // আপনার GitHub Username এবং Repo অনুযায়ী এটি পরিবর্তন করবেন
  final String _githubUser = "cybernahid-dev";
  final String _repoName = "AeonDesk";
  final String _version = "v1.0.0"; // Release Tag

  String get _rootfsUrl => 
      "https://github.com/$_githubUser/$_repoName/releases/download/$_version/aeondesk-core-arm64.tar.gz";

  /// ১. ডিভাইস রুটেড কি না তা চেক করার লজিক
  Future<bool> isDeviceRooted() async {
    List<String> suPaths = [
      "/sbin/su", "/system/bin/su", "/system/xbin/su",
      "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su"
    ];
    try {
      for (var path in suPaths) {
        if (await File(path).exists()) return true;
      }
    } catch (_) {}
    return false;
  }

  /// ২. লিনাক্স এনভায়রনমেন্ট ইন্সটল করার মেইন ফাংশন
  Future<void> installLinux(Function(String) onStatusUpdate) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final rootfsDir = Directory("${directory.path}/aeondesk-rootfs");
      final tarFile = File("${directory.path}/core.tar.gz");

      // ফোল্ডার না থাকলে তৈরি করা
      if (!await rootfsDir.exists()) {
        await rootfsDir.create(recursive: true);
      }

      // ডাউনলোড শুরু
      onStatusUpdate("FETCHING CORE ENGINE...");
      final response = await http.get(Uri.parse(_rootfsUrl));
      
      if (response.statusCode == 200) {
        await tarFile.writeAsBytes(response.bodyBytes);
        onStatusUpdate("CORE DOWNLOADED. SYNCING...");
      } else {
        throw "CONNECTION_ERROR: ${response.statusCode}";
      }

      // এক্সট্র্যাকশন লজিক (Gzip -> Tar)
      onStatusUpdate("UNPACKING ARCHIVE...");
      final bytes = await tarFile.readAsBytes();
      final decodedGzip = GZipDecoder().decodeBytes(bytes);
      final archive = TarDecoder().decodeBytes(decodedGzip);

      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          File("${rootfsDir.path}/$filename")
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory("${rootfsDir.path}/$filename").createSync(recursive: true);
        }
      }

      // ইন্সটলেশন স্ট্যাটাস সেভ করা
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_installed', true);
      
      // ক্লিনআপ (জিপ ফাইল ডিলিট করা স্টোরেজ বাঁচাতে)
      if (await tarFile.exists()) await tarFile.delete();

      onStatusUpdate("CORE INSTALLATION COMPLETE");
    } catch (e) {
      onStatusUpdate("CRITICAL_ERROR: $e");
    }
  }

  /// ৩. ডাইনামিক লঞ্চ কমান্ড (এটি মূল চাবিকাঠি)
  Future<String> getLaunchCommand() async {
    final directory = await getApplicationDocumentsDirectory();
    final rootfsPath = "${directory.path}/aeondesk-rootfs";
    bool rooted = await isDeviceRooted();

    if (rooted) {
      // Rooted Mode: Full Chroot for Maximum Speed
      return "su -c 'chroot $rootfsPath /bin/bash /tmp/aeon_boot.sh && /usr/bin/aeon-desktop'";
    } else {
      // Non-Root Mode: PRoot Sandbox
      // Note: binaries like 'proot' must be bundled in the app or downloaded separately
      return "proot -0 -r $rootfsPath -b /dev -b /proc -b /sys -w /root /bin/bash /tmp/aeon_boot.sh && /usr/bin/aeon-desktop";
    }
  }

  /// ৪. চেক করা কি না আগে ইন্সটল হয়েছে কি না
  Future<bool> checkInstallationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_installed') ?? false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/features/user/presentation/design/app_colors.dart';
import 'package:hakbang/features/user/presentation/pages/main_page.dart';
import 'package:hakbang/features/user/presentation/pages/server_offline.dart';
import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/functions/login_function.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/features/user/presentation/pages/start_page.dart';
import 'package:hakbang/server/initialize_server.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  ValueNotifier<Map<String, bool>> startup = ValueNotifier({
    "server": false,
    "cache": false,
    "userLogged": false,
  });
  @override
  void initState() {
    super.initState();
    initializeLocation();
    connectToServer();
    initializeFlutterSecureStorage(AppleOptions.defaultAccountName);
    loggedIn();
  }

  void initializeLocation() async {
    await Locations.initializeLocationServices();
  }

  void initializeFlutterSecureStorage(String accountName) {
    storage.value = FlutterSecureStorage(
      aOptions: const AndroidOptions(
        biometricPromptTitle: "Flutter Secure",
        biometricPromptSubtitle: "Secure",
        enforceBiometrics: true,
      ),
      iOptions: IOSOptions(accountName: accountName, synchronizable: true),
    );
  }

  Future<void> loggedIn() async {
    if (await storage.value!.containsKey(key: "email") == false ||
        await storage.value!.containsKey(key: "pass") == false) {
      startup.value = {...startup.value, "userLogged": false};
    } else {
      String? email = await storage.value!.read(key: "email");
      String? password = await storage.value!.read(key: "pass");
      if (email != null && password != null) {
        await LoginFunction.userLogin(email, password);
        startup.value = {...startup.value, "userLogged": true};
      }
    }
    startup.value = {...startup.value, "cache": true};
  }

  void connectToServer() async {
    var execute = await InitializeServer.pingServer();
    connectedToServer.value = execute["connected"];
    startup.value = {...startup.value, "server": true};
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: startup,
      builder: (context, check, child) {
        return check["server"]! && check["cache"]!
            ? check["userLogged"]!
                  ? MainPage()
                  : StartPage()
            : !check["server"]! || !check["cache"]!
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.accent,
                      year2023: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        !check["server"]!
                            ? "This may take long, Connecting to Server..."
                            : "Checking cache...",
                        style: GoogleFonts.dmSans(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ServerOffline();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/features/user/presentation/design/app_colors.dart';
import 'package:hakbang/features/user/presentation/pages/server_offline.dart';
import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/features/user/presentation/pages/start_page.dart';
import 'package:hakbang/server/initialize_server.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  ValueNotifier<bool> doneLoading = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    initializeLocation();
    connectToServer();
  }

  void initializeLocation() async {
    await Locations.initializeLocationServices();
  }

  void connectToServer() async {
    var execute = await InitializeServer.pingServer();
    connectedToServer.value = execute["connected"];
    doneLoading.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: connectedToServer,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: doneLoading,
          builder: (context, loading, child) {
            return value && loading
                ? StartPage()
                : !loading
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
                            "This may take long, Connecting to Server...",
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
      },
    );
  }
}

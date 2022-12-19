import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sportlink/firebase_options.dart';
import 'package:sportlink/state/property.dart';
import 'package:sportlink/ui/debug/standard_debug_view.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'static/style/standard_theming.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    )
  ]);

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('zh'),
          Locale('zh', 'HK')
        ],
        path: 'assets/locale/',
        fallbackLocale: const Locale('zh', 'HK'),
        child: const SportLink()),
  );
}

const String title = "Game Dating";

class SportLink extends StatelessWidget {
  const SportLink({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: title,
      theme: StandardTheme.light.theme,
      darkTheme: StandardTheme.dark.theme,
      themeMode: ThemeMode.dark,
      home: const MaterialAppRunner(title: title),
    );
  }
}

class MaterialAppRunner extends StatefulWidget {
  const MaterialAppRunner({super.key, required this.title});
  final String title;

  @override
  State<MaterialAppRunner> createState() => _MaterialAppRunner();
}

class _MaterialAppRunner extends State<MaterialAppRunner> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Injector(
        inject: [Inject((() => Property()))],
        initState: () {
          RM.get<Property>().setState((s) async => await s.initVenues());
        },
        builder: (_) {
          return StateBuilder<Property>(
              observe: () => RM.get<Property>(),
              builder: ((context, model) {
                if (model?.isWaiting ?? true) {
                  return Scaffold(body: Center(child: Text("waiting")));
                } else {
                  return const StandardDebugView();
                }
              }));
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/generated/l10n.dart';
import 'package:{{cookiecutter.flutter_package_name}}/route_observer.dart';
import 'package:{{cookiecutter.flutter_package_name}}/routes.dart';

class MyApp extends StatelessWidget {
  final _navigationKey = GlobalKey<NavigatorState>();
  final _routeObserver = MyObserver();

  NavigatorState? get _navigator => _navigationKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            navigationPage(Routes.homeScreen);
            break;
          case AuthenticationStatus.unauthenticated:
            navigationPage(Routes.loginScreen);
            break;
          default:
        }
      },
      child: MaterialApp(
        navigatorObservers: [_routeObserver],
        navigatorKey: _navigationKey,
        theme: ThemeData(
          //options: setting page transitions
          // pageTransitionsTheme: PageTransitionsTheme(
          //   builders: <TargetPlatform, PageTransitionsBuilder>{
          //     TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          //     TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          //     TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          //     TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          //   },
          // ),
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) => _localeCallback(locale, supportedLocales),
        initialRoute: Routes.initScreen,
        routes: Routes.routes,
      ),
    );
  }

  Locale _localeCallback(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    // from the list (japanese, in this case).
    return supportedLocales.first;
  }

  void navigationPage(String nextPage) {
    _navigator!.pushNamedAndRemoveUntil(nextPage, (_) => false);
  }
}

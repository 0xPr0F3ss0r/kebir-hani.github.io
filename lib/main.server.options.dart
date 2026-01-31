// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:my_portfolio/components/header.dart' as _header;
import 'package:my_portfolio/pages/about.dart' as _about;
import 'package:my_portfolio/pages/contact.dart' as _contact;
import 'package:my_portfolio/pages/home.dart' as _home;
import 'package:my_portfolio/widgets/themtoggle.dart' as _themtoggle;
import 'package:my_portfolio/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _header.Header: ClientTarget<_header.Header>('header'),
    _contact.contact: ClientTarget<_contact.contact>('contact'),
    _home.Home: ClientTarget<_home.Home>('home'),
  },
  styles: () => [
    ..._header.Header.styles,
    ..._about.About.styles,
    ..._themtoggle.ThemeToggle.styles,
    ..._app.App.styles,
  ],
);

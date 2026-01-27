// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:my_portfolio/components/header.dart' deferred as _header;
import 'package:my_portfolio/pages/about.dart' deferred as _about;
import 'package:my_portfolio/pages/contact.dart' deferred as _contact;
import 'package:my_portfolio/pages/home.dart' deferred as _home;
import 'package:my_portfolio/pages/projects.dart' deferred as _projects;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'header': ClientLoader(
      (p) => _header.Header(),
      loader: _header.loadLibrary,
    ),
    'about': ClientLoader((p) => _about.About(), loader: _about.loadLibrary),
    'contact': ClientLoader(
      (p) => _contact.contact(),
      loader: _contact.loadLibrary,
    ),
    'home': ClientLoader((p) => _home.Home(), loader: _home.loadLibrary),
    'projects': ClientLoader(
      (p) => _projects.projects(),
      loader: _projects.loadLibrary,
    ),
  },
);

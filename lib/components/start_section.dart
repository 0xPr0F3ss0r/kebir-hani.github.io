import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;

class StartSection extends StatefulComponent {
  @override
  State<StartSection> createState() => _StartSectionState();
  
  static get styles => [
    css('#start').styles(
      display: Display.flex,
      height: 100.vh,
      margin: Spacing.only(left: 250.px),
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.start,
      color: whiteColor,
      textAlign: TextAlign.start,
    ),


    // Paragraph animation
    css('#start p').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.5.em, vertical: 0.25.em),
      margin: Spacing.zero,
      color: whiteColor,
      fontSize: 5.rem,
      raw: {
        'background-image': 'linear-gradient(to right, blue 0%, blue 100%)',
        'background-size': '0% 100%',
        'background-position': 'left center',
        'background-repeat': 'no-repeat',
        'transition': 'background-size 500ms ease-in-out',
      },
    ),
    css('#start p.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
  ];
}

class _StartSectionState extends State<StartSection> {
  final List<String> texts = [
    "flutter developer.",
    "cybersecurity enthusiast.",
  ];
  int index = 0;
  bool filled = false;
  bool showRussian = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() => filled = true);
      });
      
      // Start Russian text animation
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) {
          setState(() => showRussian = true);
        }
      });
      // Switch to English text immediately after Russian animation
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) {
          setState(() => showRussian = false);
        }
      });

      // Paragraph cycling
      _timer = Timer.periodic(const Duration(seconds: 4), (_) async {
        setState(() => filled = false);
        await Future.delayed(const Duration(milliseconds: 500));
        index = (index + 1) % texts.length;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() => filled = true);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    String mode  = context.watch(state_management.mode);
    Color textColor = mode == "dark" ? whiteColor : dark;
    return section(id: 'start', [
      div(classes: 'container', [
        div(classes: 'cta', [
          h1(
            classes: showRussian ? 'russian show' : 'english',
            styles: Styles(
              color: textColor,
              fontFamily: FontFamily('Fira Code, monospace'),
            ),
            [.text(showRussian ? 'Кебир Хани' : 'KEBIR HANI!')],
          ),
          p(
            classes: filled ? 'fill' : '',
            styles: Styles(
              color: textColor,
              fontFamily: FontFamily('DynaPuff'),
            ),
            [.text(texts[index])],
          ),
        ]),
      ]),
    ]);
  }
}

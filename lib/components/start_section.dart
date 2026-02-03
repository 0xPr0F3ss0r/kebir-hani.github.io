import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/components/video-background.dart';
import 'package:my_portfolio/constants/theme.dart';

class StartSection extends StatefulComponent {
  @override
  State<StartSection> createState() => _StartSectionState();

  static get styles => [
    css('#start').styles(
      display: Display.flex,
      position: Position.relative(),
      height: 100.vh,
      margin: Spacing.zero,
      overflow: Overflow.hidden,
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.start,
      color: whiteColor,
      textAlign: TextAlign.start,
    ),
    css('#start .container').styles(
      position: Position.relative(),
      width: 100.percent,
      padding: Spacing.only(left: 2.5.rem, right: 2.5.rem, top: 6.rem, bottom: 6.rem),
      margin: Spacing.zero,
      raw: {
        'z-index': '2',
      },
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
    ...VideoBackground.styles,
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
    return section(
      id: 'start',
      styles: Styles(position: Position.relative()),
      [
        const VideoBackground(),
        div(classes: 'container', [
          div(classes: 'cta', [
            h1(
              classes: showRussian ? 'russian show' : 'english',
              styles: Styles(
                color: Colors.white,
                fontFamily: FontFamily('Fira Code, monospace'),
              ),
              [.text(showRussian ? 'Кебир Хани' : 'KEBIR HANI!')],
            ),
            p(
              classes: filled ? 'fill' : '',
              styles: Styles(
                color: Colors.white,
                fontFamily: FontFamily('DynaPuff'),
              ),
              [.text(texts[index])],
            ),
          ]),
        ]),
      ],
    );
  }
}

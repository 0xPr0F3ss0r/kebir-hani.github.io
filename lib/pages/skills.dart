import 'dart:async';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;


class Myskills extends StatefulComponent {
  final String id;
  const Myskills({super.key, required this.id});

  @override
  State<Myskills> createState() => _MyskillsState();

   @css
  static List<StyleRule> get styles => [
    css('.skills-section').styles(
      display: Display.flex,
    //  minHeight: 100.vh,
      padding: Spacing.symmetric(horizontal: 400.px),
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      textAlign: TextAlign.center,
    ),

    css('.skills-wrapper').styles(
      display: Display.flex,
      width: 100.percent,
      maxWidth: 900.px,
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      gap: Gap.all(20.px),
    ),

    css('.skills-content').styles(
      maxWidth: 700.px,
    ),

    css('.skills-content h1').styles(
      margin: Spacing.only(bottom: 25.px),
      fontFamily: FontFamily('DynaPuff'),
    ),

    // Paragraph gradient fill animation
    css('.skills-content p').styles(
      margin: Spacing.only(top: 15.px),
      fontSize: 22.px,
      lineHeight: Unit.em(1.8),
      raw: {
        'color': 'transparent',
        'background-image': 'linear-gradient(to right, blue 0%, blue 100%)',
        'background-size': '0% 100%',
        'background-repeat': 'no-repeat',
        'background-position': 'left center',
        'transition': 'background-size 800ms ease-in-out',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
      },
    ),

    css('.skills-content p.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),

    css('.skills-section h1').styles(
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
    css('.skills-section h1.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
  ];
}

class _MyskillsState extends State<Myskills> {
  bool filled = false;




    

  @override
  void initState() {
    super.initState();
    
    if (kIsWeb) {
          Future.microtask(() => _startObserving()
          );
    }
  }
void _startObserving() {
  final options = web.IntersectionObserverInit(threshold: 0.2.toJS);

  final observer = web.IntersectionObserver(
    (JSArray entries, web.IntersectionObserver obs) {
      for (var entry in entries.toDart) {
        final e = entry as web.IntersectionObserverEntry;
        if (e.isIntersecting){
          if(mounted){
            setState(() => filled =true);
            Future.delayed(Duration(seconds: 1), () {
              if (mounted) setState(() => filled = false);
            });

          }else{
            if(mounted) setState(() => filled = false);
          }
        }
      }
    }.toJS,
    options,
  );

  final element = web.document.getElementById(component.id);
  if (element != null) {
    observer.observe(element);
  } else {
    print('⚠️ Element with id ${component.id} not found');
  }
}


  @override
  Component build(BuildContext context) {
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? Colors.white : Colors.black;

    return section(id:component.id,classes: 'skills-section', [
      div(classes: 'container', [
        div(classes: 'skills-wrapper', [
          div(classes: 'skills-content', [
            h1(
              classes: filled ? 'fill' : '',
              styles: Styles(color: BlueColor, fontSize: 50.px),
              [.text('что я знаю')],
            ),
            // English paragraphs with animation
            p(styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text(
                'I have 3 years of experience with Flutter and Dart, building apps and exploring advanced features. I’ve also worked with C, C++, and Python for system programming, reverse engineering,pentesting,and automation. I know the basics of HTML, CSS, and JavaScript.',
              ),
            ]),
            p(styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text('I have a solid programming foundation that lets me quickly learn new languages or frameworks.'),
            ]),
            p(styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text('Currently, I’m focusing on advanced Flutter development while exploring low-level programming and cybersecurity concepts related to it.'),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}

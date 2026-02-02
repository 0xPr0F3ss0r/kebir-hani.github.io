import 'dart:async';
import 'package:universal_web/web.dart' as web;
import 'package:universal_web/js_interop.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;

class About extends StatefulComponent {
   final String id;
   const About({super.key, required this.id});
   
    @override
  State<About> createState() => _AboutState();

  @css
  static List<StyleRule> get styles => [
    css('.about-wrapper').styles(
      display: Display.flex,
      flexDirection: FlexDirection.row,
      flexWrap: FlexWrap.wrap,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      gap: Gap.all(40.px),
    ),
    css('.about-content').styles(maxWidth: 450.px, flex: Flex.none,),
    css('.about-content h2').styles(
      fontFamily: FontFamily('DynaPuff'),
    ),
    css('.about-content h3').styles(
      margin: Spacing.only(bottom: 15.px),
      fontFamily: FontFamily('DynaPuff'),
    ),
    css('.about-content p').styles(
      margin: Spacing.only(top: 15.px),
      fontSize: 25.px,
      lineHeight: Unit.em(1.7),
    ),
    css('.about-image').styles(
      height: .auto,
      radius: BorderRadius.circular(10.px),
      flex: Flex.shrink(0),
    ),

       css('.about-section h3').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.px, vertical: 0.25.em),
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
    css('.about-section h3.fill').styles(
      raw: {
        'background-size': '100%w.wi 100%',
      },
    ),
  ];

 
}

class _AboutState extends State<About> {
  bool filled = false;
  

  @override
void initState() {
  super.initState();
  
  if(kIsWeb){
    Future.microtask(()=>_startObserving());
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
    // Watch the current mode from state management
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? Colors.white : Colors.black;

    return section(id: component.id,classes: 'about-section', [
      div(classes: 'container', [
        div(classes: 'about-wrapper', [
          // Left: Text
          div(classes: 'about-content', [
            h3(classes: filled ? 'fill' : '',styles: Styles(color: BlueColor, fontSize: 60.px), [.text('кто я?')]),
            h2(styles: Styles(color: color), [.text('who am i ?')]),
            p(styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text('I’m Hani, a '),
              span(
                styles: Styles(
                  color: BlueColor,
                  fontWeight: FontWeight.bold,
                ),
                [.text('Flutter developer')],
              ),
              .text(
                ' since 2023 and a programmer since 2022. I build advanced mobile applications with a focus on clean code and great user experiences. I’m also interested in ',
              ),
              span(
                styles: Styles(
                  fontWeight: FontWeight.bold, 
                ),
                [.text('low-level programming')],
              ),
              .text(', '),
              span(
                styles: Styles(
                  fontWeight: FontWeight.bold,
                ),
                [.text('systems')],
              ),
              .text(', and '),
              span(
                styles: Styles(
                  color: BlueColor,
                  fontWeight: FontWeight.bold,
                ),
                [.text('cybersecurity')],
              ),
              .text('.'),
            ]),
          ]),
          // Right: Image
          img(
            classes: 'about-image',
            src: 'images/personal.jpg',
            alt: 'About Image',
            styles: Styles(width: 250.px, height: .auto),
          ),
        ]),
      ]),
    ]);
  }

}

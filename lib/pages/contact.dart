import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart'
    as state_management;
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

class Contact extends StatefulComponent {
  final String id;
  const Contact({super.key, required this.id});

  @override
  State<Contact> createState() => _ContactState();

  @css
  static List<StyleRule> get styles => [
        css('.contact-wrapper').styles(
          display: Display.flex,
          flexDirection: FlexDirection.row,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
          gap: Gap.all(60.px),
        ),
        css('.contact-content').styles(
          maxWidth: 450.px,
          flex: Flex.none,
        ),
        css('.contact-content h2').styles(
          fontFamily: FontFamily('DynaPuff'),
        ),
        css('.contact-content h3').styles(
          margin: Spacing.only(bottom: 15.px),
          fontFamily: FontFamily('DynaPuff'),
        ),
        css('.contact-content p').styles(
          margin: Spacing.only(top: 15.px),
          fontSize: 25.px,
        ),
        css('.contact-links').styles(
          display: Display.flex,
          minWidth: 240.px,
          flexDirection: FlexDirection.column,
          gap: Gap.all(20.px),
        ),
        css('.contact-card').styles(
          display: Display.flex,
          padding: Spacing.symmetric(vertical: 12.px, horizontal: 18.px),
          border: Border.all(color: BlueColor),
          radius: BorderRadius.circular(12.px),
          cursor: Cursor.pointer,
          transition: const Transition(
            'all',
            curve: Curve.easeInOut,
            duration: Duration(milliseconds: 250),
          ),
          alignItems: AlignItems.center,
          textDecoration: TextDecoration.none,
        ),
        css('.contact-card img').styles(
          width: 40.px,
          height: 40.px,
          radius: BorderRadius.circular(50.px),
          raw: {
            'objectFit': 'cover',
          },
        ),
        css('.contact-card:hover').styles(
          transform: Transform.translate(y: (-3).px),
          color: Colors.white,
          backgroundColor: BlueColor,
        ),
        css('.contact-section h3').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(vertical: 0.25.em),
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
    css('.contact-section h3.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
      ];

}

class _ContactState extends State<Contact> {
  
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
  
    return section(id: component.id, classes: 'contact-section', [
      div(classes: 'container', [
        div(classes: 'contact-wrapper', [

          /// LEFT SIDE (text)
          div(classes: 'contact-content', [
            h3(
              classes: filled?'fill' : '',
              styles: Styles(color: BlueColor, fontSize: 60.px,),
              [.text('свяжитесь со мной')],
            ),

            h2(
              styles: Styles(color: color),
              [.text('get in touch')],
            ),

            p(
              styles: Styles(color: color, lineHeight: Unit.em(1.7)),
              [
                .text("I’m available for "),
                span(
                  styles: Styles(
                    color: BlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                  [.text('freelance')],
                ),
                .text(" and "),
                span(
                  styles: Styles(
                    color: BlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                  [.text('contract')],
                ),
                .text(
                    " opportunities, with a focus on ambitious and high-impact projects. Feel free to reach out to discuss how we can collaborate."),
              ],
            ),
          ]),

          /// RIGHT SIDE (social links with images)
          div(classes: 'contact-links', [
            _socialLink('LinkedIn', 'https://linkedin.com/in/kebir-hani', 'images/linkedin.png', color, currentMode),
            _socialLink('GitHub', 'https://github.com/0xPr0F3ss0r', 'images/github12.png', color, currentMode),
            _socialLink('Twitter', 'https://twitter.com/0xPr0F3ss0r', 'images/twitter.png', color, currentMode),
          ]),
        ]),
      ]),
    ]);
  }

  /// Component for social link with image
  Component _socialLink(String title, String url, String imgPath, Color color, String currentColor) {
    return a(
      href: url,
      target: Target.blank,
      classes: 'contact-card',
      [
        img(
          src: imgPath,
          alt: title,
          styles: Styles(
            width: 150.px,
            height: 100.px,
            radius: BorderRadius.circular(20.px),
            filter: currentColor == "dark" ? Filter.invert(1) : Filter.invert(0),
          ),
        ),
        span(
          styles: Styles(
            margin: Spacing.only(left: 12.px),
            color: color,
            fontSize: 18.px,
            fontWeight: FontWeight.bold,
          ),
          [.text(title)],
        ),
      ],
    );
  }

  }

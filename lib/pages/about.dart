import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;

class About extends StatelessComponent {
  const About({super.key});

  @override
  Component build(BuildContext context) {
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? Colors.white : Colors.black;

    return section(classes: 'about-section', [
      div(classes: 'container', [
        div(classes: 'about-wrapper', [
          // Left: Text
          div(classes: 'about-content', [
            h3(styles: Styles(color: BlueColor, fontSize: 60.px), [.text('кто я?')]),
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
    css('.about-content').styles(maxWidth: 450.px, flex: Flex.none),
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
  ];
}

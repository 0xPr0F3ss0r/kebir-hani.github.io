import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:my_portfolio/widgets/toglethem.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;
import '../constants/theme.dart';

@client
class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;
    String currentMode = context.watch(state_management.mode);
    return header(styles: Styles(
      backgroundColor: currentMode == 'dark' ? Colors.black : Colors.white,
    ),[
      
        Link(
        to: '/',
        child: img(
          classes: 'header-logo',
          src: 'images/Dinosor.png',
          alt: 'Logo',
          height: 150,
          width: 150,
        ),
      ),
      nav([
        for (var route in [
          (label: 'Home', path: '/'),
          (label: 'About', path: '/about'),
          (label: 'Projects', path: '/projects'),
          (label: 'Contact', path: '/contact'),

        ])
          div(classes: activePath == route.path ? 'active' : null, [
            Link(to: route.path, child: .text(route.label)),
          ]),
      ]),
     ToggleTheme(),

    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header').styles(
       display: .flex,
  padding: .all(1.em),
  alignItems: .center,
  gap: Gap.all(20.px),
    ),
    css('header .mode-button').styles(
        padding: .zero,
  margin: .only(left: .auto),
  border: .none,
  cursor: .pointer,
  backgroundColor: Colors.transparent,
      ),
      css('header img.header-logo').styles(
        radius: .circular(20.px),
        raw: {
          'transition': 'filter 0.5s ease-in 0.05s',
        },
      ),

      css('header img.header-logo:hover').styles(
        raw: {'filter': ' invert(50%) sepia(100%) saturate(1000%) hue-rotate(90deg) brightness(100%) contrast(100%)'},
      ),
    css('nav', [
        css('&').styles(
          display: .flex,
          padding: Spacing.all(10.px),
          radius: .all(.circular(10.px)),
          overflow: .clip,
          flexDirection: .row,
          gap: Gap.all(30.px),
        ),
       

      css('p.name').styles(
        justifyContent: .right,

        color: greenColor,

        fontFamily: FontFamily("DynaPuff"),

        fontSize: 15.px,
      ),
      css('.mode-button').styles(
        position: .absolute(top: 10.px, right: 10.px),
        zIndex: ZIndex(9999),
        width: 40.px,
        height: 40.px,
        padding: .zero,
        border: .none,
        cursor: .pointer,
        backgroundColor: .currentColor,
      ),

        css('a', [
          css('&').styles(
            display: .flex,
            height: 100.percent,
            padding: .symmetric(horizontal: 0.5.em),
            alignItems: .center,
            color: whiteColor,
            fontFamily: FontFamily("DynaPuff"),
            fontWeight: .w700,
            textDecoration: TextDecoration(line: .none),
          ),
          css('&:hover', [
            css('&::after').styles(
              content: '',
              display: .block,
              position: .absolute(top: 50.percent, left: (-10).px),
              width: 120.percent,
              height: 4.px,
              transform: Transform.translate(y: (-50).percent),
              backgroundColor: blueColor,
            ),
          ]).styles(
            display: .inlineBlock,
            position: .relative(),
          ),
        ]),

        css('div.active span', [
          css('&').styles(
            display: .inlineBlock,
            position: .relative(),
          ),
          css('&::after').styles(
            content: '',
            display: .block,
            position: .absolute(top: 50.percent, left: (-10).px),
            width: 150.percent,
            height: 4.px,
            transform: Transform.translate(y: (-50).percent),
            backgroundColor: whiteColor,
          ),
        ]),
      ])];
  
}

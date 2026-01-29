import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:my_portfolio/widgets/themtoggle.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;
import '../constants/theme.dart';

@client
class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;
    String currentMode = context.watch(state_management.mode);
    return header(
      styles: Styles(
        backgroundColor: currentMode == 'dark' ? Colors.black : Colors.white,
      ),
      [
        div(
          styles: Styles(display: Display.flex, alignItems: .center, gap: Gap.all(0.px)),
          [
            Link(
          to: '/',
          child: img(
            classes: 'header-logo ${currentMode == 'dark' ? 'dark-mode' : 'light-mode'}',
            src: 'images/Dinosor.png',
            alt: 'Logo',
            height: 150,
            width: 150,
          ),
        ),
        nav(styles:Styles(color: currentMode == 'dark' ? Colors.white : Colors.black) ,[
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
          ]
        ),
        
        ThemeToggle(),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('header').styles(
      display: .flex,
      position: .fixed(top: 0.px, left: 0.px),
      zIndex: ZIndex(9999),
      width: 100.percent,
      padding: .symmetric(horizontal: 50.px, vertical: 10.px),
      justifyContent: .spaceBetween,
      alignItems: .center,
      
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
        'transition': 'filter 0.2s ease-in 0s',
      },
    ),

    //dark mode
    css('header img.header-logo.dark-mode').styles(
      raw: {
        'filter': 'none',
      },
    ),

    //light mode
    css('header img.header-logo.light-mode').styles(
      raw: {
        'filter': 'brightness(0) saturate(100%) invert(0)',
      },
    ),
    //dark mode hover
    css('header img.header-logo.dark-mode:hover').styles(
      raw: {
        'filter': 'invert(50%) sepia(100%) saturate(1000%) hue-rotate(200deg) brightness(80%) contrast(500%)',
      },
    ),

    //light mode hovre
    css('header img.header-logo.light-mode:hover').styles(
      raw: {
    'filter': 'invert(50%) sepia(100%) saturate(1000%) hue-rotate(200deg) brightness(80%) contrast(500%)',
      },
    ),

    css('nav a').styles(
      color: .currentColor,
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
            backgroundColor:bluelight,
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
    ]),
  ];
}

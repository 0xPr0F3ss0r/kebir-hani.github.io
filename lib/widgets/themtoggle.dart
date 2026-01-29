import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart';

class ThemeToggle extends StatelessComponent {
  const ThemeToggle();

  @override
  Component build(BuildContext context) {
    final currentMode = context.watch(mode); 
    return button(
      classes: 'theme-toggle',
      attributes: {
        'type': 'button',
        'title': 'Toggle theme',
        'aria-label': 'Toggle theme',
        'data-theme': currentMode,
      },
      onClick: () {
        final newMode = currentMode == 'light' ? 'dark' : 'light';
        context.read(mode.notifier).state = newMode;
      },
      [
        svg(
          classes: 'theme-toggle__inner-moon',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '50px',
            'height': '50px',
            'fill': 'currentColor',
            'viewBox': '0 0 32 32',
          },
          [
            path(
              attributes: {
                'd':
                    'M27.5 11.5v-7h-7L16 0l-4.5 4.5h-7v7L0 16l4.5 4.5v7h7L16 32l4.5-4.5h7v-7L32 16l-4.5-4.5zM16 25.4a9.39 9.39 0 1 1 0-18.8 9.39 9.39 0 1 1 0 18.8z'
              },
              [],
            ),
            circle(attributes: {'cx': '16', 'cy': '16', 'r': '8.1', 'id': 'inner-moon-circle'}, []),
          ],
        ),
      ],
    );
  }

  @css
static List<StyleRule> get styles => [
  // button base
  css('.theme-toggle',) .styles(
      padding: Spacing.all(0.px),
     margin: Spacing.only(left: .auto, right:.percent(8)),
      border: Border.none,
      cursor: Cursor.pointer,
      backgroundColor: Colors.transparent,
    ),
  

  // moon inner circle
  css('.theme-toggle__inner-moon #inner-moon-circle').styles(
    transition: Transition(
      'transform,color',
      curve: Curve.cubicBezier(0.5, -0.5, 0.5, 1.5),
      duration: Duration(milliseconds: 500),
    ),
  ),

  // LIGHT MODE: hide the moon (or move it out of view)
  css('.theme-toggle[data-theme="light"]', [
    css('&').styles(
      color: Colors.black, // button color
    ),
    css('.theme-toggle__inner-moon #inner-moon-circle').styles(
      transform: Transform.translate(x: (-50).px), // move moon out of view
      color: Colors.transparent, // hide moon
    ),
  ]),

  // DARK MODE: show the moon
  css('.theme-toggle[data-theme="dark"]', [
    css('&').styles(
      color: Colors.white, // button color
    ),
    css('.theme-toggle__inner-moon #inner-moon-circle').styles(
      transform: Transform.translate(x:5.px), // moon visible
      color: Colors.white, // moon color
    ),
  ]),
];

}

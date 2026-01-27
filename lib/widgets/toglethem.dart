import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart';

class ToggleTheme extends StatefulComponent {
  const ToggleTheme({super.key});

  @override
  State<StatefulComponent> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  @override
  Component build(BuildContext context) {
    // watch mode so this component rebuilds when it changes
    final currentMode = context.watch(mode);

    return button(
      classes: 'mode-button',
      attributes: {'aria-label': 'Toggle theme'},
      onClick: () {
        final newMode = currentMode == 'dark' ? 'light' : 'dark';
        context.read(mode.notifier).state = newMode;
        print('Toggled mode to $newMode');
      },
      [
        div(
          styles: Styles(
            display: Display.flex,
            width: 150.px,
            height: 150.px,
           justifyContent: .center,
            alignItems: .center,
          ),
          [
            img(
              src: 'images/moon1.png',
              alt: 'light/dark mode',
              styles: Styles(
                width:65.px,
                height: 65.px,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

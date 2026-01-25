import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
// import 'dart:html' as dom;

@client
class ToogleTheme extends StatefulComponent{
  const ToogleTheme({super.key});

 @override
  State<StatefulComponent> createState() => ToogleThemeState();
}

class ToogleThemeState extends State<ToogleTheme> {
  @override
  Component build(BuildContext context) {
    return button(
      classes: 'mode-button',
      attributes: {'aria-label': 'Toggle theme'},
      onClick: () {
        // final currdocument = document.getElementsByClassName('data-theme');
        // final currentTheme = currdocument.get('data-theme')== 'dark' ? 'dark' : 'light';
        // final htmlElement = document.documentElement!;
      //  htmlElement.setAttribute('data-theme', currentTheme == 'dark' ? 'light' : 'dark');
      },
      [
        img(
          src: 'images/moon1.png',
          alt: 'light/dark mode',
          styles: Styles(
            width: 100.percent,
            height: 100.percent,
          ),
        ),
      ],
    );
  }
  
 
}
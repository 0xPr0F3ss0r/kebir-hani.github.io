import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:my_portfolio/pages/contact.dart';
import 'package:my_portfolio/widgets/main.wrapper.dart';

import 'components/header.dart';
import 'pages/about.dart';
import 'pages/home.dart';
import 'pages/projects.dart';
// The main component of your application.
//
// By using multi-page routing, this component will only be built on the server during pre-rendering and
// **not** executed on the client. Instead only the nested [Home] and [About] components will be mounted on the client.

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    print('start build app');
    // print('mode value in app.dart: ${mode.value}');
    // This method is rerun every time the component is rebuilt.

    // Renders a <div class="main"> html element with children.
    return div(classes: 'main', [
      // link(href: 'https://fonts.googleapis.com/css2?family=DynaPuff&display=swap', rel: 'stylesheet'),
      Header(),
      Router(
        routes: [
          Route(path: '/', title: 'Home', builder: (context, state) => const Home()),
          Route(path: '/about', title: 'About', builder: (context, state) => const About()),
          Route(path: '/projects', title: 'projects', builder: (context, state) => const projects()),
          Route(path: '/contact', title: 'contact', builder: (context, state) => const contact()),
        ],
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.main', [
      // The '&' refers to the parent selector of a nested style rules.
      css('&').styles(
        height: 100.vh,
        flexDirection: .column,
        flexWrap: .wrap,
        backgroundColor:  Colors.black ,
      ),
      css('.section').styles(
        //  display: Display.flex,
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
        flex: Flex(grow: 1),
      ),
      // css('section').styles(
      //   display: .flex,
      //   flexDirection: .column,
      //   justifyContent: .center,
      //   alignItems: .center,
      //   flex: Flex(grow: 1),
      // ),
    ]),
    ...Header.styles,
    ...Home.styles,
    ...About.styles,
  ];
  // Defines the css styles for elements of this component.
  //
  // By using the @css annotation, these will be rendered automatically to css inside the <head> of your page.
  // Must be a variable or getter of type [List<StyleRule>].
}

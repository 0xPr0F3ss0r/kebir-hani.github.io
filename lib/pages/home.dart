import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/components/start_section.dart';
import 'package:my_portfolio/constants/theme.dart';

import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;


// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.
@client
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    String currentMode = context.watch(state_management.mode);
    return div(id: 'wrapper',styles: Styles(
      backgroundColor: currentMode == 'dark' ? Colors.black : Colors.white,
    ), [
     StartSection(),
      section(id: 'about', [
        div(classes: 'container', [
          div(classes: 'cta', [
            h1(styles: Styles(color: whiteColor), [.text('the second page !')]),
            p(styles: Styles(color: whiteColor), [.text('flutter developer for the second page.')]),
          ]),
        ]),
      ]),
      section(id: 'portfolio', [
        div(classes: 'container', [
          div(classes: 'cta', [
            h1(styles: Styles(color: whiteColor), [.text('portfolio !')]),
            p(styles: Styles(color: whiteColor), [.text('flutter developer fot the third page.')]),
          ]),
        ]),
      ]),
    ]);
  }

  static get styles => [
    css('section').styles(
      display: Display.flex,
      minHeight: 100.vh,
      flexWrap: FlexWrap.wrap,
      backgroundPosition: BackgroundPosition(offsetX: 50.percent),
      backgroundRepeat: BackgroundRepeat.noRepeat,
      backgroundSize: BackgroundSize.cover,
      raw: {'-o-background-size': 'cover', 'webkit-background-size': 'cover', '-moz-background-size': 'cover'},
    ),
    css('.container').styles(
      width: 83.3.percent,
      padding: Spacing.only(top: 6.rem,bottom: 6.rem),
      margin: Spacing.only(left: Unit.auto, right: Unit.auto),
    ),
     ...StartSection.styles,
     StyleRule.media(query: MediaQuery.screen(minWidth: 1000.px), styles: [

     ])
  ];
}

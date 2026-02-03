import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/components/start_section.dart';
import 'package:my_portfolio/pages/about.dart';
import 'package:my_portfolio/pages/contact.dart';
import 'package:my_portfolio/pages/projects.dart';
import 'package:my_portfolio/pages/skills.dart';
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
    const String skillsId = 'section-skills';
    const String aboutId  = 'section-about';
    const String projectsId = 'section-projects';
    const String contactId = 'section-contact';

    return div(
      classes: 'home-page',
      id: 'wrapper',
      styles: Styles(
        display: Display.flex,
        width: 100.percent, 
        height: Unit.auto,
        flexDirection: FlexDirection.column,                    
        backgroundColor: currentMode == 'dark' ? Colors.black : Colors.white,
      ),
      [
     
                StartSection(),
        About(id: aboutId),
        Myskills(id: skillsId),
        ProjectsSection(id: projectsId),
        Contact(id: contactId),
      ],
    );
  }

  static get styles => [
    // All sections flow naturally
    css('section').styles(

      display: Display.flex,
      flexDirection: FlexDirection.column, 
      flexWrap: FlexWrap.wrap,
      backgroundPosition: BackgroundPosition(offsetX: 50.percent),
      backgroundRepeat: BackgroundRepeat.noRepeat,
      backgroundSize: BackgroundSize.cover,
      raw: {
        '-o-background-size': 'cover',
        'webkit-background-size': 'cover',
        '-moz-background-size': 'cover',
      },
    ),

    // Container inside sections
    css('.container').styles(
      width: 83.3.percent,
      padding: Spacing.only(top: 6.rem, bottom: 6.rem),
      margin: Spacing.only(left: Unit.auto, right: Unit.auto),
    ),

    ...StartSection.styles,
    ...About.styles,
    ...Myskills.styles,
    ...ProjectsSection.styles,
    ...Contact.styles,
  ];
}

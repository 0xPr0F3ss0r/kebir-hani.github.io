import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/components/animated_projects_card.dart';
import 'package:my_portfolio/components/animated_terminal.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/model/projects_model.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;
// Project model


// Unique projects
final projects = [
  Project('1', 'Restaurant App', 'A beautiful mobile app built with Flutter.', 'mobile', 'images/restaurant.jpg', ['Flutter', 'Dart','Bloc State mangement']),
  Project('2', 'Portfolio Website', 'My web app portfolio project.', 'web', 'images/portfolio1.jpg', ['HTML', 'CSS', 'Dart']),
  Project('3', 'Network scanner', 'Cybersecurity project exploring vulnerabilities.', 'cybersecurity', 'images/tool21.jpg', ['Python', 'Socket']),
  Project('4', 'weather App', 'weather app  project.', 'mobile', 'images/weather.jpg', ['Flutter', 'Dart','Weather Api']),
];

final categories = ['all', 'mobile', 'web', 'cybersecurity'];

// Theme provider


class ProjectsSection extends StatefulComponent {
  final String id;
  const ProjectsSection({super.key, required this.id});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();

  static List<StyleRule> get styles => [
        css('.project-section h3').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.5.em, vertical: 0.25.em),
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
    css('.project-section h3.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
  ];
}


class _ProjectsSectionState extends State<ProjectsSection> {
  String activeCategory = 'all';
  bool filled = false;
  
  List<Project> get filteredProjects {
    if (activeCategory == 'all') return projects;
    return projects.where((p) => p.category == activeCategory).toList();
  }
   
    @override
  void initState() {
    super.initState();
    
    if (kIsWeb) {
          Future.microtask(() => _startObserving()
          );
    }else{
      print('no');
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
            Future.delayed(Duration(seconds: 3), () {
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
    String currentTheme = context.watch(state_management.mode);
    Color textColor = currentTheme == 'dark' ? whiteColor : Colors.black;

    return section(
      id: component.id,
      classes: 'project-section',
      styles: Styles(
        display: .flex,
        padding: Spacing.all(20.px),
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
        textAlign: .center, // Add some padding
      ),
      [
        // Header
        TerminalLine(),
        h2(
          classes: filled ? 'fill': '',
          styles: Styles(
            margin: Spacing.symmetric(vertical: 20.px),
            color: textColor,
            fontFamily: FontFamily("DynaPuff"),
            fontSize: 36.px,
            fontWeight: FontWeight.bold,
          ),
          [.text('Part of My Projects')],
        ),

        // Category tabs
        div(
          classes: 'category-tabs',
          styles: Styles(
            display: Display.flex,
            margin: Spacing.only(bottom: 30.px),
            justifyContent: JustifyContent.center,
            alignItems: AlignItems.center,
            gap: Gap.all(15.px),
          ),
          [
            for (var category in categories)
              button(
                styles: Styles(
                  display: Display.inlineFlex,
                  padding: Spacing.symmetric(vertical: 6.px, horizontal: 20.px),
                  border: Border.all(color: activeCategory == category ? Colors.blue : Colors.gray),
                  radius: BorderRadius.circular(10.px),
                  cursor: Cursor.pointer,
                  justifyContent: JustifyContent.center,
                  alignItems: AlignItems.center,
                  color: activeCategory == category ? Colors.white : Colors.gray,
                  backgroundColor: activeCategory == category ? Colors.blue : Colors.transparent,
                  raw: {'transition': 'all 0.3s ease'},
                ),
                onClick: () {
                  setState(() {
                    activeCategory = category;
                  });
                },
                [.text(category.toUpperCase())],
              ),
          ],
        ),

        // Projects grid
        div(
          classes: 'projects-grid',
          styles: Styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(30.px),
          ),
          [
            for (var i = 0; i < filteredProjects.length; i++)
              AnimatedProjectCard(
                project: filteredProjects[i],
                index: i,
              ),
          ],
        ),

        // Empty state
        if (filteredProjects.isEmpty)
          div(
            styles: Styles(
              margin: Spacing.only(top: 50.px),
              textAlign: TextAlign.center,
            ),
            [
              p(
                styles: Styles(color: textColor, fontSize: 18.px),
                [.text('No projects found.')],
              ),
            ],
          ),
      ],
    );
  }
}

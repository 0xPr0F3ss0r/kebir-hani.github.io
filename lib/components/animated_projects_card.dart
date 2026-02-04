import 'dart:async';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/model/projects_model.dart';
// ignore: library_prefixes
import 'package:my_portfolio/state_management/light-dark-mode.dart' as themeMode;


class AnimatedProjectCard extends StatefulComponent {
  final Project project;
  final int index;

  const AnimatedProjectCard({super.key, required this.project, required this.index});

  @override
  State<AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<AnimatedProjectCard> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    if(kIsWeb){
      Timer(Duration(milliseconds: component.index * 150), () {
      setState(() {
        isVisible = true;
      });
    });
    }

    
  }

  @override
  Component build(BuildContext context) {
    String currentTheme = context.watch(themeMode.mode);
    Color textColor = currentTheme == 'dark' ? Colors.white : Colors.black;
    return a(
      href: component.project.link,
      target: Target.blank,
      styles: Styles(
        textDecoration: TextDecoration(line: TextDecorationLine.none),
        color: textColor,
      ),
      [
        div(
          styles: Styles(
            width: component.project.title.contains('Restaurant App') || component.project.title.contains('weather App')? 200.px:280.px,
            height:component.project.title.contains('Restaurant App') || component.project.title.contains('weather App')? 400.px:400.px,
            radius: BorderRadius.circular(20.px),
            opacity: isVisible ? 1 : 0,
            overflow: Overflow.hidden,
            shadow: isVisible
                ? BoxShadow(
                    offsetX: 0.px,
                    offsetY: 12.px,
                    blur: 30.px,
                    color: currentTheme == 'dark' ? Colors.black.withOpacity(0.25) : Colors.white.withOpacity(0.25),
                  )
                : BoxShadow(
                    offsetX: 0.px,
                    offsetY: 8.px,
                    blur: 20.px,
                    color: currentTheme == 'dark' ? Colors.black.withOpacity(0.15) : Colors.gray.withOpacity(0.15),
                  ),
            cursor: Cursor.pointer,
            transition: Transition(
              'transform',
              duration: Duration(milliseconds: 600),
              delay: Duration(milliseconds: component.index * 150), 
            ),
            transform: Transform.combine([
              Transform.translate(
                x: 0.px,
                y: isVisible ? 0.px : 30.px,
              ),
              Transform.scale(
                isVisible ? 1.0 : 0.95,
              ),
            ]),
          ),
          [
            // Image
            img(
              src: component.project.image,
              alt: component.project.title,
              styles: Styles(
                width:component.project.title.contains('Restaurant App') || component.project.title.contains('weather App')? 100.px:280.px ,
                height:component.project.title.contains('Restaurant App') || component.project.title.contains('weather App')? 200.px:160.px,
                raw: {' transition': 'transform 0.4s ease'},
              ),
            ),

            // Content
            div(
              [
                h3(
                  styles: Styles(color: textColor, fontSize: 20.px, fontWeight: FontWeight.bold),
                  [.text(component.project.title)],
                ),
                p(
                  styles: Styles(
                    color: textColor.withOpacity(0.7),
                    fontSize: 14.px,
                    lineHeight: Unit.em(1.5),
                  ),
                  [.text(component.project.description)],
                ),

                // Tech stack badges
                div(
                  [
                    for (var tech in component.project.techStack)
                      span(
                        styles: Styles(
                          padding: Spacing.symmetric(vertical: 4.px, horizontal: 8.px),
                          radius: BorderRadius.circular(10.px),
                          color: textColor,
                          fontSize: 12.px,
                          backgroundColor: currentTheme == 'dark' ? Colors.black : whiteColor,
                        ),
                        [.text(tech)],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


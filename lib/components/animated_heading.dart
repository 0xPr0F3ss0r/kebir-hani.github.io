import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;
import 'package:universal_web/js_interop.dart';

class AnimatedHeading extends StatefulComponent {
  final String text;
  final String tag; // h1, h2, h3
  final Styles? styles;

  const AnimatedHeading.h1(this.text, {this.styles, super.key}) : tag = 'h1';
  const AnimatedHeading.h2(this.text, {this.styles, super.key}) : tag = 'h2';
  const AnimatedHeading.h3(this.text, {this.styles, super.key}) : tag = 'h3';

  @override
  State<AnimatedHeading> createState() => _AnimatedHeadingState();

  @css
  static List<StyleRule> get mystyles => [
    css('.fill-heading').styles(
      raw: {
        'color': 'transparent',
        'background-image': 'linear-gradient(to right, blue 0%, blue 100%)',
        'background-size': '0% 100%',
        'background-repeat': 'no-repeat',
        'background-position': 'left center',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'transition': 'background-size 600ms ease-in-out',
      },
    ),
    css('.fill-heading.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
  ];
}

class _AnimatedHeadingState extends State<AnimatedHeading> {
  bool filled = false;
  late final String _id = 'heading_${UniqueKey().hashCode}';

  @override
  void initState() {
    super.initState();
    if(kIsWeb){
    Future.microtask(_observe);
    }
  }

  void _observe() {
    final options = web.IntersectionObserverInit(threshold: 0.3.toJS);

    final observer = web.IntersectionObserver((entries, _) {
      for (var entry in entries.toDart) {
        final e = entry as web.IntersectionObserverEntry;
        if (e.isIntersecting && mounted) {
          setState(() => filled = true);
        }
      }
    }.toJS, options);

    final el = web.document.getElementById(_id);
    if (el != null) observer.observe(el);
  }

  @override
  Component build(BuildContext context) {
    final classes = 'fill-heading ${filled ? 'fill' : ''}';

    final children = [Component.text(component.text)];

    switch (component.tag) {
      case 'h1':
        return h1(id: _id, classes: classes, styles: component.styles, children);
      case 'h2':
        return h2(id: _id, classes: classes, styles: component.styles, children);
      default:
        return h3(id: _id, classes: classes, styles: component.styles, children);
    }
  }
}

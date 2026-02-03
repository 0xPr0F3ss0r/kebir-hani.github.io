import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class VideoBackground extends StatelessComponent {
  const VideoBackground({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'video-bg',
      [
        video(
          autoplay: true,
          muted: true,
          loop: true,
       
          preload: Preload.auto,
          styles: Styles(
            width: 100.percent,
            height: 100.percent,
            raw: {
              'object-fit': 'cover',
            },
          ),
          [
            source(
              src: '/images/animation.mp4',
              type: 'video/mp4',
            ),
          ],
        ),
      ],
    );
  }

  static get styles => [
    css('.video-bg').styles(
      raw: {
        'position': 'absolute',
        'top': '0',
        'left': '0',
        'width': '100%',
        'height': '100%',
        'z-index': '0',
        'overflow': 'hidden',
        'pointer-events': 'none',
      },
    ),
 
  ];
}

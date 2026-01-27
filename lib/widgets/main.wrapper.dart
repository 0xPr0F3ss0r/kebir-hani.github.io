import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart';


final container = ProviderContainer();


@client
class MainWrapper extends StatelessComponent {
  final Component child;
    const MainWrapper({super.key, required this.child});

  @override
  Component build(BuildContext context) {
    return UncontrolledProviderScope(
            container: container,
            child: Builder(
              builder: (context) {
                 final newMode = context.watch(mode);
          print('mode in main wrapper (client): $newMode');
              
              return div(
              styles: Styles(
                 backgroundColor: newMode == 'dark' ? Colors.black : Colors.white,
              minHeight: 100.vh,
              ),
              [child],
              
              );
              }, 
            )
           );
      
       
  }
  
}

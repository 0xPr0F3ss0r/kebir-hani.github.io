import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart';
import 'package:signals/signals_core.dart';

@client
class MainWrapper extends StatefulComponent {
  final Component child;
    MainWrapper({super.key, required this.child});
  @override
  State<StatefulComponent> createState() => _MainWrapperState();
}
class _MainWrapperState extends State<MainWrapper> {

  
  late Signal<String> _mode;

  @override
  void initState() {
    super.initState();
    // Use the signal
    _mode = mode; 
  }

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(backgroundColor: mode.value == 'dark' ? Colors.black : Colors.white,
              minHeight: 100.vh,
),
      [  SignalBuilder(builder: (context) => component.child)],
    );
  }
  
}

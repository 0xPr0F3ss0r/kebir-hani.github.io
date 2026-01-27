import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client

class contact extends StatefulComponent{
  const contact({super.key});
  @override
  State<contact> createState() => contactState();
}

class contactState extends  State<contact> {
  @override
  Component build(BuildContext context) {
   print('this is from contact page');
   return section(
    [
      p([.text("this is contact section")])
    ]
   );
  }
  
}
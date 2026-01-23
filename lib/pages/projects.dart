import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class projects extends StatefulComponent{
  const projects({super.key});

  @override
  State<projects> createState()=> projectsState();
}

class projectsState extends State<projects>{
  @override
  Component build(BuildContext context) {
    return section(
     [
      p([.text("projects section")])
     ]  
    );
  }
  
}
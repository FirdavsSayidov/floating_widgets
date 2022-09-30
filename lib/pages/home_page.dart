import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OverlayEntry? entry;
  Offset offset = Offset(120, 40);
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_)=>  showOverlay());
  }

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Floating widgets"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding:EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton.icon(onPressed: showOverlay, icon: Icon(Icons.visibility), label: Text('Show Floating Widget')),
          ElevatedButton.icon(onPressed: hideOverlay, label: Text('Hide Floating Widgets'),icon: Icon(Icons.visibility_off),)
        ],
        ),
      ),
    );
  }

  void showOverlay(){
    entry = OverlayEntry(builder: (context) => Positioned(
      height: 50,
      width: 150,
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details){
          setState(() {
            offset += details.delta;
            entry!.markNeedsBuild();
          });
        },
        child: ElevatedButton.icon(
          icon: Icon(Icons.stop_circle_rounded),
          label: Text('Record'),
          onPressed: (){},
        ),
      ),
    ));
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }

  void hideOverlay(){
    entry?.remove();
    entry = null;
  }
}

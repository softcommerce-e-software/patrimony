import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomViewPage extends StatefulWidget {
  const BottomViewPage({Key? key}) : super(key: key);

  @override
  createState() => _BottomViewPageState();
}

class _BottomViewPageState extends State<BottomViewPage> {
  ValueNotifier<int> selectedPageValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    Modular.to.navigate('/bottom_view/home/');
    // Modular.to.addListener(onChangeRoute);
  }

  @override
  void dispose() {
    Modular.to.removeListener(onChangeRoute);
    super.dispose();
  }

  void onChangeRoute() {
    if (Modular.to.path.contains('home')) {
      selectedPageValueNotifier.value = 0;
    }
    if (Modular.to.path.contains('history')) {
      selectedPageValueNotifier.value = 1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      // bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedPageValueNotifier.value,
      onTap: (index) {
        if (index == 0) {
          Modular.to.navigate('/bottom_view/home/');
        }
        if (index == 1) {
          Modular.to.navigate('/bottom_view/history/');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Casa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Histórico',
        ),
      ],
    );
  }
}
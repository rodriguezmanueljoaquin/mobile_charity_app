import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/pages/login.dart';
import 'package:mobile_charity_app/pages/register.dart';
import 'package:mobile_charity_app/pages/welcome.dart';
import 'package:mobile_charity_app/utils/validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SER MANOS',
      // home: LoginPage(),
      // home: HomePage(),
      // home: RegisterPage(),
      home: WelcomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(89.0),
              child: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [SerManosLogos.appBar, const Spacer()],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: ColoredBox(
                    color: Colors.blue[300]!,
                    child: TabBar(
                      unselectedLabelColor: Color.fromARGB(255, 216, 244, 54),
                      indicator: BoxDecoration(
                        color: Colors.blue[500]!,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white, // Color for the indicator line
                            width: 2.0, // Thickness of the indicator line
                          ),
                        ),
                      ),
                      tabs: [
                        Tab(
                          text: 'POSTULARSE',
                        ),
                        Tab(
                          text: 'MI PERFIL',
                        ),
                        Tab(
                          text: 'NOVEDADES',
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SerManosButton.shortButton(
                  text: 'test',
                  onPressed: () {},
                ),
                SerManosTextFormField(
                    label: "Label",
                    placeholder: "Placeholder",
                    controller: TextEditingController(),
                    validator: emailValidator)
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const SerManosIcon.add(),
          ),
        ));
  }
}

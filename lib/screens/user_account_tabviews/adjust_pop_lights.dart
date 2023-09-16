import 'package:flutter/material.dart';

class AdjustPopLights extends StatefulWidget {
  const AdjustPopLights({Key? key}) : super(key: key);

  @override
  State<AdjustPopLights> createState() => _AdjustPopLightsState();
}

class _AdjustPopLightsState extends State<AdjustPopLights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/add_pop_light_background.png"), fit: BoxFit.fill),

        ),


      ),
    );
  }
}

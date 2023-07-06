import 'package:flutter/material.dart';

class Speed extends StatelessWidget {
  const Speed({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speedometer'),
      ),
      body: Column(
        children: [
          Center(
            child: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/"),
                child: const Text('Go back!'),
              );
            }),
          ),
          Text(data[0])
        ],
      ),
    );
  }
}

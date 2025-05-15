import 'package:flutter/material.dart';
import 'package:flutter_caching/core.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  Widget build(context, CounterController controller) {
    controller.view = this;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: controller.counter > 0 ? controller.decrement : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '${controller.counter}',
                style: const TextStyle(fontSize: 32.0),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: controller.increment,
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<CounterView> createState() => CounterController();
}

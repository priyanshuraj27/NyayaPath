import 'package:flutter/material.dart';

class ResourceStatePage extends StatelessWidget {
  const ResourceStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final states = [
      {'name': 'Maharashtra', 'image': 'assets/states/maharashtra.jpeg'},
      {'name': 'Kerala', 'image': 'assets/states/kerala.png'},
      {'name': 'Bihar', 'image': 'assets/states/bihar.jpeg'},
      {'name': 'Uttar Pradesh', 'image': 'assets/states/uttar_pradesh.jpeg'},
      {'name': 'Rajsthan', 'image': 'assets/states/rajasthan.png'},
      {'name': 'Gujarat', 'image': 'assets/states/gujrat.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Resources by State')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: states.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 2.5,
        ),
        itemBuilder: (context, index) {
          final state = states[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${state['name']}')),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        state['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      state['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FullLoaderWidget extends StatelessWidget {
  const FullLoaderWidget({super.key});

  Stream<String> loadingMessages() {
    final messages = [
      'Cargando peliculas',
      'Prepara tu combo 🍿🥤🥨',
      'Cargando populares',
      'Tu relax, 💆',
      'Cargando próximas peliculas',
      'Ya casi, no te vayas 🙈',
      '....',
      '🤨🫤',
      '....',
      'Ok, esto ya tardo mucho, 😢',
      '....',
      'Y si empezamos de nuevo, 🥹',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Cargando...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: loadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('...');
              }

              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}

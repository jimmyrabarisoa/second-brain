import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notes_provider.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Second Brain')),
      body: notes.when(
        data: (list) => list.isEmpty
            ? const Center(child: Text('Aucune note. Créez-en une !'))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final note = list[i];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: note.isSynced
                        ? const Icon(Icons.cloud_done, color: Colors.green)
                        : const Icon(Icons.cloud_off, color: Colors.grey),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // TODO: navigation vers l'éditeur
        child: const Icon(Icons.add),
      ),
    );
  }
}

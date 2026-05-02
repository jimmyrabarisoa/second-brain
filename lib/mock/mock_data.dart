// Modèle de données mock — remplacé progressivement par Drift + API

enum NoteType { note, idea, link, quote, task, image, audio }

class NoteModel {
  final String id;
  final String title;
  final String excerpt;
  final NoteType type;
  final List<String> tags;
  final DateTime updatedAt;
  final String? para;
  final String? projectId;
  final bool important;
  final bool toReview;
  final bool unsorted;

  const NoteModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.type,
    required this.tags,
    required this.updatedAt,
    this.para,
    this.projectId,
    this.important = false,
    this.toReview = false,
    this.unsorted = false,
  });
}

class ProjectModel {
  final String id;
  final String name;
  final String goal;
  final DateTime? deadline;
  final int progress; // 0-100
  final int noteCount;
  final int taskCount;
  final String color;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.goal,
    this.deadline,
    required this.progress,
    required this.noteCount,
    required this.taskCount,
    required this.color,
  });
}

class LifeArea {
  final String id;
  final String name;
  final String emoji;
  final int noteCount;

  const LifeArea({
    required this.id,
    required this.name,
    required this.emoji,
    required this.noteCount,
  });
}

class LibrarySubject {
  final String id;
  final String name;
  final int noteCount;

  const LibrarySubject({
    required this.id,
    required this.name,
    required this.noteCount,
  });
}

// ── Données mock ──────────────────────────────────────────────────────────────

final mockNotes = <NoteModel>[
  NoteModel(
    id: 'n1',
    title: 'Construire une routine matinale',
    excerpt: 'Se lever à 6h, méditer 10 min, écrire 3 intentions de la journée.',
    type: NoteType.idea,
    tags: ['santé', 'habitudes'],
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    important: true,
    toReview: false,
    unsorted: false,
    para: 'domain',
  ),
  NoteModel(
    id: 'n2',
    title: 'Article : Deep Work de Cal Newport',
    excerpt: 'Le travail en profondeur est la capacité à se concentrer sans distraction sur une tâche cognitivement exigeante.',
    type: NoteType.quote,
    tags: ['lecture', 'productivité'],
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    toReview: true,
    unsorted: false,
    para: 'library',
  ),
  NoteModel(
    id: 'n3',
    title: 'Idée app : widget de capture rapide',
    excerpt: 'Un widget home screen pour capturer une idée en 2 taps sans ouvrir l\'app.',
    type: NoteType.idea,
    tags: ['flutter', 'ux'],
    updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
    unsorted: true,
    projectId: 'p1',
  ),
  NoteModel(
    id: 'n4',
    title: 'Revoir la stack backend',
    excerpt: 'Comparer Supabase vs PocketBase pour le projet Second Brain.',
    type: NoteType.task,
    tags: ['tech', 'backend'],
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    unsorted: true,
  ),
  NoteModel(
    id: 'n5',
    title: 'Citation : Les Stoïciens',
    excerpt: '"Ce n\'est pas ce qui nous arrive qui nous affecte, mais l\'idée que l\'on s\'en fait." — Épictète',
    type: NoteType.quote,
    tags: ['philosophie'],
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    toReview: true,
    unsorted: false,
    para: 'library',
  ),
  NoteModel(
    id: 'n6',
    title: 'Lien : Flutter Riverpod best practices',
    excerpt: 'https://riverpod.dev/docs/concepts/providers',
    type: NoteType.link,
    tags: ['flutter', 'riverpod'],
    updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    unsorted: false,
    para: 'library',
    projectId: 'p1',
  ),
];

final mockProjects = <ProjectModel>[
  ProjectModel(
    id: 'p1',
    name: 'Second Brain App',
    goal: 'Lancer la v1 de l\'application mobile d\'ici fin juin',
    deadline: DateTime(2026, 6, 30),
    progress: 35,
    noteCount: 12,
    taskCount: 8,
    color: '#2563EB',
  ),
  ProjectModel(
    id: 'p2',
    name: 'Remise en forme',
    goal: 'Courir 5 km sans s\'arrêter avant l\'été',
    deadline: DateTime(2026, 7, 1),
    progress: 60,
    noteCount: 5,
    taskCount: 3,
    color: '#16A34A',
  ),
  ProjectModel(
    id: 'p3',
    name: 'Formation Flutter avancé',
    goal: 'Maîtriser les animations et l\'architecture clean',
    progress: 20,
    noteCount: 9,
    taskCount: 15,
    color: '#7C3AED',
  ),
];

final mockLifeAreas = <LifeArea>[
  LifeArea(id: 'la1', name: 'Travail',    emoji: '💼', noteCount: 24),
  LifeArea(id: 'la2', name: 'Santé',      emoji: '🏃', noteCount: 11),
  LifeArea(id: 'la3', name: 'Finances',   emoji: '💰', noteCount: 7),
  LifeArea(id: 'la4', name: 'Formation',  emoji: '📚', noteCount: 18),
  LifeArea(id: 'la5', name: 'Personnel',  emoji: '🌱', noteCount: 9),
];

final mockLibrarySubjects = <LibrarySubject>[
  LibrarySubject(id: 's1', name: 'Flutter',        noteCount: 14),
  LibrarySubject(id: 's2', name: 'Productivité',   noteCount: 9),
  LibrarySubject(id: 's3', name: 'Stoïcisme',      noteCount: 6),
  LibrarySubject(id: 's4', name: 'Nutrition',      noteCount: 4),
  LibrarySubject(id: 's5', name: 'Marketing',      noteCount: 7),
];

final popularTags = ['flutter', 'productivité', 'santé', 'lecture', 'tech', 'habitudes', 'philosophie'];

final mockStats = {
  'unsortedCount': mockNotes.where((n) => n.unsorted).length,
  'toReviewCount': mockNotes.where((n) => n.toReview).length,
  'totalNotes':    mockNotes.length,
  'totalProjects': mockProjects.length,
};

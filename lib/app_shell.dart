import 'package:flutter/material.dart';
import 'shared/widgets/bottom_nav.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/projects/presentation/pages/projects_screen.dart';
import 'features/projects/presentation/pages/project_screen.dart';
import 'features/library/presentation/pages/library_screen.dart';
import 'features/search/presentation/pages/search_screen.dart';
import 'features/capture/presentation/pages/capture_screen.dart';
import 'features/inbox/presentation/pages/inbox_screen.dart';
import 'features/inbox/presentation/pages/sort_screen.dart';
import 'features/notes/presentation/pages/notes_screen.dart';
import 'features/notes/presentation/pages/note_detail_screen.dart';
import 'features/review/presentation/pages/review_screen.dart';
import 'features/profile/presentation/pages/profile_screen.dart';

sealed class _Screen {}
class _Home extends _Screen {}
class _Projects extends _Screen {}
class _Library extends _Screen {}
class _Search extends _Screen {}
class _Inbox extends _Screen {}
class _Sort extends _Screen { final String noteId; _Sort(this.noteId); }
class _ProjectDetail extends _Screen { final String id; _ProjectDetail(this.id); }
class _NoteDetail extends _Screen { final String id; _NoteDetail(this.id); }
class _Review extends _Screen {}
class _Profile extends _Screen {}
class _Notes extends _Screen {}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _navIndex = 0;
  final List<_Screen> _stack = [_Home()];
  bool _captureOpen = false;

  _Screen get _current => _stack.last;

  void _push(_Screen screen) => setState(() => _stack.add(screen));
  void _pop() => setState(() { if (_stack.length > 1) _stack.removeLast(); });

  void _onNavTap(int index) {
    setState(() {
      _navIndex = index;
      _stack
        ..clear()
        ..add(switch (index) {
          0 => _Home(),
          1 => _Projects(),
          3 => _Library(),
          4 => _Search(),
          _ => _Home(),
        });
    });
  }

  Widget _buildCurrent() {
    return switch (_current) {
      _Home() => HomeScreen(
          onOpenInbox:   () => _push(_Inbox()),
          onOpenReview:  () => _push(_Review()),
          onOpenProject: (id) => _push(_ProjectDetail(id)),
          onOpenNote:    (id) => _push(_NoteDetail(id)),
        ),
      _Projects() => ProjectsScreen(
          onOpenProject: (id) => _push(_ProjectDetail(id)),
        ),
      _ProjectDetail(id: final id) => ProjectScreen(
          projectId:  id,
          onOpenNote: (nid) => _push(_NoteDetail(nid)),
        ),
      _Library() => const LibraryScreen(),
      _Search() => SearchScreen(
          onOpenNote: (id) => _push(_NoteDetail(id)),
        ),
      _Inbox() => InboxScreen(
          onSort: (id) => _push(_Sort(id)),
        ),
      _Sort(noteId: final id) => SortScreen(
          noteId: id,
          onDone: _pop,
        ),
      _NoteDetail(id: final id) => NoteDetailScreen(noteId: id),
      _Review() => ReviewScreen(
          onOpenNote: (id) => _push(_NoteDetail(id)),
        ),
      _Profile() => const ProfileScreen(),
      _Notes() => NotesScreen(
          onOpenNote: (id) => _push(_NoteDetail(id)),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Navigator(
            pages: [MaterialPage(child: _buildCurrent())],
            onDidRemovePage: (_) {},
          ),
          if (_stack.length > 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 8,
              child: SafeArea(
                child: IconButton(
                  onPressed: _pop,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _stack.length == 1
          ? BottomNav(
              currentIndex: _navIndex,
              onTap: _onNavTap,
              onCapture: () => setState(() => _captureOpen = true),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_captureOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_captureOpen) return;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => CaptureScreen(
            onClose: () {
              Navigator.pop(context);
              setState(() => _captureOpen = false);
            },
            onSortNow: () {
              Navigator.pop(context);
              setState(() {
                _captureOpen = false;
                _stack.add(_Inbox());
              });
            },
          ),
        ).whenComplete(() => setState(() => _captureOpen = false));
        _captureOpen = false;
      });
    }
  }
}

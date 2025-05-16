

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isHovering = false;
  bool _isTapped = false;

  void _toggleTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme();
    setState(() {
      _isTapped = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isTapped = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme Switcher",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
        backgroundColor: colorScheme.primary,
        actions: [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _toggleTheme,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark
                                ? Colors.black54
                                : Colors.grey.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color:
                          _isTapped ? colorScheme.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          isDark ? Icons.dark_mode : Icons.light_mode,
                          key: ValueKey<bool>(isDark),
                          size: 60,
                          color: isDark ? Colors.amber[300] : Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Tap here or the icon above to switch themes!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              AnimatedOpacity(
                opacity: _isHovering ? 1.0 : 0.6,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  "Try hovering over the theme icon ↑",
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTheme,
        backgroundColor: colorScheme.primary,
        child: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveApp());
}

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder provides constraints based on the parent widget's size.
    // It's excellent for responsive layouts because it reacts to actual available space.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Design Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoints definition
          if (constraints.maxWidth < 600) {
            // Mobile Layout (< 600px)
            return const MobileLayout();
          } else if (constraints.maxWidth < 900) {
            // Tablet Layout (600px - 899px)
            return const TabletLayout();
          } else {
            // Web/Desktop Layout (>= 900px)
            return const DesktopLayout();
          }
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MOBILE LAYOUT (Adapts naturally without hardcoded widths)
// -----------------------------------------------------------------------------
class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            leading: const Icon(Icons.phone_android, color: Colors.indigo),
            title: Text('Mobile Item $index'),
            subtitle: const Text('Single column list view'),
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// TABLET LAYOUT (Uses GridView to take advantage of wider screen)
// -----------------------------------------------------------------------------
class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // GridView automatically manages its children's widths based on the crossAxisCount
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns for tablet
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 3 / 1,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Center(
            child: ListTile(
               leading: const Icon(Icons.tablet_mac, color: Colors.indigo),
               title: Text('Tablet Item $index'),
            ),
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// DESKTOP/WEB LAYOUT (Uses Row + Expanded for flexible proportions)
// -----------------------------------------------------------------------------
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar (Flexible proportion instead of hardcoded width)
        // Using Expanded with flex ensures it scales up and down proportionally
        Expanded(
          flex: 2, // Takes 2 parts of the total available width
          child: Container(
            color: Colors.indigo.shade50,
            child: ListView(
              children: const [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.indigo),
                  child: Text(
                    'Desktop Menu', 
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
                ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
                ListTile(leading: Icon(Icons.info), title: Text('About')),
              ],
            ),
          ),
        ),
        
        // Main Content Area
        Expanded(
          flex: 5, // Takes 5 parts of the total available width
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns for Desktop
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 2 / 1,
            ),
            itemCount: 15,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.desktop_windows, size: 32, color: Colors.indigo),
                      const SizedBox(height: 8),
                      Text('Desktop Item $index', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

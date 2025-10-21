import 'package:flutter/material.dart';

class Cinema {
  final String name;
  bool isFavorite;

  Cinema({required this.name, this.isFavorite = false});
}

class CinimaPage extends StatefulWidget {
  const CinimaPage({super.key});

  @override
  State<CinimaPage> createState() => _CinimaPageState();
}

class _CinimaPageState extends State<CinimaPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Cinema> cinemas = [
    Cinema(name: 'AMC Empire 25', isFavorite: true),
    Cinema(name: 'Regal E-Walk 4DX & RPX', isFavorite: false),
    Cinema(name: 'Angelika Film Center', isFavorite: true),
    Cinema(name: 'Nitehawk Cinema', isFavorite: false),
    Cinema(name: 'Alamo Drafthouse', isFavorite: false),
    Cinema(name: 'IFC Center', isFavorite: false),
    Cinema(name: 'Metrograph', isFavorite: true),
    Cinema(name: 'Bow Tie Chelsea Cinemas', isFavorite: true),
    Cinema(name: 'Regal Union Square 14', isFavorite: true),
    Cinema(name: 'AMC Lincoln Square 13', isFavorite: true),
    Cinema(name: 'The Roxy Cinema', isFavorite: true),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleFavorite(int index) {
    setState(() {
      cinemas[index].isFavorite = !cinemas[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              const Text(
                'Your location',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              const Text(
                'New York',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.red,
                size: 20,
              ),
            ],
          ),
        ),

        // Tabs
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.red,
            indicatorWeight: 3,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'All Cinema'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),

        // Tab views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // All Cinema Tab
              _buildCinemaList(cinemas),

              // Favorites Tab
              _buildCinemaList(
                cinemas.where((cinema) => cinema.isFavorite).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCinemaList(List<Cinema> cinemaList) {
    if (cinemaList.isEmpty) {
      return const Center(
        child: Text(
          'No favorite cinemas yet',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: cinemaList.length,
      itemBuilder: (context, index) {
        final cinema = cinemaList[index];
        final originalIndex = cinemas.indexOf(cinema);

        return InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              children: [
                Icon(
                  cinema.isFavorite ? Icons.star : Icons.star_border,
                  color: cinema.isFavorite ? Colors.orange : Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cinema.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.grey),
                  onPressed: () {
                    toggleFavorite(originalIndex);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

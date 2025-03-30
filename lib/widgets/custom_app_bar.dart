import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final TabController tabController;
  final int currentIndex;

  const CustomAppBar({
    Key? key,
    required this.tabController,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "Namit",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const Spacer(),
          if (!isSmallScreen) ...[
            _buildTabButton(context, "Home", 0),
            _buildTabButton(context, "About", 1),
            _buildTabButton(context, "Projects", 2),
            _buildTabButton(context, "Contact", 3),
          ] else ...[
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu),
              onSelected: (index) {
                tabController.animateTo(index);
              },
              itemBuilder: (context) => [
                _buildPopupMenuItem(context, "Home", 0),
                _buildPopupMenuItem(context, "About", 1),
                _buildPopupMenuItem(context, "Projects", 2),
                _buildPopupMenuItem(context, "Contact", 3),
              ],
            ),
          ],
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              // Toggle theme (would need a theme provider in a real app)
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String title, int index) {
    final isSelected = currentIndex == index;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          tabController.animateTo(index);
        },
        style: TextButton.styleFrom(
          foregroundColor: isSelected
              ? theme.colorScheme.primary
              : theme.textTheme.bodyLarge?.color,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(
    BuildContext context,
    String title,
    int index,
  ) {
    final isSelected = currentIndex == index;
    final theme = Theme.of(context);

    return PopupMenuItem<int>(
      value: index,
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../widgets/animated_text.dart';
import '../utils/constants.dart';
import '../widgets/social_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 20 : 40,
          vertical: isSmallScreen ? 30 : 40,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildProfileSection(context),
                const SizedBox(height: 40),
                Text(
                  AppConstants.aboutMe,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                _buildActionButtons(context),
                const SizedBox(height: 40),
                _buildSkillsSection(context),
                const SizedBox(height: 40),
                _buildSocialLinks(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello, I'm",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.name,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedText(
          texts: const [
            "Machine Learning Engineer",
            "App Developer",
            "Data Science Enthusiast",
            "Problem Solver"
          ],
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
          animationDuration: const Duration(milliseconds: 400),
          pauseDuration: const Duration(seconds: 2),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to Contact
            final tabController = DefaultTabController.of(context);
            if (tabController != null) {
              tabController.animateTo(3); // Contact tab index
            }
          },
          icon: const Icon(Icons.mail_outline),
          label: const Text("Contact Me"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            // Navigate to Projects
            final tabController = DefaultTabController.of(context);
            if (tabController != null) {
              tabController.animateTo(2); // Projects tab index
            }
          },
          icon: const Icon(Icons.work_outline),
          label: const Text("View Projects"),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Skills",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.skills.map((skill) {
            return Chip(
              label: Text(skill),
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SocialButton(
          icon: Icons.language,
          url: "https://namit24.github.io",
          tooltip: "Website",
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.code,
          url: AppConstants.github,
          tooltip: "GitHub",
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.person,
          url: AppConstants.linkedin,
          tooltip: "LinkedIn",
        ),
      ],
    );
  }
}


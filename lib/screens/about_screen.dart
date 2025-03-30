import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    
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
      padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Me",
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.aboutMe,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "Skills",
              child: _buildSkills(context),
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "Experience",
              child: _buildExperience(context),
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "Education",
              child: _buildEducation(context),
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "Awards",
              child: _buildAwards(context),
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "Services",
              child: _buildServices(context, isSmallScreen),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildSkills(BuildContext context) {
    return Wrap(
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
    );
  }

  Widget _buildExperience(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppConstants.experience.length,
      itemBuilder: (context, index) {
        final exp = AppConstants.experience[index];
        return _buildTimelineItem(
          context,
          title: exp['position']!,
          subtitle: exp['company']!,
          period: exp['duration']!,
          description: exp['description']!,
        );
      },
    );
  }

  Widget _buildEducation(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppConstants.education.length,
      itemBuilder: (context, index) {
        final edu = AppConstants.education[index];
        return _buildTimelineItem(
          context,
          title: edu['degree']!,
          subtitle: edu['institution']!,
          period: edu['year']!,
        );
      },
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String period,
    String? description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (description != null)
                Container(
                  width: 2,
                  height: 80,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                )
              else
                Container(
                  width: 2,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  period,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context, bool isSmallScreen) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmallScreen ? 1 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isSmallScreen ? 3 : 2,
      ),
      itemCount: AppConstants.services.length,
      itemBuilder: (context, index) {
        final service = AppConstants.services[index];
        IconData iconData;
        
        switch (service['icon']) {
          case 'smartphone':
            iconData = Icons.smartphone;
            break;
          case 'analytics':
            iconData = Icons.analytics;
            break;
          case 'cloud':
            iconData = Icons.cloud;
            break;
          case 'data_usage':
            iconData = Icons.data_usage;
            break;
          default:
            iconData = Icons.code;
        }
        
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  service['title']!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    service['description']!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAwards(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppConstants.awards.length,
      itemBuilder: (context, index) {
        final award = AppConstants.awards[index];
        return _buildAwardItem(
          context,
          title: award['title']!,
          date: award['date']!,
          description: award['description']!,
        );
      },
    );
  }

  Widget _buildAwardItem(
    BuildContext context, {
    required String title,
    required String date,
    required String description,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.emoji_events,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


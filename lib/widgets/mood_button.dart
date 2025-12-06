import 'package:flutter/material.dart';

class MoodButton extends StatelessWidget {
  final String label;
  final String mood;
  final IconData icon;

  const MoodButton({
    super.key,
    required this.label,
    required this.mood,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/createPlaylist',
          arguments: mood,
        );
      },
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text(
              label,
                style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface, // ✅ Ensures readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}

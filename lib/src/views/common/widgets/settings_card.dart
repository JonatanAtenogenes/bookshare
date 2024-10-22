import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';

class SettingsCard extends ConsumerWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Column(
      children: [
        const SubtitleText(subtitle: 'Ajustes'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Modo Oscuro'),
            Switch(
              value: isDarkMode,
              onChanged: (value) => ref.read(darkModeProvider.notifier).update(
                    (state) => !state,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

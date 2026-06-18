import 'package:flutter/material.dart';
import 'package:relva_studio/relvastudio/app_settings.dart';
import 'package:relva_studio/relvastudio/app_strings.dart';

class GlobalSettingsFAB extends StatefulWidget {
  const GlobalSettingsFAB({super.key});

  @override
  State<GlobalSettingsFAB> createState() => _GlobalSettingsFABState();
}

class _GlobalSettingsFABState extends State<GlobalSettingsFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimController;
  bool _settingsOpen = false;

  void _toggleSettings() {
    setState(() => _settingsOpen = !_settingsOpen);
    if (_settingsOpen) {
      _fabAnimController.forward();
    } else {
      _fabAnimController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsProvider.of(context);
    final strings = AppStrings(settings.language);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Settings panel (slides in above FAB)
        AnimatedSlide(
          offset: _settingsOpen ? Offset.zero : const Offset(0, 0.3),
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: _settingsOpen ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 220),
            child: _settingsOpen
                ? _buildSettingsPanel(settings, strings)
                : const SizedBox.shrink(),
          ),
        ),
        if (_settingsOpen) const SizedBox(height: 12),

        // FAB Button
        AnimatedRotation(
          turns: _settingsOpen ? 0.125 : 0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: FloatingActionButton(
            onPressed: _toggleSettings,
            backgroundColor: settings.primaryColor,
            foregroundColor: Colors.white,
            elevation: 8,
            tooltip: strings.settingsTitle,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _settingsOpen
                  ? const Icon(Icons.close_rounded, key: ValueKey('close'))
                  : const Icon(Icons.tune_rounded, key: ValueKey('tune')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsPanel(AppSettings settings, AppStrings strings) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: settings.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: settings.primaryColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: settings.primaryColor.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.tune_rounded,
                  color: settings.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                strings.settingsTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: settings.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Theme ──────────────────────────────────────────────────────────
          Text(
            strings.themeLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: settings.subTextColor,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _ThemeSelector(settings: settings, strings: strings),

          const SizedBox(height: 20),

          // ── Language ───────────────────────────────────────────────────────
          Text(
            strings.languageLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: settings.subTextColor,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _LanguageSelector(settings: settings, strings: strings),
        ],
      ),
    );
  }
}

// ─── Theme Selector Widget ────────────────────────────────────────────────────
class _ThemeSelector extends StatelessWidget {
  final AppSettings settings;
  final AppStrings strings;

  const _ThemeSelector({required this.settings, required this.strings});

  @override
  Widget build(BuildContext context) {
    final isLight = settings.theme == AppThemeMode.light;
    return GestureDetector(
      onTap: () => settings.setTheme(
        isLight ? AppThemeMode.dark : AppThemeMode.light,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: settings.surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: settings.primaryColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // Sliding indicator
            AnimatedAlign(
              alignment:
                  isLight ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                width: 118,
                height: 40,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: settings.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: settings.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Labels
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.light_mode_rounded,
                          size: 16,
                          color: isLight
                              ? Colors.white
                              : settings.subTextColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          strings.themeLight,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isLight
                                ? Colors.white
                                : settings.subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.dark_mode_rounded,
                          size: 16,
                          color: !isLight
                              ? Colors.white
                              : settings.subTextColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          strings.themeDark,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: !isLight
                                ? Colors.white
                                : settings.subTextColor,
                          ),
                        ),
                      ],
                    ),
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

// ─── Language Selector Widget ─────────────────────────────────────────────────
class _LanguageSelector extends StatelessWidget {
  final AppSettings settings;
  final AppStrings strings;

  const _LanguageSelector({required this.settings, required this.strings});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _LangChip(
            label: '🇬🇧  ${strings.langEn}',
            isSelected: settings.language == AppLanguage.en,
            onTap: () => settings.setLanguage(AppLanguage.en),
            settings: settings,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _LangChip(
            label: '🇮🇩  ${strings.langId}',
            isSelected: settings.language == AppLanguage.id,
            onTap: () => settings.setLanguage(AppLanguage.id),
            settings: settings,
          ),
        ),
      ],
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final AppSettings settings;

  const _LangChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? settings.primaryColor.withValues(alpha: 0.15)
              : settings.surfaceColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? settings.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? settings.primaryColor : settings.subTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

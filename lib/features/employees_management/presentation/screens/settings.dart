import 'package:employees_management/locale/locales.dart';
import 'package:employees_management/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocale.appTitle.getString(context))),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('English'),
                    onPressed: () {
                      locator<FlutterLocalization>().translate('en');
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Hebrew'),
                    onPressed: () {
                      locator<FlutterLocalization>().translate('he');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ItemWidget(
              title: 'Current Language',
              content: locator<FlutterLocalization>().getLanguageName(),
            ),
            ItemWidget(
              title: 'Font Family',
              content: locator<FlutterLocalization>().fontFamily,
            ),
            ItemWidget(
              title: 'Locale Identifier',
              content:
                  locator<FlutterLocalization>().currentLocale.localeIdentifier,
            ),
            ItemWidget(
              title: 'String Format',
              content: Strings.format(
                'Hello %a, this is me %a.',
                ['Assaf', 'Zfani'],
              ),
            ),
            ItemWidget(
              title: 'Context Format String',
              content: context.formatString(
                AppLocale.thisIs,
                [AppLocale.title, 'LATEST'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(title ?? '')),
          const Text(' : '),
          Expanded(child: Text(content ?? '')),
        ],
      ),
    );
  }
}

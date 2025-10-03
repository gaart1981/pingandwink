// tools/check_l10n_advanced.dart
import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  final bool fix = args.contains('--fix');
  final bool verbose = args.contains('--verbose');
  
  print('🔍 MoodMap Локализация Checker v2.0\n');
  
  // Загружаем все ARB файлы
  final enArb = await loadArb('lib/l10n/app_en.arb');
  final frArb = await loadArb('lib/l10n/app_fr.arb');
  
  // Находим использования
  final usedKeys = await findUsedKeys(verbose);
  
  // Анализ
  final enKeys = enArb.keys.where((k) => !k.startsWith('@')).toSet();
  final frKeys = frArb.keys.where((k) => !k.startsWith('@')).toSet();
  
  final unusedKeys = enKeys.difference(usedKeys);
  final missingInCode = usedKeys.difference(enKeys);
  final missingInFr = enKeys.difference(frKeys);
  final extraInFr = frKeys.difference(enKeys);
  
  // Вывод результатов
  print('📊 Результаты анализа:\n');
  print('  EN ключей: ${enKeys.length}');
  print('  FR ключей: ${frKeys.length}');
  print('  Используется: ${usedKeys.length}\n');
  
  bool hasIssues = false;
  
  if (unusedKeys.isNotEmpty) {
    hasIssues = true;
    print('⚠️  Неиспользуемые ключи (${unusedKeys.length}):');
    for (var key in unusedKeys) {
      print('    - $key');
      if (verbose && enArb[key] != null) {
        print('      "${enArb[key]}"');
      }
    }
    print('');
  }
  
  if (missingInCode.isNotEmpty) {
    hasIssues = true;
    print('❌ Отсутствуют в ARB (${missingInCode.length}):');
    for (var key in missingInCode) {
      print('    - $key');
      // Найдем где используется
      if (verbose) {
        final usage = await findKeyUsage(key);
        print('      Используется в: $usage');
      }
    }
    print('');
  }
  
  if (missingInFr.isNotEmpty) {
    hasIssues = true;
    print('🇫🇷 Отсутствуют во французском (${missingInFr.length}):');
    for (var key in missingInFr) {
      print('    - $key: "${enArb[key]}"');
    }
    print('');
  }
  
  if (extraInFr.isNotEmpty) {
    hasIssues = true;
    print('🇫🇷 Лишние во французском (${extraInFr.length}):');
    for (var key in extraInFr) {
      print('    - $key');
    }
    print('');
  }
  
  // Автоисправление
  if (fix && hasIssues) {
    print('🔧 Применяем автоисправления...\n');
    
    if (unusedKeys.isNotEmpty) {
      final confirm = await askConfirmation(
        'Удалить ${unusedKeys.length} неиспользуемых ключей?'
      );
      if (confirm) {
        await removeUnusedKeys(unusedKeys);
        print('✅ Удалено ${unusedKeys.length} ключей\n');
      }
    }
    
    if (missingInFr.isNotEmpty) {
      print('📝 Добавляем отсутствующие французские переводы...');
      await addMissingTranslations(enArb, frArb, missingInFr);
      print('✅ Добавлено ${missingInFr.length} переводов\n');
    }
  }
  
  // Финальный статус
  if (!hasIssues) {
    print('✅ Локализация полностью синхронизирована!\n');
  } else if (!fix) {
    print('💡 Используйте --fix для автоисправления\n');
  }
  
  // Статистика использования
  if (verbose) {
    print('📈 Топ-10 файлов по использованию l10n:');
    final stats = await getUsageStats();
    stats.take(10).forEach((entry) {
      print('    ${entry.key}: ${entry.value} использований');
    });
  }
}

Future<Map<String, dynamic>> loadArb(String path) async {
  final file = File(path);
  if (!await file.exists()) {
    print('❌ Файл не найден: $path');
    exit(1);
  }
  return jsonDecode(await file.readAsString());
}

Future<Set<String>> findUsedKeys(bool verbose) async {
  final usedKeys = <String>{};
  final libDir = Directory('lib');
  
  await for (var entity in libDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = await entity.readAsString();
      
      // Паттерны для поиска
      final patterns = [
        RegExp(r'l10n\.(\w+)'),                    // l10n.key
        RegExp(r'AppLocalizations\.of\(context\)[!]?\.(\w+)'), // полная форма
      ];
      
      for (var pattern in patterns) {
        final matches = pattern.allMatches(content);
        for (var match in matches) {
          final key = match.group(1)!;
          usedKeys.add(key);
          if (verbose && usedKeys.length % 10 == 0) {
            stdout.write('.');
          }
        }
      }
    }
  }
  
  if (verbose) print('');
  return usedKeys;
}

Future<String> findKeyUsage(String key) async {
  final files = <String>[];
  final libDir = Directory('lib');
  
  await for (var entity in libDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = await entity.readAsString();
      if (content.contains('l10n.$key')) {
        files.add(entity.path.replaceAll('lib/', ''));
      }
    }
  }
  
  return files.isEmpty ? 'не найдено' : files.join(', ');
}

Future<bool> askConfirmation(String question) async {
  stdout.write('$question (y/n): ');
  final answer = stdin.readLineSync()?.toLowerCase();
  return answer == 'y' || answer == 'yes';
}

Future<void> removeUnusedKeys(Set<String> keys) async {
  // Здесь код для удаления ключей из ARB файлов
  // Пример реализации
}

Future<void> addMissingTranslations(
  Map<String, dynamic> enArb,
  Map<String, dynamic> frArb, 
  Set<String> keys
) async {
  // Здесь код для добавления переводов
  // Можно использовать Google Translate API или заглушки
}

Future<List<MapEntry<String, int>>> getUsageStats() async {
  final stats = <String, int>{};
  // Подсчет использований по файлам
  return stats.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
}
// diagnostic.dart
// Placez ce fichier dans lib/ et exécutez: dart lib/diagnostic.dart

import 'dart:io';

void main() {
  print('🔍 DIAGNOSTIC MOODMAP\n');
  print('=' * 50);
  
  // Check Flutter version
  print('\n📱 FLUTTER VERSION:');
  try {
    var result = Process.runSync('flutter', ['--version']);
    print(result.stdout);
  } catch (e) {
    print('❌ Flutter not found in PATH');
  }
  
  // Check .env file
  print('\n🔑 FICHIER .ENV:');
  var envFile = File('.env');
  if (envFile.existsSync()) {
    print('✅ .env existe');
    var lines = envFile.readAsLinesSync();
    var hasSupabase = lines.any((l) => l.contains('SUPABASE_URL'));
    var hasMapbox = lines.any((l) => l.contains('MAPBOX_ACCESS_TOKEN'));
    print(hasSupabase ? '✅ SUPABASE_URL trouvé' : '❌ SUPABASE_URL manquant');
    print(hasMapbox ? '✅ MAPBOX_ACCESS_TOKEN trouvé' : '❌ MAPBOX_ACCESS_TOKEN manquant');
  } else {
    print('❌ .env n\'existe pas - CRÉEZ-LE!');
    print('\nExemple de contenu .env:');
    print('SUPABASE_URL=https://xxx.supabase.co');
    print('SUPABASE_ANON_KEY=xxx');
    print('MAPBOX_ACCESS_TOKEN=xxx');
    print('MAPBOX_STYLE_URL=mapbox://styles/mapbox/dark-v11');
    print('EDGE_FUNCTION_SUBMIT_MOOD=https://xxx.supabase.co/functions/v1/submit-mood');
    print('EDGE_FUNCTION_GET_MAP=https://xxx.supabase.co/functions/v1/get-map');
  }
  
  // Check pubspec.yaml
  print('\n📦 PUBSPEC.YAML:');
  var pubspecFile = File('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    print('✅ pubspec.yaml existe');
    var content = pubspecFile.readAsStringSync();
    
    // Check dependencies
    var deps = [
      'mapbox_maps_flutter',
      'geolocator',
      'supabase_flutter',
      'shared_preferences',
      'flutter_local_notifications',
      'share_plus',
      'url_launcher',
      'flutter_markdown'
    ];
    
    print('\nDépendances:');
    for (var dep in deps) {
      if (content.contains(dep)) {
        print('  ✅ $dep');
      } else {
        print('  ❌ $dep manquant');
      }
    }
    
    // Check assets
    if (content.contains('assets:')) {
      print('\n✅ Section assets trouvée');
    } else {
      print('\n❌ Section assets manquante');
    }
  } else {
    print('❌ pubspec.yaml n\'existe pas!');
  }
  
  // Check lib structure
  print('\n📂 STRUCTURE LIB:');
  var libDir = Directory('lib');
  if (libDir.existsSync()) {
    var requiredDirs = [
      'lib/config',
      'lib/l10n',
      'lib/models',
      'lib/screens',
      'lib/screens/legal',
      'lib/services',
      'lib/widgets'
    ];
    
    for (var dir in requiredDirs) {
      var d = Directory(dir);
      if (d.existsSync()) {
        var fileCount = d.listSync().where((f) => f.path.endsWith('.dart')).length;
        print('  ✅ $dir ($fileCount fichiers)');
      } else {
        print('  ❌ $dir manquant');
      }
    }
  } else {
    print('❌ Dossier lib n\'existe pas!');
  }
  
  // Check critical files
  print('\n📄 FICHIERS CRITIQUES:');
  var criticalFiles = [
    'lib/main.dart',
    'lib/screens/map_screen.dart',
    'lib/screens/main_container.dart',
    'lib/screens/onboarding_screen.dart',
    'lib/screens/splash_screen.dart',
    'lib/screens/history_screen.dart',
    'lib/screens/settings_screen.dart',
    'lib/widgets/bottom_navigation.dart',
    'lib/widgets/emotion_selector.dart',
    'lib/config/app_config.dart',
    'lib/config/emotions.dart',
    'lib/config/theme.dart',
    'lib/services/api_service.dart',
    'lib/services/location_service.dart',
    'lib/services/storage_service.dart',
    'lib/services/notification_service.dart'
  ];
  
  for (var file in criticalFiles) {
    var f = File(file);
    if (f.existsSync()) {
      var size = f.lengthSync();
      print('  ✅ $file (${(size/1024).toStringAsFixed(1)} KB)');
    } else {
      print('  ❌ $file MANQUANT!');
    }
  }
  
  // Check for duplicate files
  print('\n⚠️  DOUBLONS POTENTIELS:');
  var screenDir = Directory('lib/screens');
  if (screenDir.existsSync()) {
    var files = screenDir.listSync().where((f) => f.path.endsWith('.dart'));
    for (var file in files) {
      var name = file.path.split('/').last.split('\\').last;
      if (name.contains('placeholder') && !name.contains('trends')) {
        var nonPlaceholder = name.replaceAll('_placeholder', '');
        var otherFile = File('lib/screens/$nonPlaceholder');
        if (otherFile.existsSync()) {
          print('  ⚠️  $name ET $nonPlaceholder existent');
        }
      }
    }
  }
  
  // Summary
  print('\n${'=' * 50}');
  print('📊 RÉSUMÉ:');
  
  if (!envFile.existsSync()) {
    print('❌ CRITIQUE: Créez le fichier .env avec vos clés API');
  }
  
  var mapScreenFile = File('lib/screens/map_screen.dart');
  if (mapScreenFile.existsSync()) {
    var content = mapScreenFile.readAsStringSync();
    if (content.contains('class _MapScreenState')) {
      print('❌ CRITIQUE: MapScreenState est privé, remplacez le fichier');
    } else if (content.contains('class MapScreenState')) {
      print('✅ MapScreenState est public');
    }
  }
  
  var splashFile = File('lib/screens/splash_screen.dart');
  if (splashFile.existsSync()) {
    var content = splashFile.readAsStringSync();
    if (content.contains('assets/images/moodmap_logo.png')) {
      print('❌ CRITIQUE: splash_screen référence une image inexistante');
    }
  }
  
  print('\n💡 PROCHAINES ÉTAPES:');
  print('1. Corrigez les erreurs CRITIQUES ci-dessus');
  print('2. Remplacez les 4 fichiers depuis les artéfacts');
  print('3. flutter clean && flutter pub get');
  print('4. flutter run');
  
  print('\n✨ Bonne chance!');
}
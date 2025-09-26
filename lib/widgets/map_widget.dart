// lib/widgets/map_widget.dart
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:geolocator/geolocator.dart' as geo;
import '../config/app_config.dart';
import '../services/storage_service.dart';

/// Enhanced map widget with theme switching support
class MoodMapWidget extends StatefulWidget {
  final Function(mapbox.MapboxMap) onMapCreated;
  final geo.Position? currentPosition;

  const MoodMapWidget({
    super.key,
    required this.onMapCreated,
    this.currentPosition,
  });

  @override
  State<MoodMapWidget> createState() => _MoodMapWidgetState();
}

class _MoodMapWidgetState extends State<MoodMapWidget> {
  bool _isDarkTheme = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDark = await StorageService.isDarkMapTheme();
    if (mounted) {
      setState(() {
        _isDarkTheme = isDark;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00D4FF),
        ),
      );
    }

    // Выбираем стиль на основе сохраненной настройки
    final styleUri = _isDarkTheme
        ? "mapbox://styles/mapbox/dark-v11"
        : "mapbox://styles/mapbox/light-v11";

    return mapbox.MapWidget(
      key: ValueKey("mapWidget_$_isDarkTheme"),
      onMapCreated: widget.onMapCreated,
      cameraOptions: mapbox.CameraOptions(
        center: mapbox.Point(
            coordinates: mapbox.Position(
          widget.currentPosition?.longitude ?? AppConfig.defaultLongitude,
          widget.currentPosition?.latitude ?? AppConfig.defaultLatitude,
        )),
        zoom: AppConfig.defaultMapZoom,
        bearing: 0,
        pitch: 0,
      ),
      styleUri: styleUri,
    );
  }
}

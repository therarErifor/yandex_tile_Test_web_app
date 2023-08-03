abstract class YandexTileEvent{}

class ButtonPressed extends YandexTileEvent{
  final latitudeController;
  final longitudeController;
  final zoomController;
  ButtonPressed({
  required this.latitudeController,
  required this.longitudeController,
  required this.zoomController});
}

class GoHome extends YandexTileEvent{}
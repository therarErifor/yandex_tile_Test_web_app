abstract class YandexTileState {}

class InitState extends YandexTileState {
  final String warning;
  InitState(
  {required this.warning});
}

class YandexTileFound extends YandexTileState{
  final String tileImageUrl;
  final String tileCoordX;
  final String tileCoordY;

  YandexTileFound(
      {required this.tileImageUrl,
      required this.tileCoordX,
      required this.tileCoordY});
}

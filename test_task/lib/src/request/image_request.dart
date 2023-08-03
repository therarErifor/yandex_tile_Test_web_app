class ImageRequest {
  final _baseUrl = "https://core-carparks-renderer-lots.maps.yandex.net/maps-rdr-carparks/";
  late final _url;

  getImageFromUrl(int x, int y, int z)async{
    _url = await _baseUrl + "tiles?l=carparks&x=$x&y=$y&z=$z&scale=1&lang=ru_RU";
    return _url;
  }
}
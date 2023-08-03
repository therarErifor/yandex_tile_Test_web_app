import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/featuers/yandex_tile_events.dart';
import 'package:test_task/src/request/image_request.dart';
import 'YandexTileState.dart';

class YandexTileBloc extends Bloc<YandexTileEvent, YandexTileState> {
  YandexTileBloc() : super(InitState(warning: '')) {
    on<ButtonPressed>((event, emit) async {
      ImageRequest _imageRequest = ImageRequest();
      Map<String, int> tileCoords = {"x": 0, "y": 0};
      const e = 0.0818191908426;
      double _latitude = double.parse(event.latitudeController.text);
      double _longitude = double.parse(event.longitudeController.text);
      double _zoom = double.parse(event.zoomController.text);
      if((_zoom > 21)|(_zoom < 14)){
        emit (InitState(warning: 'Пожалуйста, введите корректные данные!'));
        return;
      }
      var beta = (pi * _latitude) / 180;
      double q = (1 - e * sin(beta)) / (1 + e * sin(beta));
      double p = pow(2, (_zoom + 8)) / 2;
      var o = tan((pi / 4) + (beta / 2)) * pow(q, (e / 2));
      var x = ((p * (1 + (_longitude / 180))) / 256).round();
      var y = ((p * (1 - (log(o) / pi))) / 256).round();
      tileCoords['x'] = x;
      tileCoords['y'] = y;

      var imageUrl = await _imageRequest.getImageFromUrl(x, y, _zoom.round());

      emit(YandexTileFound(
          tileImageUrl: imageUrl,
          tileCoordX: tileCoords['x'].toString(),
          tileCoordY: tileCoords['y'].toString()));
    });
    on<GoHome>((event, emit) {
      emit(InitState(warning: ''));
    });
  }
}

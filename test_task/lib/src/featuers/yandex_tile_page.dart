import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/src/featuers/yandex_tile_bloc.dart';
import 'package:test_task/src/featuers/yandex_tile_events.dart';
import 'YandexTileState.dart';

class YaMapHomePage extends StatelessWidget {
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _zoomController = TextEditingController();
  final TextEditingController ResultXController = TextEditingController();
  final TextEditingController ResultYController = TextEditingController();
  bool _textIsValidate = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<YandexTileBloc>(
      create: (_) => YandexTileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Yandex map test task'),
        ),
        body: BlocBuilder<YandexTileBloc, YandexTileState>(
          builder: _buildBody,
        ),
      ),
    );
  }

  @override
  Widget _buildBody(BuildContext context, YandexTileState state) {
    if (state is InitState) {
      return Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Введите широту, долготу и зум',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 30),
            Text(state.warning),
            SizedBox(height: 15),
            TextField(
              maxLength: 9,
              keyboardType: TextInputType.number,
              controller: _latitudeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Широта. Пример: 55.790924'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextField(
              maxLength: 9,
              keyboardType: TextInputType.number,
              controller: _longitudeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Долгота. Пример: 37.613772'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextField(
              maxLength: 2,
              keyboardType: TextInputType.number,
              controller: _zoomController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Зум. Пример: 19'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  final vLat = double.tryParse(_latitudeController.text);
                  final vLon = double.tryParse(_longitudeController.text);
                  final vZoom = double.tryParse(_zoomController.text);
                  if ((vLat == null)||(vLon == null)||(vZoom == null)) {
                    _textIsValidate = false;
                  } else {
                  context.read<YandexTileBloc>().add(
                      ButtonPressed(
                          latitudeController: _latitudeController,
                          longitudeController: _longitudeController,
                          zoomController: _zoomController));
                  }
                },
                child: Text('Ввод')),
          ],
        ),
      );
    }
    if (state is YandexTileFound) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Широта: ' + state.tileCoordX,
              ),
              SizedBox(height: 15),
              Text('Долгота: ' + state.tileCoordY),
              SizedBox(height: 15),
              Container(
                height: 260,
                width: 260,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular((10)),
                ),
                child: Image.network(
                  state.tileImageUrl,
                  width: 300,
                  height: 300,
                  errorBuilder:(BuildContext context, Object exception, _) =>
                      Image.asset('assets/images/connection_error.png'),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () => context.read<YandexTileBloc>().add(GoHome()),
                  child: Text('Вернуться обратно'))
            ]),
      );
    }
    return const SizedBox.shrink();
  }
}

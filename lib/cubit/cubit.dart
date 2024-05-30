import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_youtube/cubit/cubit_states.dart';
import 'package:weather_app_youtube/data/my_data.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  Future<void> fetchWeather(Position position) async {
    emit(WeatherLoadingState());
    try {
      WeatherFactory wf = WeatherFactory(apiKEY, language: Language.ENGLISH);

      Weather weather = await wf.currentWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      print(weather);
      emit(WeatherLoadedState(weather));
    } catch (e) {
      emit(WeatherErrorState());
    }
  }
}

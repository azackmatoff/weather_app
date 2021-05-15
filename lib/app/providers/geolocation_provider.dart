import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/widgets/custom_dialog.dart';

class GeolocationProvider {
  Future<Position> getUserLocaiton() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      CustomDialog().getDialog(
        title: 'Error!',
        content: 'Please enable location on your phone',
        isError: true,
      );
      return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        CustomDialog().getDialog(
          title: 'Error!',
          content: 'Access to your phone\'s location is needed',
          isError: true,
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      CustomDialog().getDialog(
        title: 'Error!',
        content: 'Access to your phone\'s location is needed',
        isError: true,
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

final GeolocationProvider geolocationProvider = GeolocationProvider();

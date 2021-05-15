import 'package:weather_app/app/enums/enums.dart';

/// converts values of type int to double
/// intended to use while parsing json values where type will be dynamic
/// returns value of type double
intToDouble(dynamic val) {
  if (val.runtimeType == double) {
    return val;
  } else if (val.runtimeType == int) {
    return val.toDouble();
  } else {
    throw Exception("value is not of type 'int' or 'double' got type '" +
        val.runtimeType.toString() +
        "'");
  }
}

temperatureToDouble(Temperature val) {
  return val.kelvin;
}

class Temperature {
  final double _kelvin;

  Temperature(this._kelvin) : assert(_kelvin != null);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

  double as(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return kelvin;
        break;
      case TemperatureUnit.celsius:
        return celsius;
        break;
      case TemperatureUnit.fahrenheit:
        return fahrenheit;
        break;
    }
    return fahrenheit;
  }
}

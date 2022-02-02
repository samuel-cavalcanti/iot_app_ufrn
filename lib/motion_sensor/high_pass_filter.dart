class HighPassFilter {
  final alpha = 0.85;
  final List<double> _gravity = [0.0, 0.0, 0.0];

  List<double> filter(List<double> sensorInput) {
    List<double> output = [0.0, 0.0, 0.0];
    for (int i = 0; i < 3; i++) {
      _gravity[i] = alpha * _gravity[i] + (1 - alpha) * sensorInput[i];

      output[i] = sensorInput[i] - _gravity[i];
    }

    return output;
  }
}

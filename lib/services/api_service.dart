class ApiService {
  const ApiService();

  Future<void> simulateLatency([Duration duration = const Duration(milliseconds: 900)]) async {
    await Future.delayed(duration);
  }
}

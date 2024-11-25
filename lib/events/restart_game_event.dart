class RestartGameEvent {

  static List<Function> events = List.empty(growable: true);

  static void subscribe(Function f) {
    events.add(f);
  }

  static void unsubscribe(Function f) {
    events.remove(f);
  }

  static void invoke() {
    for (var value in events) {
      value.call();
    }
  }
}
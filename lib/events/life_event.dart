/// Class representing an static known event bus to subscribe and invoke to.
///
/// This eventbus is used to update the health between the player and the UI.
class LifeEvent {

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
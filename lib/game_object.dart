import 'package:flame/components.dart';

class GameObject extends PositionComponent {

  T append<T extends Component>(T component) {
    super.add(component);
    return component;
  }
}
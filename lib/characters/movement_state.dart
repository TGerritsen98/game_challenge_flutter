/// Enum for the different movement states of a character.
enum MovementState {

  /// The character standing still, facing north.
  idleTop,

  /// The character standing still, facing east.
  idleRight,

  /// The character standing still, facing south.
  idleBottom,

  /// The character standing still, facing west.
  idleLeft,

  /// The character moving north.
  walkingTop,

  /// The character moving east.
  walkingRight,

  /// The character moving south.
  walkingBottom,

  /// The character moving west.
  walkingLeft
}
enum LedColor { white, red, blue, green, yellow }

enum LedStatus { on, off, posting }

class Led {
  final LedColor color;
  final LedStatus status;
  final int id;

  Led({required this.id, required this.color, required this.status});

  @override
  bool operator ==(Object other) =>
      other is Led &&
      other.id == id &&
      other.runtimeType == runtimeType &&
      other.color == color &&
      other.status == status;

  @override
  int get hashCode {
    return id;
  }

  @override
  String toString() {
    return 'LED #$id $color $status';
  }
}

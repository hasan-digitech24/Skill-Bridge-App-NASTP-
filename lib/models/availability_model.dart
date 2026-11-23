class AvailabilityModel {
  // Hours shown in the weekly grid (24h format).
  static const List<int> hours = [9, 10, 11, 12, 14, 15, 16, 17];

  bool isOn;

  // weekday (1 = Monday ... 7 = Sunday) -> hours that are available
  Map<int, Set<int>> slots;

  AvailabilityModel({this.isOn = true, Map<int, Set<int>>? slots})
      : slots = slots ?? {};

  bool isSlotOn(int weekday, int hour) {
    return slots[weekday]?.contains(hour) ?? false;
  }

  void toggleSlot(int weekday, int hour) {
    final daySlots = slots.putIfAbsent(weekday, () => <int>{});
    if (!daySlots.add(hour)) {
      daySlots.remove(hour);
    }
  }

  AvailabilityModel copy() {
    return AvailabilityModel(
      isOn: isOn,
      slots: {
        for (final entry in slots.entries) entry.key: Set<int>.from(entry.value),
      },
    );
  }
}

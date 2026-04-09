class Country {
  final String name;
  final String countryCode; // e.g., "ID"
  final String dialCode; // e.g., "+1"
  final String flag; // Emoji flag

  Country({
    required this.name,
    required this.countryCode,
    required this.dialCode,
    required this.flag,
  });

  @override
  String toString() => '$flag $dialCode';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode;

  @override
  int get hashCode => countryCode.hashCode;
}

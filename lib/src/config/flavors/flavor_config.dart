enum Flavor { development, staging, production }

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;
  final String name;

  static FlavorConfig? _instance;

  FlavorConfig._internal({
    required this.flavor,
    required this.baseUrl,
    required this.name,
  });

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
    required String name,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor: flavor,
      baseUrl: baseUrl,
      name: name,
    );

    return _instance!;
  }

  static FlavorConfig get instance {

    if (_instance == null) {
      throw Exception("FlavorConfig not initialized");
    } else {
      return _instance!;
    }
  }

  static bool isStage() => _instance!.flavor == Flavor.staging;

  static bool isProduction() => _instance!.flavor == Flavor.production;

  static bool isDevelopment() => _instance!.flavor == Flavor.development;
}

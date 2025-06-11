import 'main_common.dart';
import 'main_export.dart';

void main() {
  mainCommon(
    flavor: Flavor.production,
    baseUrl: "https://prod.com/v1",
    name: "Production",
  );
}
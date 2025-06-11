import 'main_common.dart';
import 'main_export.dart';

void main() {
  mainCommon(
    flavor: Flavor.production,
    baseUrl: "https://stag.com/v1",
    name: "Staging",
  );
}
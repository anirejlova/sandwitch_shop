import 'package:flutter_test/flutter_test.dart';
import 'package:sandwitch_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name returns expected human-readable names', () {
      expect(
        Sandwich(
                type: SandwichType.veggieDelight,
                isFootlong: false,
                breadType: BreadType.wheat)
            .name,
        'Veggie Delight',
      );

      expect(
        Sandwich(
                type: SandwichType.chickenTeriyaki,
                isFootlong: false,
                breadType: BreadType.wheat)
            .name,
        'Chicken Teriyaki',
      );

      expect(
        Sandwich(
                type: SandwichType.tunaMelt,
                isFootlong: false,
                breadType: BreadType.wheat)
            .name,
        'Tuna Melt',
      );

      expect(
        Sandwich(
                type: SandwichType.meatballMarinara,
                isFootlong: false,
                breadType: BreadType.wheat)
            .name,
        'Meatball Marinara',
      );
    });

    test('image returns correct path for footlong', () {
      final s = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.white,
      );

      expect(s.image, 'assets/images/chickenTeriyaki_footlong.png');
    });

    test('image returns correct path for six inch', () {
      final s = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );

      expect(s.image, 'assets/images/tunaMelt_six_inch.png');
    });

    test('properties are preserved', () {
      final s = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );

      expect(s.type, SandwichType.meatballMarinara);
      expect(s.isFootlong, isTrue);
      expect(s.breadType, BreadType.wholemeal);
    });
  });
}

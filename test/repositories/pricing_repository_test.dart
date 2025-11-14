import 'package:flutter_test/flutter_test.dart';
import 'package:sandwitch_shop/repositories/pricing_repository.dart';

void main() {
  late PricingRepository repo;

  setUp(() {
    repo = PricingRepository();
  });

  group('PricingRepository', () {
    test('uses six-inch price for non-footlong items', () {
      expect(repo.totalPrice(1, false), equals(PricingRepository.sixInchPrice));
      expect(repo.totalPrice(3, false),
          equals(PricingRepository.sixInchPrice * 3));
    });

    test('uses footlong price for footlong items', () {
      expect(repo.totalPrice(1, true), equals(PricingRepository.footlongPrice));
      expect(repo.totalPrice(4, true),
          equals(PricingRepository.footlongPrice * 4));
    });

    test('returns 0.0 for quantity zero', () {
      expect(repo.totalPrice(0, false), equals(0.0));
      expect(repo.totalPrice(0, true), equals(0.0));
    });

    test('negative quantities multiply accordingly (current behavior)', () {
      expect(repo.totalPrice(-2, false),
          equals(-2 * PricingRepository.sixInchPrice));
      expect(repo.totalPrice(-3, true),
          equals(-3 * PricingRepository.footlongPrice));
    });
  });
}

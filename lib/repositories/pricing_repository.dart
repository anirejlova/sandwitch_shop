class PricingRepository {
  static const double sixInchPrice = 7.0;
  static const double footlongPrice = 11.0;

  PricingRepository();

  double totalPrice(int quantity, bool isFootlong) {
    double unitPrice = isFootlong ? footlongPrice : sixInchPrice;
    return unitPrice * quantity;
  }
}

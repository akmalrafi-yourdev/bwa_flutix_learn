part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo({this.title, this.subtitle, this.discount});

  @override
  // TODO: implement props
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromos = [
  Promo(
    title: "First-time Discount",
    subtitle: "Special for new user!",
    discount: 50,
  ),
  Promo(
    title: "Couple Discount",
    subtitle: "Watch movie together with you!",
    discount: 30,
  ),
  Promo(
    title: "Happy Family Discount",
    subtitle: "Enjoy movie with your lovely family!",
    discount: 45,
  ),
];

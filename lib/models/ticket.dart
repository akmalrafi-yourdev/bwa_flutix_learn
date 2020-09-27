part of 'models.dart';

class Ticket extends Equatable {
  final MovieDetail movieDetail;
  final Theater theater;
  final DateTime dateTime;
  final String bookingCode;
  final List<String> seats;
  final String name;
  final int totalPrice;

  Ticket(this.movieDetail, this.theater, this.dateTime, this.bookingCode,
      this.seats, this.name, this.totalPrice);

  Ticket copyWith(
          {MovieDetail movieDetail,
          Theater theater,
          DateTime dateTime,
          String bookingCode,
          List<String> seats,
          String name,
          int totalPrice}) =>
      Ticket(
          movieDetail ?? this.movieDetail,
          theater ?? this.theater,
          dateTime ?? this.dateTime,
          bookingCode ?? this.bookingCode,
          seats ?? this.seats,
          name ?? this.name,
          totalPrice ?? this.totalPrice);

  String get seatInString {
    String s = '';

    for (var seat in seats) {
      s += seat + ((seat != seats.last) ? ', ' : '');
    }

    return s;
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [movieDetail, theater, dateTime, bookingCode, seats, name, totalPrice];
}

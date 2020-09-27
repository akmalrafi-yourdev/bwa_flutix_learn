import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketState([]));

  // TicketBloc() : super(TicketState([]));;

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is BuyTickets) {
      await TicketServices.saveTicket(event.userID, event.ticket);

      // memasukkan ticket yang sekarang dengan tiket yang baru
      List<Ticket> tickets = state.tickets + [event.ticket];

      yield TicketState(tickets);
    } else if (event is GetTickets) {
      List<Ticket> tickets = await TicketServices.getTickets(event.userID);

      yield TicketState(tickets);
    }
  }
}

part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsStateLoaded extends ContactUsState {
  final bool isStateLoaded;
  ContactUsStateLoaded(this.isStateLoaded);
}
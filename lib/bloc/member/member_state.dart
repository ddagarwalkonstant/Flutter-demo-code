part of 'member_cubit.dart';

@immutable
abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberStateLoaded extends MemberState {
  final List<MemberListDataModel> memberList;
  MemberStateLoaded(this.memberList);
}

class AssignedMemberStateLoaded extends MemberState {
  final List<MemberListDataModel> memberList;
  AssignedMemberStateLoaded(this.memberList);
}


/// Add  member date select
class AddEditDateSelected extends MemberState {
  String selectedDate;
  String isoFormatSelectedDate;
  AddEditDateSelected(this.selectedDate, this.isoFormatSelectedDate);
}

class DeleteMemberStateLoaded extends MemberState {
  DeleteMemberStateLoaded();
}

/// Add  member gender select
class AddEditGenderSelected extends MemberState {
  String selectedGender;
  AddEditGenderSelected(this.selectedGender);
}


/// Add  member select image
class AddEditImageSelected extends MemberState {
  String? userImage;
  bool? isImageUpload;
  String? serverImage;
  AddEditImageSelected(this.userImage, this.isImageUpload, this.serverImage);
}

class AddMemberSuccessState extends MemberState {
  final bool success;
  final MemberListDataModel model;
  AddMemberSuccessState(this.success, this.model);
}



class TaskRequestStateLoaded extends MemberState {
  final bool isSuccess;
  TaskRequestStateLoaded(this.isSuccess);
}
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());


  addContactUsCubit(String? fullName, String? email, String? mobileNumber, String? note) async {

    if (fullName == null || fullName.trim() == '') {
      AppCommonFeatures.instance.showToast(AppStrings.name_empty);
      return;
    }else if (AppCommonFeatures.instance.nameRegExp.hasMatch(fullName)) {
      AppCommonFeatures.instance.showToast(AppStrings.name_valid);
      return;
    }else if (email!.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.email_empty);
      return;
    }else if (!AppCommonFeatures.instance.emailregExp.hasMatch(email)) {
      AppCommonFeatures.instance.showToast(AppStrings.email_valid);
      return;
    } else if (note == null || note == '') {
      AppCommonFeatures.instance.showToast(AppStrings.notes_empty);
      return;
    }

    final Map<String, dynamic> map = {
      'name': fullName ?? '',
      'email': email ?? '',
      'contact': mobileNumber ?? '',
      'note': note ?? ''
    };

    AppCommonFeatures.instance.showCircularProgressDialog();

    await AppCommonFeatures.instance.apiRepository
        .contactUsApiCall(map)
        .then((value) async {
      if (value!.success!) {
        AppCommonFeatures.instance.dismissCircularProgressDialog();
        AppCommonFeatures.instance.showToast(value.message ?? "");
        emit(ContactUsStateLoaded(true));
      }
    });
  }
}

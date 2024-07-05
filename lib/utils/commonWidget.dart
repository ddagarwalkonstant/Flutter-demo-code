import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:base_arch_proj/services/navigator_service.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


typedef void ToggleCallback(bool isObscure);



class CommonWidget {
  static final CommonWidget _commonWidget = CommonWidget._internal();
  // late CaseloadListCubit caseloadListCubit;
  late String caseLoadId = "";

  int itemIndex = -1;
  bool isCaseStarted = false;

  factory CommonWidget() {
    return _commonWidget;
  }

  CommonWidget._internal();

   getAppBar(BuildContext context,String title,{String? addText, VoidCallback? voidCallback}) {
    return AppBar(
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child:  Text(title,
            style: const TextStyle(
                fontFamily: FontFamily.archivo,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white)),
      ),
      backgroundColor: AppColor.theme_primary_blue,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      actions: addText=="+Add" ? [
        Padding(padding: const EdgeInsets.only(right: AppSizer.twenteey),child: GestureDetector(
          child: Text(addText ?? "",style: const TextStyle(color: Colors.white,fontSize: AppSizer.sixteen)),
          onTap: (){
            voidCallback!.call();
          },
        )),
      ] :[],
      leading: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget title(String title) {
    return Text(title,
        style: const TextStyle(
            color: AppColor.text_grey_,
            fontSize: AppSizer.sixteen,
            fontFamily: FontFamily.archivo,
            fontWeight: FontWeight.w400)
    );
  }

  Widget titleMultiColor(String firstTitle, String secondTitle) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: firstTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizer.thirty,
                    fontFamily: FontFamily.archivo,
                    color: AppColor.body_text_color)),
            TextSpan(
              text: secondTitle,
              style:  const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: AppSizer.thirty,
                  fontFamily: FontFamily.archivo,
                  color: AppColor.theme_light_blue),
            ),
          ],
        ),
      ),
    );
  }


  Widget titleOfTextField(String title) {
    return Text(title,
        style: const TextStyle(
            color: AppColor.text_grey_, fontSize: AppSizer.fourteen), textAlign: TextAlign.left,);
  }

  Widget simpleText_body_text_color(String title, {TextAlign? txtAlign}) {
    return Text(title,
      style: const TextStyle(color: AppColor.text_grey_, fontFamily: FontFamily.archivo, fontSize: AppSizer.fourteen), textAlign: txtAlign ?? TextAlign.center);
  }

  Widget textfield(String hintText, TextEditingController controller, bool isObscureText, {TextInputType keyboardType = TextInputType.text,bool isEnable=true, String leftIcon = ''}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText,
      cursorColor: Colors.black,
      enabled: isEnable,
      onTapOutside: (PointerDownEvent event) {
        NavigationService.removeKeyboard();
      },
      decoration: InputDecoration(
        filled: true,
        prefixIcon: (leftIcon != '') ? Image.asset(leftIcon, height: AppSizer.twenteeyFour, width: AppSizer.twenteeyFour) : null,
        prefixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.twenteeyFour, minWidth: AppSizer.fifty
        ),
        fillColor: AppColor.textFieldBackground,
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.grey1),
            borderRadius: BorderRadius.circular(AppSizer.twenteeyFour)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.grey1),
            borderRadius: BorderRadius.circular(AppSizer.twenteeyFour)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.theme_primary_blue),
            borderRadius: BorderRadius.circular(AppSizer.twenteeyFour)),
        contentPadding: const EdgeInsets.all(AppSizer.fifteen),
        hintStyle: const TextStyle(color: AppColor.text_grey_,fontWeight: FontWeight.w400, fontSize: AppSizer.fifteen),
        hintText: hintText,
      ),
    );
  }

  Widget passwordTextFieldWithToggle({
    required String hintText,
    required TextEditingController controller,
    bool isObscureText = true,
    TextInputType keyboardType = TextInputType.text,
    required ToggleCallback onToggle, String leftIcon = ''
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Image.asset(leftIcon, height: AppSizer.twenteeyFour, width: AppSizer.twenteeyFour),
        prefixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.twenteeyFour, minWidth: AppSizer.fifty
        ),
        fillColor: AppColor.textFieldBackground,
        hintText: hintText,
        suffixIconConstraints: const BoxConstraints(
            minHeight: AppSizer.thirty, minWidth: AppSizer.fifty),
        hintStyle:
        const TextStyle(color: AppColor.text_grey_, fontSize: AppSizer.fourteen),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.grey1),
            borderRadius: BorderRadius.circular(AppSizer.twenteeyFour)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.theme_primary_blue),
            borderRadius: BorderRadius.circular(AppSizer.twenteeyFour)),
        contentPadding: const EdgeInsets.all(AppSizer.fifteen),
        suffixIcon: GestureDetector(
          onTap: () {
            // Toggle the obscure text mode
            isObscureText = !isObscureText;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
            // Call the callback function
            onToggle(isObscureText);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image(
              image: isObscureText
                  ? AssetImage(AppCommonFeatures.instance.imagesFactory.eyesClose)
                  : AssetImage(AppCommonFeatures.instance.imagesFactory.eye_open),
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget button(String buttonName, VoidCallback callback) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.theme_primary_blue,
          foregroundColor: AppColor.theme_dark_blue,
          shadowColor: AppColor.theme_primary_blue,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizer.ten)),
        ),
        onPressed: () {
          callback.call();
        },
        child: Text(buttonName,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: AppSizer.fourteen)),
      ),
    );
  }

  Widget wrapButton(String buttonName, VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.theme_primary_blue,
        foregroundColor: AppColor.theme_dark_blue,
        shadowColor: AppColor.theme_primary_blue,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizer.twenteey)),
      ),
      onPressed: () {
        callback.call();
      },
      child: Text(buttonName,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: AppSizer.fourteen)),
    );
  }

  selectDate(BuildContext context, bool isSimpleDate,
      {DateTime? dateTime}) async {
    var finalDate = '';
    var isoFormateSelectedDate = '';
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: dateTime ?? DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.theme_primary_blue,
              onPrimary: AppColor.body_text_color,
              onSurface: AppColor.theme_primary_blue,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.body_text_color, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) {
      finalDate = '';
    } else {
      finalDate = DateFormat('yyyy-MM-dd').format(picked);

      isoFormateSelectedDate =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(picked);
    }
    if (isSimpleDate) {
      return finalDate;
    } else {
      return isoFormateSelectedDate;
    }
  }

  getFormateDate(String date) {
    String formateDate =
    DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(DateTime.parse(date));
    String simpleeDate =
    DateFormat('dd-MM-yyyy').format(DateTime.parse(formateDate));
    return simpleeDate;
  }

  Widget blankData(String title,String subtitle,String image,String buttonName,VoidCallback? callback){
    return Container(
       height: 400,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizer.ten),
        color: AppColor.textFieldBackground,
      ),
      margin: const EdgeInsets.only(left: AppSizer.fourty,right: AppSizer.fourty,top: AppSizer.sixty,bottom: AppSizer.sixty),
      padding: const EdgeInsets.all(AppSizer.twenteey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: AppSizer.fifty,
            child: Image.asset(image,height: AppSizer.fifty,width: AppSizer.fifty),
          ),
          const SizedBox(height: AppSizer.twenteey,),
          Text(title,style: const TextStyle(fontSize: AppSizer.sixteen,fontWeight: FontWeight.bold,color: Colors.black)),
          const SizedBox(height: AppSizer.ten,),
          Text(subtitle,style: const TextStyle(fontSize: AppSizer.tweleve,color: AppColor.text_grey_),textAlign: TextAlign.center),
          const SizedBox(height: AppSizer.twenteey,),
          if(callback != null)
            wrapButton(buttonName, callback)
        ],
      ),
    );
  }

}
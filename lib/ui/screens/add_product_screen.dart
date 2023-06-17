import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:vconekt_demo_app/blocs/firestore_bloc.dart';
import 'package:vconekt_demo_app/constants/strings.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/events/firestore_event.dart';
import 'package:vconekt_demo_app/states/firestore_state.dart';
import 'package:vconekt_demo_app/ui/widgets/app_bar.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/image_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/text_field_widget.dart';
import 'package:vconekt_demo_app/constants/style.dart';

import '../../blocs/login_bloc.dart';
import '../../blocs/create_account_bloc.dart';
import '../../constants/colors.dart';
import '../../routes.dart';
import '../../states/auth_states.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  String _title="";

  String _price="";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,title: "Create Product"),
      body: BlocListener<FireStoreBloc, FireStoreState>(
        listener: (context, state) {
          if (state is CreateProductLoadingState) {
            EasyLoading.show(status: "Loading...");
          }
          else if (state is CreateProductErrorState) {
            EasyLoading.showError(state.errorModel.message!);
          }
          else if (state is CreateProductSuccessState) {
            EasyLoading.showSuccess(state.successModel.message!);
            Navigator.pop(context);
          }

        },
        child: Padding(
        padding: const EdgeInsets.all(16),
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpace20,
              Text("Here you can add a new product",style: kDarkBoldLargeStyle.copyWith(color: Colors.black54),),
              kVerticalSpace16,
              TextFieldWidget(
                text: _title,
                labelText: "Title",
                onSaved: (val) {
                  _title = val!;
                },
                onChanged: (val) {
                  _title = val;
                },
                validator: (val) {
                  if (val=="" || val==null) {
                    return kRequired;
                  }else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
              ),
              kVerticalSpace16,
              TextFieldWidget(
                text: _price,
                labelText: "Price",
                onSaved: (val) {
                  _price = val!;
                },
                onChanged: (val) {
                  _price = val;
                },
                validator: (val) {
                  if (val=="" || val==null) {
                    return kRequired;
                  }else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
              ),
              kVerticalSpace24,
              ButtonWidget(text: "Create", onPressed:_create),

            ],
          ),
        ),
    ),
    ),),);
  }

  _create() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();


      BlocProvider.of<FireStoreBloc>(context).add(CreateProduct(name: _title,price: _price));
    }
  }
}

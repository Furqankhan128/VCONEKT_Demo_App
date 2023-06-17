import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:vconekt_demo_app/blocs/firestore_bloc.dart';
import 'package:vconekt_demo_app/constants/strings.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/events/firestore_event.dart';
import 'package:vconekt_demo_app/models/product_model.dart';
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

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);


  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  String _title="";

  late FireStoreProduct _product;

  String _price="";

  final _formKey = GlobalKey<FormState>();

  bool _init=true;

  @override
  void didChangeDependencies() {
    if(_init){
      _init=false;
      _product = ModalRoute.of(context)!.settings.arguments as FireStoreProduct;
      _title = _product.title;
      _price = _product.price;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context,title: "Update Product"),
      body: BlocListener<FireStoreBloc, FireStoreState>(
        listener: (context, state) {
          if (state is UpdateProductLoadingState) {
            EasyLoading.show(status: "Loading...");
          }
          else if (state is UpdateProductErrorState) {
            EasyLoading.showError(state.errorModel.message!);
          }
          else if (state is UpdateProductSuccessState) {
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
              ButtonWidget(text: "Update", onPressed:_update),

            ],
          ),
        ),
    ),
    ),),);
  }

  _update() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();


      BlocProvider.of<FireStoreBloc>(context).add(UpdateProduct(name: _title,price: _price,productId: _product.productId));
    }
  }
}

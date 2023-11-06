import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../_shared/constants/app_styles.dart';
import '../../../_shared/presentation/extensions/size_extension.dart';
import '../../data/models/payment_type_model.dart';

class PaymentTypeModalWidget extends StatefulWidget {
  final PaymentTypeModel? paymentType;
  final Function(PaymentTypeModel, bool) onPressSave;

  const PaymentTypeModalWidget({
    Key? key,
    this.paymentType,
    required this.onPressSave,
  }) : super(key: key);

  @override
  State<PaymentTypeModalWidget> createState() => _PaymentTypeModalWidgetState();
}

class _PaymentTypeModalWidgetState extends State<PaymentTypeModalWidget> {
  void closeModal() => Navigator.of(context).pop();

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enable = true;

  @override
  void initState() {
    super.initState();

    if(widget.paymentType != null){
      enable = widget.paymentType!.enable;
      nameEC.text = widget.paymentType!.name;
      acronymEC.text = widget.paymentType!.acronym;
    }
  }

  @override
  void dispose() {
    super.dispose();

    nameEC.dispose();
    acronymEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        width: screenWidth * (screenWidth > 1000 ? .5 : .7),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.paymentType == null ? 'Add' : 'Edit'} payment type',
                        textAlign: TextAlign.center,
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: closeModal,
                        child: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
                //
                //
                const SizedBox(height: 40),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Name is mandatory'),
                  decoration: InputDecoration(
                    label: Text('Name'),
                  ),
                ),
                //
                //
                const SizedBox(height: 20),
                TextFormField(
                  controller: acronymEC,
                  validator: Validatorless.required('Acronym is mandatory'),
                  decoration: InputDecoration(
                    label: Text('Acronym'),
                  ),
                ),
                //
                //
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Active: ',
                      style: context.textStyles.regular,
                    ),
                    Switch(value: enable, onChanged: (value) {
                      setState(() {
                        enable = value;
                      });
                    }),
                  ],
                ),
                //
                //
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 60,
                      child: OutlinedButton(
                          onPressed: closeModal,
                          child: Text(
                            'Cancel',
                            style: context.textStyles.extraBold.copyWith(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red))),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.save),
                        onPressed: () {
                          final isValid = formKey.currentState?.validate() ?? false;
                          final isUpdate = widget.paymentType != null;
                          if (isValid) {
                            var paymentTypeSave;
                            if (widget.paymentType == null) {
                              paymentTypeSave = PaymentTypeModel(
                                id: null,
                                name: nameEC.text.trim(),
                                acronym: acronymEC.text.trim(),
                                enable: enable,
                              );
                            } else {
                              paymentTypeSave = widget.paymentType?.copyWith(
                                name: nameEC.text.trim(),
                                acronym: acronymEC.text.trim(),
                                enable: enable,
                              );
                            }

                            widget.onPressSave(paymentTypeSave, isUpdate);
                          }
                        },
                        label: Text('Save'),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

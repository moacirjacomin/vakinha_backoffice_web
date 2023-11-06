import 'package:flutter/material.dart';

import '../../../_shared/presentation/widgets/base_header_widget.dart';

class PaymentTypeHeaderWidget extends StatefulWidget {
  final VoidCallback? buttonPressed;
  final Function(bool?) onFilterChange;
  const PaymentTypeHeaderWidget({
    Key? key,
    this.buttonPressed,
    required this.onFilterChange,
  }) : super(key: key);

  @override
  State<PaymentTypeHeaderWidget> createState() => _PaymentTypeHeaderWidgetState();
}

class _PaymentTypeHeaderWidgetState extends State<PaymentTypeHeaderWidget> {
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      // padding: EdgeInsets.only(top: 40),
      child: BaseHeaderWidget(
        title: 'Payment Types Manager',
        buttonLabel: 'Add',
        addButton: true,
        buttonPressed: widget.buttonPressed,
        filterWidget: DropdownButton<bool?>(
          value: enabled,
          items: [
            DropdownMenuItem(child: Text('All'), value: null),
            DropdownMenuItem(child: Text('Active'), value: true),
            DropdownMenuItem(child: Text('Inactive'), value: false),
          ],
          onChanged: (value) {
            if(enabled == value) return;

            setState(() {
              enabled = value;
              print(value);
              widget.onFilterChange(value);
            });
          },
        ),
      ),
    );
  }
}

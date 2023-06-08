import 'package:atom_admin/common/t_fill_button.dart';
import 'package:atom_admin/common/t_label_field.dart';
import 'package:atom_admin/common/t_simply_text_field.dart';
import 'package:flutter/material.dart';

class TDialog extends StatefulWidget {
  const TDialog({super.key});

  @override
  State<TDialog> createState() => _TDialogState();
}

class _TDialogState extends State<TDialog> {
  late String domain;

  @override
  void initState() {
    super.initState();
    domain = '';
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      children: [
        const TLabelField(title: 'Domain Name'),
        TSimplyTextField(
          initText: null,
          onChanged: (newDomain) {
            setState(() {
              domain = newDomain;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Value must not be null';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TFillButton(
            onPressed: () => Navigator.of(context).pop(domain),
            title: 'Create)')
      ],
    );
  }
}

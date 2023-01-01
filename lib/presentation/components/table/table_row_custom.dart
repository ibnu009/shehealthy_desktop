import 'package:flutter/material.dart';
import 'package:she_healthy_desktop/utils/string_ext.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../../utils/tooltip_message.dart';
import '../generic/custom_arrow.dart';
import '../generic/custom_arrow_tooltip.dart';

class TableRowCustom extends StatelessWidget {
  final String? property, val1, val2, val3, val4, tooltipMessage;

  const TableRowCustom(
      {Key? key, this.property, this.val1, this.val2, this.val3, this.val4, this.tooltipMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Tooltip(
     message: val1 == null ? '' :tooltipMessage,
     preferBelow: true,
     verticalOffset: 20,
     padding: const EdgeInsets.all(20),
     margin: const EdgeInsets.all(20),
     decoration: ShapeDecoration(
       color: AppTheme.primaryColor.withOpacity(0.9),
       shape: ToolTipCustomShape(),
     ),
     textStyle: AppTheme.smallTitle.copyWith(
       color: Colors.white
     ),
     child: LayoutBuilder(
        builder: (context, constraint) {
          double widthCell = constraint.maxWidth * 0.2;
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: widthCell,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(property ?? '-',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                  width: widthCell,
                  child:
                  Text(val1.removeChars() ?? '-', textAlign: TextAlign.center)),
              SizedBox(
                  width: widthCell,
                  child:
                  Text(val2.removeChars() ?? '-', textAlign: TextAlign.center)),
              SizedBox(
                  width: widthCell,
                  child:
                  Text(val3.removeChars() ?? '-', textAlign: TextAlign.center)),
              SizedBox(
                  width: widthCell,
                  child:
                  Text(val4.removeChars() ?? '-', textAlign: TextAlign.center)),
            ],
          );
        },
      ),
   );
  }
}

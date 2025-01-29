import 'package:flutter/material.dart';
import 'package:wartel_receiver/configs/theme_config.dart';

class InputOtp extends StatefulWidget {
  final int numberOfFields;
  final Color? borderColor;
  final TextEditingController? controller;
  final int reset;

  const InputOtp({ 
    super.key,
    this.numberOfFields=6,
    this.borderColor,
    this.controller,
    this.reset=0,
  });

  @override
  State<InputOtp> createState() => _InputOtpState();
}

class _InputOtpState extends State<InputOtp> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focuses = [];

  @override
  initState() {
    for (var i = 0; i < widget.numberOfFields; i++) {
      controllers.add(TextEditingController());
      focuses.add(FocusNode());
    }

    if(widget.controller != null) {
      widget.controller!.addListener(() {
        if(widget.controller!.text.isEmpty) {
          for (var c in controllers) {
            c.text = '';
          }
          focuses[0].requestFocus();
        }
      });
    }
    super.initState();
  }

  fields() {
    List<Widget> res = [];

    for (var i = 0; i < widget.numberOfFields; i++) {
      res.add(Flexible(
        child: Container(
          margin: i != widget.numberOfFields-1 
            ? const EdgeInsets.only(right: 10) 
            : EdgeInsets.zero,
          child: TextFormField(
            controller: controllers[i],
            focusNode: focuses[i],
            autofocus: i == 0,
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              isDense: true,
              counterText: '',
              filled: false,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 10
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                  width: 2,
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? ThemeConfig.primaryColor,
                  width: 2,
                )
              )
            ),
            onChanged: (val) {
              if(val.isNotEmpty) {
                if(i < widget.numberOfFields-1) {
                  focuses[i+1].requestFocus();
                }
              } else {
                if(i > 0) {
                  focuses[i-1].requestFocus();
                }
              }

              if(widget.controller != null) {
                widget.controller!.text = controllers.map((e) => e.text).join();
              }
            },
          )
        ),
      ));
    }

    return res;
  }

  Widget build(BuildContext context) {
    return Row(
      children: fields(),
    );
  }
}
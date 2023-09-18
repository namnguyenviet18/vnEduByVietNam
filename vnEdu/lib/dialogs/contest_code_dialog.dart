

import 'package:flutter/material.dart';
import 'package:vnedu/shared/login_instructions.dart';

class ContestCodeDialog extends StatefulWidget {
  const ContestCodeDialog({super.key});
  @override
  State<ContestCodeDialog> createState() => _ContestCodeDialogState();
}

class _ContestCodeDialogState extends State<ContestCodeDialog> {
  final TextEditingController _ctController = TextEditingController();
  bool _isTextFieldEmpty = false;

  void checkTextFieldEmpty(String inputValue) {
    if(inputValue.isEmpty) {
      setState(() {
        _isTextFieldEmpty = true;
      });
    }else {
      setState(() {
        _isTextFieldEmpty = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
          vertical: MediaQuery.of(context).size.height * 0.1
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: MediaQuery.of(context).size.width ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black,)
                        ),
                        const SizedBox(width: 10,),
                        const Text(
                          'Mã dự thi',
                          style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 60,),

                    TextField(
                      controller: _ctController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey, width: 1)
                        ),
                        hintText: 'Mã dự thi',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13,),
                        errorText: _isTextFieldEmpty ? 'Mã dự thi không được bỏ trống.' : null,
                        errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
                        contentPadding: const EdgeInsets.all(5),
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                      onChanged: (value) => checkTextFieldEmpty(value),
                    ),
                    const SizedBox(height: 30,),
                    GestureDetector(
                      onTap: () { },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        child: const Text('Vào thi', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
                      ),
                    )
                  ]
                ),
              ),
              const SizedBox(height: 65,),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const LoginInstructions(),
              )
            ],
          ),
        ),
      ),
    );
  }

}
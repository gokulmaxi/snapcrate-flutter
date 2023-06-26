import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key, required this.validationController, this.textController})
      : super(key: key);
  final validationController;
  final textController;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordOneSpecialChar = false;
  bool _hasUpperAndLowerCase = false;
  int _validationIndex = 0;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final specialCharacterRegex = RegExp(r'\W');
    final upperAndLowerCaseRegex = RegExp(r'(?=.*[a-z])(?=.*[A-Z])');

    setState(() {
      _isPasswordEightCharacters = false;
      _hasPasswordOneNumber = false;
      _hasPasswordOneSpecialChar = false;
      _hasUpperAndLowerCase = false;
      _validationIndex = 0;
      if (password.length >= 8) {
        _isPasswordEightCharacters = true;
        _validationIndex++;
      }
      if (numericRegex.hasMatch(password)) {
        _hasPasswordOneNumber = true;
        _validationIndex++;
      }
      if (specialCharacterRegex.hasMatch(password)) {
        _hasPasswordOneSpecialChar = true;
        _validationIndex++;
      }
      if (upperAndLowerCaseRegex.hasMatch(password)) {
        _hasUpperAndLowerCase = true;
        _validationIndex++;
      }
      if (_validationIndex == 4) {
        widget.validationController(true);
      } else {
        widget.validationController(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.textController,
            onChanged: (password) => onPasswordChanged(password),
            obscureText: !_isVisible,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                ),
                border: OutlineInputBorder(),
                labelText: 'Password'),
          ),
          const SizedBox(
            height: 20,
          ),
          ValidationIndicator(
            validationText: "Contains at least 8 characters",
            validationFlag: _isPasswordEightCharacters,
          ),
          ValidationIndicator(
            validationText: "Contains at least 1 number",
            validationFlag: _hasPasswordOneNumber,
          ),
          ValidationIndicator(
              validationText: "Contains at least 1 special character",
              validationFlag: _hasPasswordOneSpecialChar),
          ValidationIndicator(
              validationText:
                  "Contains at least 1 lower and 1 upper case character",
              validationFlag: _hasUpperAndLowerCase),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class ValidationIndicator extends StatelessWidget {
  const ValidationIndicator({
    super.key,
    required bool validationFlag,
    required String validationText,
  })  : _validationText = validationText,
        _validationFlag = validationFlag;

  final bool _validationFlag;
  final String _validationText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: _validationFlag ? Colors.green : Colors.transparent,
                border: _validationFlag
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(_validationText)
        ],
      ),
    );
  }
}

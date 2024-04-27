import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agalarspor/shopping_cart.dart'; // Sepet işlemleri için
import 'package:lottie/lottie.dart'; // Lottie paketinin eklenmesi

class PaymentPage extends StatefulWidget {
  final double totalPrice;

  PaymentPage({required this.totalPrice});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _cardNumber = '';
  // ignore: unused_field
  String _expiryDate = '';
  // ignore: unused_field
  String _cvv = '';
  // ignore: unused_field
  String _cardHolderName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: const Color.fromARGB(0, 68, 137, 255),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1907 1907 1907 1907',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberInputFormatter(),
                ],
                onSaved: (value) => _cardNumber = value!.replaceAll(' ', ''),
                validator: (value) {
                  if (value == null || value.replaceAll(' ', '').length != 16) {
                    return "Please 16 number to card";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'AA/YY',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ExpiryDateInputFormatter(),
                ],
                onSaved: (value) => _expiryDate = value!,
                validator: validateExpiryDate,
              ),
              SizedBox(height: 10),
              buildTextFormField(
                label: 'CVV',
                hint: '000',
                save: (value) => _cvv = value!,
                validator: validateCVV,
              ),
              SizedBox(height: 10),
              buildTextFormField(
                label: 'owner name',
                hint: 'Keyvan Arasteh',
                save: (value) => _cardHolderName = value!,
                validator: validateCardHolderName,
              ),
              SizedBox(height: 20),
              Text(
                "Total Amount: \$${widget.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitPayment,
                child: Text('Pay'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(0, 9, 166, 194), 
                  padding: EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12), 
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField({
    required String label,
    required String hint,
    required Function(String?) save,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      keyboardType: label == 'CVV' ? TextInputType.number : TextInputType.text,
      onSaved: save,
      validator: validator,
    );
  }

  String? validateExpiryDate(String? value) {
    if (value == null ||
        value.isEmpty ||
        !value.contains('/') ||
        value.length != 5) {
      return 'Card Date';
    }
    return null;
  }

  String? validateCVV(String? value) {
    if (value == null || value.isEmpty || value.length != 3) {
      return "CVV";
    }
    return null;
  }

  String? validateCardHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card Number ';
    }
    return null;
  }

  void submitPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _processPayment();
    }
  }

  void _processPayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("SUCCESFULLY"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Lottie.asset('assets/confirmed3.json',
                  width: 100),
              Text("Thanks for payment"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                ShoppingCart.clearCart();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(' ', '');
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      int nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); 
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
        buffer.write('/'); 
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

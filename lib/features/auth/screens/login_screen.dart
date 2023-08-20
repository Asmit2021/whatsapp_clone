import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_buttom.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      //showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
      //Provider ref -> Interact provider with provider
      //Widget ref -> makes widget interact with provider
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('WhatsApp will need to verify your phone number'),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: pickCountry,
                child: const Text('Pick Country'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 90,
                child: CustomButton(text: 'NEXT', onPressed: sendPhoneNumber),
              )
            ],
          ),
        ),
      ),
    );
  }
}

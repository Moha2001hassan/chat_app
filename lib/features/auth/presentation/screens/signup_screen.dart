import 'package:chat_app/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/shared/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'إنشاء حساب',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: nameController,
                    label: 'الاسم الكامل',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    label: 'البريد الإلكتروني',
                    hint: 'email@example.com',
                    keyboard: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: phoneController,
                    label: 'رقم الهاتف',
                    hint: '+20XXXXXXXXXX',
                    keyboard: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    label: 'كلمة المرور',
                    obscure: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: imageController,
                    label: 'رابط الصورة',
                    hint: 'https://example.com/image.jpg',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: authState is AuthLoading
                        ? null
                        : () async {
                            final user = UserModel(
                              id: '',
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),
                              email: emailController.text.trim(),
                              image: imageController.text.trim(),
                            );

                            var result = await authNotifier.register(
                              user,
                              passwordController.text.trim(),
                            );

                            if (!context.mounted) return;
                            if (result is Authenticated) {
                              showSnackBar(
                                context: context,
                                message: 'تم التسجيل بنجاح',
                                color: Colors.green,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            } else if (result is AuthError) {
                              showSnackBar(
                                context: context,
                                message: result.message.toString(),
                                color: Colors.red,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: authState is AuthLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  if (authState is AuthError)
                    Text(
                      authState.message.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('لديك حساب بالفعل؟ سجل الدخول'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    imageController.dispose();
    super.dispose();
  }
}

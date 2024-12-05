import "package:flutter/material.dart";
import "package:forms_app/presentation/widgets/widgets.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:   SingleChildScrollView(
          child: Column(children: [
             FlutterLogo( size: 100),
             _RegisterForm(),
             SizedBox(height: 20,),
          ],),
        ),
      )
    );
  }
}


class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
            const CustomTextFormField(
              label: 'Nombre de usuario',
            ),
            
            const SizedBox(height: 20,),
            const CustomTextFormField(
              label: 'Correo electronico',
            ),
            const SizedBox(height: 20,),
            const CustomTextFormField(
              label: 'Password',
              obscureText: true
            ),
            const SizedBox(height: 20,),
            FilledButton.tonalIcon(
              onPressed: (){}, 
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario'),
            ),
        ],
      )
    );
  }
}
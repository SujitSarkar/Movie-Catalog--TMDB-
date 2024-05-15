part of 'account_imports.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Welcome to Sheba Xyz',
        style: Theme.of(context).textTheme.bodyLarge,
      )).paddingSymmetric(horizontal: 16),
    );
  }
}

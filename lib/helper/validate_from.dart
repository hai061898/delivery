part of 'helper.dart';

final validatedPhoneForm = MultiValidator([
  RequiredValidator(errorText: 'Phone is required'),
  MinLengthValidator(9, errorText: 'Minimum 9 numbers')
]);

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'Email ID is required'),
  EmailValidator(errorText: 'Enter a valid Email ID')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Minimum 8 caracters')
]);
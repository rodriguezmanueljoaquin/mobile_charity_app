import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_charity_app/utils/validators.dart';

void main() {

  // EMAIL VALIDATOR
  test('validator correct email test', () {
    String mail = 'asdasd@asdasdasd.asd';
    assert(emailValidator(mail) == null);
  });

  test('validator incorrect email, without @, test', () {
    String mail = 'asdasdasdasdasd.asd';
    assert(emailValidator(mail) != null);
  });

  test('validator incorrect email, without domain, test', () {
    String mail = 'asdasda@';
    assert(emailValidator(mail) != null);
  });

  test('validator incorrect email, null, test', () {
    assert(emailValidator(null) != null);
  });

  // PASSWORD VALIDATOR
  test('validator correct password test', () {
    String password= 'asdasda@asd2123';
    assert(passwordValidator(password) == null);
  });

  test('validator incorrect password, too short, test', () {
    String password= 'asdasda';
    assert(passwordValidator(password) != null);
  });

  test('validator incorrect password, null, test', () {
    assert(passwordValidator(null) != null);
  });

  // DATE VALIDATOR
  test('validator correct date test', () {
    String date= '11/10/2000';
    assert(dateValidator(date) == null);
  });

  test('validator incorrect date, null, test', () {
    assert(passwordValidator(null) != null);
  });

  test('validator incorrect date, wrong format 1, test', () {
    String date= 'asdasda';
    assert(dateValidator(date) != null);
  });

  test('validator incorrect date, wrong format 2 MM/DD/YYYY, test', () {
    String date= '11/16/2000';
    assert(dateValidator(date) != null);
  });

  test('validator incorrect date, wrong format 3 DD-MM-YYYY, test', () {
    String date= '11-12-2000';
    assert(dateValidator(date) != null);
  });

  test('validator incorrect date, wrong format 4 DD/MM/YY, test', () {
    String date= '11/12/00';
    assert(dateValidator(date) != null);
  });

  // PHONE VALIDATOR
  test('validator correct phone test', () {
    String phone= '+54123456789012';
    assert(phoneValidator(phone) == null);
  });

  test('validator incorrect phone, null, test', () {
    assert(phoneValidator(null) != null);
  });

  test('validator incorrect phone, too short, test', () {
    String phone= '+541234';
    assert(phoneValidator(phone) != null);
  });

  test('validator incorrect phone, too long, test', () {
    String phone= '+54123456789012345';
    assert(phoneValidator(phone) != null);
  });

  test('validator incorrect phone, wrong format, test', () {
    String phone= '123456789012';
    assert(phoneValidator(phone) != null);
  });
}

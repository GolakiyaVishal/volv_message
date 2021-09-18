import 'package:flutter_test/flutter_test.dart';
import 'package:volv_message/utils/validator.dart';

void main(){
  test('blank space username test', (){
    expect(Validator.isUsername('    '), false);
  });

  test('short length username test', (){
    expect(Validator.isUsername('asc'), false);
  });

  test('valid username test', (){
    expect(Validator.isUsername('vishal'), true);
  });

  test('without country code phone number test', (){
    expect(Validator.isPhoneNumber('08141636818'), false);
  });

  test('contact number with country code', (){
    expect(Validator.isPhoneNumber('+12134567852'), true);
  });

  test('contact number with country code', (){
    expect(Validator.isPhoneNumber('+918141631868'), true);
  });
}
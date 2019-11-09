import 'core/constants.dart';
import './main.dart';

void main(){
  Constants.setEnvironment(Environment.STAGING);
  mainApp();
}
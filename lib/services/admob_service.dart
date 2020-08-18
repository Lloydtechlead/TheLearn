import 'dart:io';

class AdMobService {

   String getAdMobAppId() {
     if(Platform.isAndroid) {
       return 'ca-app-pub-7131176346219862~5237492653';
     }
     return null;
   }

   String getBannerAdId() {
     if(Platform.isAndroid) {
       return 'ca-app-pub-7131176346219862/1080148429';
     }
   }
}
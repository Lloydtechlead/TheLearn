import 'dart:io';

class AdMobService {

   String getAdMobAppId() {
     if(Platform.isAndroid) {
       return 'ca-app-pub-7131176346219862~5237492653';
     }
     return null;
   }

   String getBannerAdIdHomePage() {
     if(Platform.isAndroid) {
       return 'ca-app-pub-7131176346219862/1080148429';
     }
     return null;
   }

   String getBannerAdIdMainPage() {
     if(Platform.isAndroid) {
       return 'ca-app-pub-7131176346219862/4294018013';
     }
     return null;
   }
}
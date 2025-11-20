import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('hi'), Locale('mr')];

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'app_title': 'Lotus Dream Lucky Draw',
      'sponsored_by': 'Sponsored by MK Nagthuwas Transports Limited',
      'login': 'Login',
      'signup': 'Sign up',
      'logout': 'Logout',
      'username': 'Username',
      'mobile': 'Mobile number',
      'password': 'Password',
      'city': 'City',
      'entries': 'Entries',
      'otp': 'OTP',
      'verify_otp': 'Verify OTP',
      'not_robot': "I'm not a robot",
      'home_banner_title': 'Win the MK Nagthuwas Dream Car',
      'home_banner_subtitle':
          '3000 premium slots · 12 finalists · 13-slot mega wheel',
      'enter_draw': 'Enter draw',
      'finalists_today': 'Finalists selected today',
      'tickets_sold': 'Tickets sold',
      'revenue_collected': 'Revenue collected',
      'payment_gateway': 'Payment gateway',
      'refer_and_earn': 'Refer & earn bonus entries',
      'view_payment_options': 'View payment options',
      'spin_wheel': 'Spin the lucky wheel',
      'select_finalists': 'Select 12 finalists',
      'participants': 'Participants',
      'winners': 'Winners',
      'winner_stories': 'Winner stories & proof videos',
      'view_video': 'View video proof',
      'broadcast_title': 'Send message to all participants',
      'broadcast_hint': 'Write announcement for finalists and winners',
      'send_message': 'Send message',
      'language': 'Language',
      'security_center': 'Security & compliance',
      'data_security_blurb':
          '256-bit encrypted APIs, OTP verification, and fraud monitoring keep every payment safe.',
      'payment_methods': 'Payment methods',
      'refer_description':
          'Share your invite link, earn bonus spins when friends join.',
      'cta_pay_now': 'Pay entry fee',
      'cta_view_winners': 'View winners',
      'cta_view_participants': 'View participants',
      'spin_result_prefix': 'Result for',
      'next_time': 'Next time',
    },
    'hi': {
      'app_title': 'Lotus Dream भाग्यशाली ड्रा',
      'sponsored_by': 'प्रायोजक: एमके नागठुवास ट्रांसपोर्ट्स लिमिटेड',
      'login': 'लॉगिन',
      'signup': 'साइन अप',
      'logout': 'लॉगआउट',
      'username': 'उपयोगकर्ता नाम',
      'mobile': 'मोबाइल नंबर',
      'password': 'पासवर्ड',
      'city': 'शहर',
      'entries': 'एंट्री',
      'otp': 'ओटीपी',
      'verify_otp': 'ओटीपी सत्यापित करें',
      'not_robot': 'मैं रोबोट नहीं हूँ',
      'home_banner_title': 'एमके नागठुवास ड्रीम कार जीतें',
      'home_banner_subtitle': '3000 स्लॉट · 12 फाइनलिस्ट · 13 स्लॉट मेगा व्हील',
      'enter_draw': 'ड्रा में शामिल हों',
      'finalists_today': 'आज चुने गए फाइनलिस्ट',
      'tickets_sold': 'बेचे गए टिकट',
      'revenue_collected': 'इकट्ठा राजस्व',
      'payment_gateway': 'पेमेंट गेटवे',
      'refer_and_earn': 'रेफर करें और बोनस एंट्री पाएं',
      'view_payment_options': 'पेमेंट विकल्प देखें',
      'spin_wheel': 'लक़ी व्हील घुमाएँ',
      'select_finalists': '12 फाइनलिस्ट चुनें',
      'participants': 'प्रतिभागी',
      'winners': 'विजेता',
      'winner_stories': 'विजेता की कहानियाँ और वीडियो',
      'view_video': 'वीडियो प्रमाण देखें',
      'broadcast_title': 'सभी प्रतिभागियों को संदेश भेजें',
      'broadcast_hint': 'फाइनलिस्ट और विजेताओं के लिए घोषणा लिखें',
      'send_message': 'मेसिज भेजें',
      'language': 'भाषा',
      'security_center': 'सुरक्षा व अनुपालन',
      'data_security_blurb':
          '256-बिट एन्क्रिप्शन, ओटीपी सत्यापन और धोखाधड़ी निगरानी हर भुगतान को सुरक्षित रखती है।',
      'payment_methods': 'भुगतान विधियाँ',
      'refer_description':
          'अपना आमंत्रण लिंक साझा करें, दोस्त जुड़ें तो बोनस स्पिन पाएं।',
      'cta_pay_now': 'एंट्री शुल्क जमा करें',
      'cta_view_winners': 'विजेता देखें',
      'cta_view_participants': 'प्रतिभागी देखें',
      'spin_result_prefix': 'परिणाम',
      'next_time': 'अगली बार',
    },
    'mr': {
      'app_title': 'Lotus Dream भाग्यचक्र',
      'sponsored_by': 'प्रायोजक: एमके नागठुवास ट्रान्सपोर्ट्स लिमिटेड',
      'login': 'लॉगिन',
      'signup': 'साइन अप',
      'logout': 'लॉगआउट',
      'username': 'वापरकर्तानाव',
      'mobile': 'मोबाईल क्रमांक',
      'password': 'पासवर्ड',
      'city': 'शहर',
      'entries': 'नोंदी',
      'otp': 'ओटीपी',
      'verify_otp': 'ओटीपी तपासा',
      'not_robot': 'मी रोबोट नाही',
      'home_banner_title': 'एमके नागठुवास ड्रीम कार जिंका',
      'home_banner_subtitle': '3000 स्लॉट · 12 अंतिम स्पर्धक · 13 स्लॉट व्हील',
      'enter_draw': 'ड्रॉमध्ये सामील व्हा',
      'finalists_today': 'आज निवडलेले अंतिम स्पर्धक',
      'tickets_sold': 'विकलेले तिकीट',
      'revenue_collected': 'संकलित महसूल',
      'payment_gateway': 'पेमेंट गेटवे',
      'refer_and_earn': 'रेफर करा आणि बोनस नोंदी मिळवा',
      'view_payment_options': 'पेमेंट पर्याय पहा',
      'spin_wheel': 'भाग्यचक्र फिरवा',
      'select_finalists': '12 अंतिम स्पर्धक निवडा',
      'participants': 'स्पर्धक',
      'winners': 'विजेते',
      'winner_stories': 'विजेत्यांच्या कथा व व्हिडिओ',
      'view_video': 'व्हिडिओ पाहा',
      'broadcast_title': 'सर्व स्पर्धकांना संदेश पाठवा',
      'broadcast_hint': 'फायनलिस्ट व विजेत्यांसाठी घोषणा लिहा',
      'send_message': 'संदेश पाठवा',
      'language': 'भाषा',
      'security_center': 'सुरक्षा व नियम',
      'data_security_blurb':
          '256-बिट एनक्रिप्शन, ओटीपी पडताळणी व फसवणूक मॉनिटरिंग देयके सुरक्षित ठेवतात.',
      'payment_methods': 'पेमेंट पद्धती',
      'refer_description':
          'आमंत्रण लिंक शेअर करा, मित्र सहभागी झाल्यावर बोनस स्पिन मिळवा.',
      'cta_pay_now': 'एंट्री फी भरा',
      'cta_view_winners': 'विजेते पहा',
      'cta_view_participants': 'स्पर्धक पहा',
      'spin_result_prefix': 'परिणाम',
      'next_time': 'पुढच्या वेळी',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
    (item) => item.languageCode == locale.languageCode,
  );

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

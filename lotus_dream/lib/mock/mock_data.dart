import 'package:flutter/material.dart';

import '../models/draw_config.dart';
import '../models/participant.dart';
import '../models/payment_option.dart';
import '../models/winner.dart';

class MockData {
  static final DrawConfig drawConfig = DrawConfig(
    entryFee: 799,
    maxEntriesPerDraw: 3000,
    finalistsPerDraw: 12,
  );

  static final List<Participant> participants = [
    Participant(
      id: 'P001',
      username: 'Aarav Patil',
      mobileNumber: '9876543210',
      entriesPurchased: 4,
      city: 'Nagpur',
    ),
    Participant(
      id: 'P002',
      username: 'Diya Sharma',
      mobileNumber: '9023456712',
      entriesPurchased: 2,
      city: 'Pune',
    ),
    Participant(
      id: 'P003',
      username: 'Omkara Jadhav',
      mobileNumber: '9988776655',
      entriesPurchased: 5,
      city: 'Mumbai',
    ),
    Participant(
      id: 'P004',
      username: 'Zara Khan',
      mobileNumber: '9012345678',
      entriesPurchased: 3,
      city: 'Aurangabad',
    ),
    Participant(
      id: 'P005',
      username: 'Kabir Kulkarni',
      mobileNumber: '9456123780',
      entriesPurchased: 6,
      city: 'Bhopal',
    ),
    Participant(
      id: 'P006',
      username: 'Rhea Sawant',
      mobileNumber: '9345612987',
      entriesPurchased: 1,
      city: 'Amravati',
    ),
    Participant(
      id: 'P007',
      username: 'Neeraj Yadav',
      mobileNumber: '9765123409',
      entriesPurchased: 3,
      city: 'Raipur',
    ),
    Participant(
      id: 'P008',
      username: 'Sana Shaikh',
      mobileNumber: '9087123654',
      entriesPurchased: 2,
      city: 'Indore',
    ),
    Participant(
      id: 'P009',
      username: 'Manav Joshi',
      mobileNumber: '9654781230',
      entriesPurchased: 7,
      city: 'Delhi',
    ),
    Participant(
      id: 'P010',
      username: 'Krisha Bhagat',
      mobileNumber: '9123456701',
      entriesPurchased: 3,
      city: 'Nashik',
    ),
    Participant(
      id: 'P011',
      username: 'Aditi Verma',
      mobileNumber: '9345098761',
      entriesPurchased: 4,
      city: 'Kolhapur',
    ),
    Participant(
      id: 'P012',
      username: 'Yug Bansal',
      mobileNumber: '9654012378',
      entriesPurchased: 2,
      city: 'Wardha',
    ),
    Participant(
      id: 'P013',
      username: 'Lavanya Nair',
      mobileNumber: '9876001234',
      entriesPurchased: 5,
      city: 'Nagpur',
    ),
    Participant(
      id: 'P014',
      username: 'Rudra Kale',
      mobileNumber: '9234567012',
      entriesPurchased: 1,
      city: 'Pune',
    ),
    Participant(
      id: 'P015',
      username: 'Ira Gokhale',
      mobileNumber: '9765012345',
      entriesPurchased: 4,
      city: 'Satara',
    ),
  ];

  static final List<Winner> winners = [
    Winner(
      participant: participants[2].copyWith(status: ParticipantStatus.winner),
      prize: 'MK Nagthuwas SUV',
      videoUrl: 'https://cdn.example.com/videos/winner1.mp4',
      announcedOn: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Winner(
      participant: participants[6].copyWith(status: ParticipantStatus.winner),
      prize: 'Premium 5G Smartphone',
      videoUrl: 'https://cdn.example.com/videos/winner2.mp4',
      announcedOn: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Winner(
      participant: participants[9].copyWith(status: ParticipantStatus.winner),
      prize: 'Foldable Phone',
      videoUrl: 'https://cdn.example.com/videos/winner3.mp4',
      announcedOn: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  static const List<String> wheelSegments = [
    'MK Nagthuwas Car',
    'Galaxy Ultra Phone',
    'iPhone 16 Pro',
    'Pixel 10 Pro',
    'OnePlus Elite',
    'Vivo X Flagship',
    'Oppo Find Premium',
    'Nothing Phone 3',
    'Realme GT Master',
    'Motorola Edge Ultra',
    'Honor Magic Pro',
    'Xiaomi Ultra',
    'Next Time',
  ];

  static final List<PaymentOption> paymentOptions = [
    const PaymentOption(
      name: 'UPI AutoPay',
      description: 'GPay, PhonePe, Paytm secure intent flow',
      icon: '🔐',
    ),
    const PaymentOption(
      name: 'Cards & EMI',
      description: 'Visa, Mastercard, RuPay, EMI up to 12 months',
      icon: '💳',
    ),
    const PaymentOption(
      name: 'NetBanking',
      description: 'All major Indian banks with OTP & 3DS',
      icon: '🏦',
    ),
    const PaymentOption(
      name: 'Wallets',
      description: 'Amazon Pay, Mobikwik, Freecharge cashback',
      icon: '👜',
    ),
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];
}

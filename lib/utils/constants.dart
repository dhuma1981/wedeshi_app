import 'package:wedeshi/models/product_model.dart';

class Constants {
  static const BASE_REST_URL = "https://wedeshi.in/api/";

  static const String BRANDS =
      "Please send your Brand/Product details to us.\nOur verification team will validate data and upload in our application.\n\nEmail: wedeshi.in@gmail.com\n\nNote: Your email doesn't guarantee any listing, it may take longer time than expected due to many requests.";
  static const CATEGORIES = "Categories";

  static const SWADESHI = "स्वदेशी";
  static const WEDESHI = "विदेशी";

  static const DEFINATION_LOCAL = "Our defination of स्वदेशी";
  static const ABOUT_US = "About Us";
  static const DISCLAIMER = "Disclaimer";
  static const FEEDBACK = "Feedback";
  static const RATE_US = "Rate Us";

  static const RELATED_LOCAL_PRODUCTS = "Related $SWADESHI products";

  static const NO_PRODUCT_FOUND = "No related स्वदेशी products found!";

  static const PRODUCT_SHARE =
      " - क्या आप को पता था?\n\nचलिए स्वदेशी चीज़ो को अग्रिमता दे और देश को आगे बढ़ाए.\nइस एप के जरिए आप आसानीसे जान सकते है की कौन सा \"स्वदेशी\" प्रोडक्ट है और कौन सा \"विदेशी\" प्रोडक्ट। इतना ही नहीं, ये एप आपको कोई भी \"विदेशी\" प्रोडक्ट की जगह कौन सी \"स्वदेशी\" प्रोडक्ट खरीदनी चाहिए वो जानकारी भी देगा। कृपया इस ऐप को डाउनलोड करें।\n\nये एप्लीकेशन सभी देश वासियो तक पाहोचाए !\n\nhttps://bit.ly/swadeshiProducts\n\nजय हिन्द";

  static String getProductShareMessage(Product product) {
    return "${product.productName} - जिसे हम यूज़ करते है वो ${product.brandId == 5 ? SWADESHI : WEDESHI} है" +
        PRODUCT_SHARE;
  }
}

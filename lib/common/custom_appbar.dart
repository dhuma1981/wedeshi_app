import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wedeshi/screens/search_page.dart';

class Widgets {
  static PreferredSizeWidget getCustomAppBar(BuildContext context,
      {Function onShare}) {
    return AppBar(
      centerTitle: false,
      title: Image.network(
        "https://wedeshi.in/uploads/app/logo.png",
        width: 80,
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              onShare != null
                  ? onShare()
                  : Share.share(
                      "विदेशी नहीं वी-देशी  (स्वदेशी अपनाओ)\n\nबहोत हो गया बहार की चीजोको खरीदके, दूसरे देशको मुनाफा देना। अब सही समय है की हम सब एक होकर देश के प्रोडक्टस यानी की लोकल चीजों को खरीदे देश के प्रोडक्टस को अधिक महत्व देने का आग्रह रखे। इस एप के जरिए आप आसानीसे जान सकते है की कौन सा \"स्वदेशी\" प्रोडक्ट है और कौन सा \"विदेशी\" प्रोडक्ट। इतना ही नहीं, ये एप आपको कोई भी \"विदेशी\" प्रोडक्ट की जगह कौन सी \"स्वदेशी\" प्रोडक्ट खरीदनी चाहिए वो जानकारी भी देगा। कृपया इस ऐप को डाउनलोड करें।\n\nये एप्लीकेशन सभी देश वासियो तक पाहोचाए !\n\nhttps://play.google.com/store/apps/details?id=in.bi.wedeshi");
            }),
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
            }),

        //IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
      ],
    );
  }
}

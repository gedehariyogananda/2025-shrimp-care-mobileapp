import 'package:shrimp_care_mobileapp/features/disease/models/detail_disease.dart';

final List<DetailDisease> diseaseList = [
  DetailDisease(
    id: "Pe1",
    nameDisease: "Bintik Putih (White Spot Disease)",
    imageDisease: "assets/disease/bintik-putih.png",
    riskLevel: 5,
    moreInformation:
        "Food and Agriculture Organization of the United Nations (FAO), “Whiteleg Shrimp (Litopenaeus vannamei),” FAO Fisheries & Aquaculture.",
    definitionDisease:
        "White Spot Disease (WSD) adalah penyakit menular sangat mematikan pada udang yang disebabkan oleh White Spot Syndrome Virus (WSSV), virus DNA yang termasuk ke dalam keluarga nimavirus. Virus ini menginfeksi seluruh jaringan utama udang, terutama hepatopankreas dan epidermis. Infeksi WSSV biasanya timbul tiba-tiba dan menyebar cepat, menyebabkan kematian massal dalam waktu singkat.",
    symtomsDisease:
        "Bercak Putih Di Kulit Udang \\n Tubuh pucat \\n Tampak sekarat/lemah \\n Berenang ke permukaan",
    causesDisease:
        "Penyebab utama adalah virus WSSV. Virus ini sangat virulen dan menular melalui air, peralatan budidaya, atau induk udang yang terinfeksi. Karena virus tahan lama, udang yang tampak sehat pun dapat menularkan penyakit jika membawa virus secara laten.",
    preventionDisease:
        "Pencegahan terutama dengan biosekuriti ketat. Gunakan induk (broodstock) SPF/SPR (bebas spesifik patogen), disinfeksi telur/nauplii dengan iodofor/formalin, dan saring air kolam untuk mencegah pembawa virus masuk. Kendalikan kualitas air dan kondisi lingkungan (pH, suhu, oksigen terlarut stabil), hindari stres mendadak pada udang, serta jauhi pakan segar (ikan rucah) yang bisa membawa virus. Setelah panen atau deteksi infeksi, lakukan pemangkasan lumpur (drainase) kolam dan desinfeksi peralatan dengan klorin 30 ppm untuk mematikan virus pembawa",
    recomendationDisease:
        "Tidak ada obat atau vaksin yang efektif untuk WSD. Penanganan difokuskan pada pencegahan dan pemulihan lingkungan kolam. Jika terinfeksi, kolam dikeringkan sepenuhnya, kemudian dilakukan sanitasi total (penyemprotan klorin) sebelum siklus budidaya berikutnya. Perbaikan manajemen pakan, suplai oksigen, dan probiotik dapat membantu mengurangi dampak sekunder, meski tidak menyembuhkan virus.",
  ),
  DetailDisease(
    id: "Pe6",
    nameDisease: "Kepala Kuning (Yellow Head Disease)",
    imageDisease: "assets/disease/kepala-kuning.png",
    riskLevel: 5,
    moreInformation: "Jala, “Yellow Head Disease pada Udang,” Jala Tech",
    definitionDisease:
        "Yellow Head Disease adalah infeksi virus sangat mematikan yang menyerang udang vannamei dan terutama udang windu (Penaeus monodon). Penyebabnya adalah Yellow Head Virus (YHV) genotipe 1, virus RNA bermembran dalam famili Roniviridae. Nama penyakit ini berasal dari gejala khasnya, yaitu menguningnya kepala udang akibat hepatopankreas membesar dan berwarna kuning",
    symtomsDisease:
        "Tubuh pucat \\n Insang berwarna kekuningan \\n Hepatopankreas berwarna kuning",
    causesDisease:
        "Virus YHV (Yellow Head Virus) yang kuat menular melalui kontak langsung udang terinfeksi, serta media air atau partikel yang terkontaminasi. Penularan bisa vertikal (dari induk ke larva) maupun horizontal (udara, burung, crustacea carrier). YHV sangat sensitif terhadap perubahan lingkungan – stres mendadak (perubahan suhu, DO, pH) dapat memicu wabah.",
    preventionDisease:
        "Gunakan induk dan benur bebas YHV (SPF), serta ujicoba laboratorium (PCR) sebelum mengembangbiakkan. Karantina benur baru dan desinfeksi alat tambak dengan klorin atau iodofor sangat disarankan. Hindari kontak dengan udang liar atau vektor potensial (burung, udang liar). Pastikan kualitas air stabil dan berikan suplemen imunostimulan (seperti beta-glukan) untuk meningkatkan daya tahan.",
    recomendationDisease:
        "Tidak ada obat atau vaksin. Segera padamkan wabah dengan memanen seluruh udang yang sakit dan lalu memusnahkannya (tidak dibuang ke lingkungan). Kolam harus dikeringkan dan disinfeksi total. Secara preventif, suplemen imunostimulan (misalnya β-glukan, probiotik, vitamin larutan renang) diberikan untuk meminimalkan dampak sekunder, tetapi efektivitasnya terbatas pada YHD yang akut.",
  ),
  DetailDisease(
    id: "Pe2",
    nameDisease: "Bintik Hitam (Black Spot Disease)",
    imageDisease: "assets/disease/bintik-hitam.png",
    riskLevel: 3,
    moreInformation: "Jala, “Black Spot Disease pada Udang,” Jala Tech.",
    definitionDisease:
        "Penyakit Bintik Hitam pada udang (shell disease) adalah infeksi bakteri yang menyebabkan bercak-bercak hitam atau coklat pada cangkang udang. Penyakit ini sering muncul setelah udang dipanen (post-harvest) dan disebut pula black spot syndrome. Udang yang terinfeksi umumnya tidak mati mendadak, tetapi kualitasnya menurun karena cacat kosmetik pada cangkang",
    symtomsDisease:
        "Bintik hitam di badan \\n Antena patah \\n Kaki tidak lengkap \\n Ekor berwarna hitam",
    causesDisease:
        "Penyebab utama adalah bakteri Vibrio anguillarum (dan kadang bakteri lain seperti Pseudomonas atau Aeromonas) yang tumbuh subur pada kondisi kualitas air buruk. Faktor pemicu antara lain kualitas air yang rendah (nitrogen amonia tinggi, oksigen rendah), kelebihan bahan organik di dasar tambak, dan kepadatan budidaya terlalu tinggi. Kondisi kelemahan pascapanen (udang stres dan terkena matahari) juga mempercepat perkembangan bercak hitam",
    preventionDisease:
        "Kebersihan tambak sangat penting. Setelah panen, bersihkan dasar kolam dari lumpur, kotoran, sisa pakan, dan kulit luluh (moulting) agar sumber bakteri diminimalkan. Pastikan kualitas air tetap optimal (oksigen cukup, nitrat/amonia terkontrol). Kurangi kepadatan tebar yang terlalu tinggi dan terapkan rotasi tambak. Untuk pencegahan pascapanen, pendinginan cepat udang atau pemberian larutan askorbat (vitamin C) dalam larutan saline es dapat menghambat pembentukan bercak hitam",
    recomendationDisease:
        "Tidak ada obat spesifik yang mudah digunakan. Penanganan meliputi manajemen lingkungan: suplemen vitamin C atau glukonat kalsium dalam air bisa membantu memperbaiki kekuatan cangkang. Beberapa kasus parah memerlukan aplikasi antibiotik spektrum luas (misalnya tetrasiklin atau eritromisin sesuai uji sensitivitas) di dalam air secara hati-hati. Namun, perbaikan kualitas air dan sanitasi tambak tetap menjadi langkah utama, karena pengobatan bakterial sulit efektif dalam budidaya luas.",
  ),
  DetailDisease(
    id: "Pe3",
    nameDisease: "Kotoran Putih (White Feces Disease)",
    imageDisease: "assets/disease/kotoran-putih.png",
    riskLevel: 4,
    moreInformation:
        "The Fish Site, “Prevention of White Feces Syndrome, White Gut Disease, and White Muscle Disease in Shrimp,” The Fish Site",
    definitionDisease:
        "White Feces Syndrome (WFS) adalah kelainan sindromik pada udang budidaya yang ditandai dengan banyaknya feses putih (kotoran berwarna putih atau kekuningan) yang muncul di kolam. WFS sering terkait dengan gangguan pada sistem pencernaan dan hepatopankreas (HP) udang, dipengaruhi oleh infeksi sekunder atau kerusakan mikrovili usus. Penyebab spesifik WFS bersifat multifaktorial (infeksi, stres, nutrisi buruk) dan sering muncul setelah ~50–60 hari budidaya.",
    symtomsDisease:
        "Kotoran mengapung di permukaan \\n Usus tidak terisi makanan, namun untaian feses berwarna putih \\n Nafsu makan menurun",
    causesDisease:
        "WFS diinduksi oleh kerusakan mikrovili hepatopankreas (penyusunan ATM) yang dilepaskan ke saluran pencernaan. Berbagai patogen oportunistik (seperti Enterocytozoon hepatopenaei/EHP atau bakteri Vibrio) dapat memicu terlepasnya mikrovili ini. Kondisi lingkungan yang buruk (kepadatan tinggi, kualitas air buruk, limbah pakan menumpuk) memperparah penyakit. Infeksi virus AHPND atau parasit mikroskopis juga sering bersamaan dengan WFS.",
    preventionDisease:
        "Pertahankan kualitas air optimal (DO, pH, salinitas stabil) dan manajemen pakan tepat (hindari overfeeding). Budidaya dengan intensitas sedang dan biosekuriti ketat sangat penting: gunakan benih serta induk bebas patogen, lakukan skrining PCR untuk pathogen umum, serta desinfeksi peralatan dan air sebelum masuk ke kolam. Penggunaan probiotik dan prebiotik dalam pakan bisa membantu menstabilkan mikroflora usus udang, sedangkan bahan imunostimulan (misalnya ekstrak herbal/β-1,3-glukan) dapat meningkatkan daya tahan udang. Pemberian mineral (Ca, Zn) dan vitamin (terutama C dan E) juga dianjurkan untuk memperkuat fungsi usus dan HP.",
    recomendationDisease:
        "Belum ada obat tunggal untuk mengatasi WFS. Penanganan utama adalah meningkatkan kondisi tambak: kuras kolam secara bertahap jika perlu, pemberian probiotik dalam air atau pakan, serta pemberian vitamin C (sekitar 50–100 mg/kg pakan) dan suplemen herbal untuk mendukung imunitas. Selain itu, siklus pemanenan dapat dipersingkat dan kolam yang parah diistirahatkan. Beberapa petani mencoba mereduksi beban patogen dengan perlakuan air (ozonisasi atau perendaman larutan ozon) meski efektivitasnya belum teruji sepenuhnya.",
  ),
  DetailDisease(
    id: "Pe4",
    nameDisease: "Nekrosis (IHHNV)",
    imageDisease: "assets/disease/nekrosis.png",
    riskLevel: 4,
    moreInformation:
        "World Organisation for Animal Health (WOAH), “Infectious Hypodermal and Haematopoietic Necrosis (IHHN),” Aquatic Manual 2021 \\n Food and Agriculture Organization of the United Nations (FAO), “Whiteleg Shrimp (Litopenaeus vannamei),” FAO Fisheries & Aquaculture,",
    definitionDisease:
        "Penyakit IHHNV adalah infeksi kronis oleh virus IHHNV (family Parvoviridae) yang menyebabkan Runt Deformity Syndrome (RDS) pada udang Litopenaeus vannamei. IHHNV tidak menimbulkan kematian massif, tetapi menghambat pertumbuhan udang sehingga menurunkan produktivitas.",
    symtomsDisease:
        "Antena patah \\n Kaki tidak lengkap \\n Ekor berwarna hitam \\n Ekor Rusak",
    causesDisease:
        "Disebabkan oleh IHHNV, virus kecil beruntai tunggal (single-stranded DNA virus). Virus ini menular melalui air, kontak langsung antar udang, dan vertikal (dari induk ke keturunan). Vektor alamiah belum jelas, namun penularan dapat melalui kanibalisme atau air tercemar.",
    preventionDisease:
        "Langkah pencegahan utama adalah mencegah masuknya virus ke tambak. Gunakan induk dan benih yang sudah dites bebas IHHNV (SPF/SPR), serta disinfeksi telur, larva awal, dan peralatan secara menyeluruh. Setelah deteksi infeksi, tambak harus dikosongkan, disanitasi secara intensif (misal pemutihan kolam dengan klorin pekat) dan dibiarkan kering lama sebelum budidaya lanjutan. Daya tahan udang terhadap IHHNV juga dapat ditingkatkan dengan nutrisi optimal dan probiotik, meski virus sulit diatasi.",
    recomendationDisease:
        "Belum ada pengobatan spesifik. Jika terinfeksi, tindakan terbaik adalah menghentikan budidaya (desinfeksi total) untuk mencegah penularan lebih luas. Pada tingkat individu, perawatan suportif dengan meningkatkan kualitas air (oksigen, pH stabil), suplementasi nutrisi (vitamin), dan penghindaran stres dapat meminimalkan dampak turunannya.",
  ),
  DetailDisease(
    id: "Pe5",
    nameDisease: "Udang Gripis",
    imageDisease: "assets/disease/gripis.png",
    riskLevel: 2,
    moreInformation:
        "Food and Agriculture Organization of the United Nations (FAO), “The State of World Fisheries and Aquaculture,” FAO Fisheries Report",
    definitionDisease:
        "Shell disease (dikenal lokal sebagai udang gripis) adalah infeksi bakteri yang mengakibatkan erosi atau pengkeroposan cangkang udang. Penyakit ini biasanya disebabkan oleh bakteri perombak kitin (sering Vibrio spp. atau Pseudomonas) dan ditandai dengan bercak-bercak gelap serta lubang kecil pada eksoskeleton. Bila parah, kerusakan cangkang ini dapat membuka jalan bagi infeksi sekunder dan merusak organ dalam.",
    symtomsDisease:
        "Nafsu makan menurun \\n Warna tubuh coklat \\n Karapas rontok",
    causesDisease:
        "Disebabkan oleh bakteri kitinolitik yang memecah lapisan chitin pada cangkang. Kondisi lingkungan yang buruk (kualitas air rendah, kekurangan kalsium atau nutrisi, kepadatan tinggi, oksigen rendah) membuat bakteri ini berkembang pesat. Infeksi sering kali terjadi pada udang muda yang baru berganti kulit (eksoskeleton tipis) atau pada udang yang terluka.",
    preventionDisease:
        "Pertahankan kualitas air dan nutrisi yang baik. Pastikan pakan mengandung mineral penting (kalsium, magnesium) serta vitamin C/E untuk memperkuat pembentukan cangkang. Kurangi stres fisik dengan menghindari kepadatan terlampau tinggi dan menjaga keseimbangan air (salinitas, pH stabil). Penerapan biosekuriti dan pemeriksaan rutin juga penting.",
    recomendationDisease:
        "Penanganan meliputi perbaikan lingkungan tambak dan pemberian suplemen. Pemberian vitamin C (50–100 mg/kg pakan) dan suplemen kalsium dapat memperkuat cangkang yang tumbuh. Jika erosi luas atau sudah ada infeksi sekunder, antibiotik spektrum luas (seperti oxytetracycline atau sulfonamid) terkadang digunakan dengan dosis sesuai rekomendasi karantina setempat. Namun, tindakan utama adalah memperbaiki sanitasi tambak dan menghilangkan udang yang paling parah agar tidak menyebarkan bakteri.",
  ),
  DetailDisease(
    id: "Pe7",
    nameDisease: "Taura Syndrome Virus (TSV)",
    imageDisease: "assets/disease/taura.png",
    riskLevel: 4,
    moreInformation: "Jala, “Taura Syndrome pada Udang,” Jala Tech",
    definitionDisease:
        "Taura Syndrome adalah penyakit virus yang terutama menyerang udang vannamei pada fase peralihan larva–juvenil. Penyebabnya adalah Taura Syndrome Virus (TSV), virus RNA berukuran kecil (keluarga Picornaviridae). Wabah pertama kali terdeteksi di Sungai Taura, Ekuador pada akhir 1990-an. TSV dikenal cepat menular melalui kanibalisme antar udang dan media air",
    symtomsDisease:
        "Hepatopankreas berwarna kuning \\n Ekor berwarna merah \\n Kulit lunak",
    causesDisease:
        "Virus TSV sangat mudah menular, terutama melalui bangkai udang kanibal, peralatan, atau air yang terkontaminasi. Vektor seperti serangga air, krustasea liar, dan burung juga dapat membawa virus. Kondisi padat tebar tinggi dan sanitasi buruk mempercepat penyebaran.",
    preventionDisease:
        "Gunakan benur SPF dan induk terbebas TSV, serta desinfeksi telur/benur dengan iodofor. Hindari kanibalisme (beri pakan cukup), jaga kepadatan tambak optimal, serta lakukan filterisasi air masuk untuk mencegah vektor masuk. Terapkan biosekuriti, termasuk skrining rutin (PCR) pada udang remaja. Pastikan juga sanitasi peralatan dan tambak, serta cegah paparan stres lingkungan mendadak.",
    recomendationDisease:
        "Tidak ada obat yang menyembuhkan TSV. Jika terdeteksi, segera hentikan penebaran, bersihkan kolam (drainase), dan taburkan agen desinfektan (kalsium hipoklorit atau iodofor) ke dalam air sisa untuk mematikan virus. Pemberian immunostimulan (β-glukan, vitamin) serta probiotik dalam pakan dapat membantu mengurangi mortalitas sekunder, namun tidak efektif melawan virus. Upaya terbaik adalah mengelola pencegahan dan biosafety secara ketat.",
  ),
  DetailDisease(
    id: "Pe8",
    nameDisease: "Insang Merah (Red Gill Disease)",
    imageDisease: "assets/disease/insang-merah.png",
    riskLevel: 3,
    moreInformation:
        "Food and Agriculture Organization of the United Nations (FAO), “Health Management and Biosecurity Maintenance in White Shrimp Farming,” FAO Aquaculture Technical Paper",
    definitionDisease:
        "Insang Merah adalah penyakit udang yang ditandai dengan perubahan warna insang menjadi kemerahan (seharusnya transparan). Kondisi ini terutama dilaporkan pada udang dewasa atau induk di tambak dan biasanya disebabkan oleh infeksi bakteri Vibrio tipe tertentu. Penyakit ini juga dikenal sebagai Vibriosis pada insang dan dapat menyebabkan kematian udang dalam waktu relatif singkat jika tidak ditangani.",
    symtomsDisease:
        "Insang Berwarna Merah \\n Mati Di Tanggul \\n Berenang ke permukaan",
    causesDisease:
        "Ditemukan bakteri Vibrio (bisa V. harveyi, V. parahaemolyticus, atau V. alginolyticus) pada kasus ini. Bakteri ini merusak jaringan insang, menimbulkan pendarahan lokal yang terlihat merah. Faktor pemicu meliputi kualitas air yang buruk (amonia tinggi, oksigen rendah), kepadatan induk terlalu padat, dan stres (perubahan suhu, pH tiba-tiba)",
    preventionDisease:
        "Jaga kualitas air di kolam/bak induk agar tetap optimal (oksigen ≥6 ppm, amonia/ nitrit rendah). Kurangi kepadatan populasi induk dan hindari stres (menstabilkan suhu, pH, serta salinitas). Pisahkan induk sakit dari yang sehat segera setelah gejala muncul. Pemberian pakan bergizi lengkap dan suplemen vitamin (khususnya vitamin C dan B kompleks) dapat memperkuat imunitas udang.",
    recomendationDisease:
        " Antibiotik tetrasiklin atau makrolida terbukti efektif melawan Vibrio penyebab Insang Merah. Misalnya, eritromisin dosis 40 ppm dan doksisiklin 1–5 ppm dapat digunakan sesuai rekomendasi ahli kesehatan perikanan. Pemberian antibiotik ini sebaiknya dilakukan bersama aerasi optimal dan pergantian air sebagian. Selain itu, proses pengeringan bak, pengangkatan lumpur dan desinfeksi (formalin atau klorin ringan) disarankan setelah pemeliharaan selesai untuk mencegah kambuh.",
  ),
];

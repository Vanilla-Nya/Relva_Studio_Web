import 'package:flutter/material.dart';

/// Comprehensive data model for a Contributor's CV & Portfolio Profile
class CvProfileData {
  final String id;
  final String name;
  final String roleEn;
  final String roleId;
  final String companyBadge;
  final String statusEn;
  final String statusId;
  final String bioShortEn;
  final String bioShortId;
  final String bioDetailEn;
  final String bioDetailId;
  final String photoAsset;
  final String backgroundMedia;
  final String initials;
  final String badgeLabel;
  final String email;
  final String locationEn;
  final String locationId;
  final String githubUrl;
  final String linkedinUrl;

  // Key numerical metrics
  final String experienceYears;
  final String deliveredProjects;
  final String qualityStandard;
  final String techFrameworks;

  // Technical skills categorized
  final List<Map<String, dynamic>> skills;

  // Featured flagship projects
  final List<Map<String, dynamic>> projects;

  // Educational history (SD, SMP, SMA, College)
  final List<Map<String, dynamic>> educations;

  // Professional work experience timeline
  final List<Map<String, dynamic>> experiences;

  const CvProfileData({
    required this.id,
    required this.name,
    required this.roleEn,
    required this.roleId,
    required this.companyBadge,
    required this.statusEn,
    required this.statusId,
    required this.bioShortEn,
    required this.bioShortId,
    required this.bioDetailEn,
    required this.bioDetailId,
    required this.photoAsset,
    required this.backgroundMedia,
    required this.initials,
    required this.badgeLabel,
    required this.email,
    required this.locationEn,
    required this.locationId,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.experienceYears,
    required this.deliveredProjects,
    required this.qualityStandard,
    required this.techFrameworks,
    required this.skills,
    required this.projects,
    required this.educations,
    required this.experiences,
  });
}

/// Repository providing profiles for Relva Studio & MAPOTECH Contributors
class CvProfileRepository {
  static const CvProfileData alfon = CvProfileData(
    id: 'alfon',
    name: 'Alfon Soetanto',
    roleEn: 'Owner & Founder of RelvaStudio | Systems & Software Architect',
    roleId: 'Owner & Founder RelvaStudio | Arsitek Sistem & Perangkat Lunak',
    companyBadge: 'RELVA STUDIO FOUNDER',
    statusEn: 'Available for New Projects & Directorship',
    statusId: 'Tersedia untuk Proyek Baru & Kepemimpinan Teknis',
    bioShortEn:
        'Owner and lead visionary of Relva Studio. Spearheading high-performance multiplatform engineering, custom zero-dependency UI architectures, and flagship platforms including MAPOTECH, RevGEO, and RevHelix.',
    bioShortId:
        'Owner dan visioner utama Relva Studio. Memimpin rekayasa multiplatform performa tinggi, arsitektur UI independen tanpa dependensi eksternal, dan platform unggulan meliputi MAPOTECH, RevGEO, dan RevHelix.',
    bioDetailEn:
        'As the Founder and Lead Systems Architect at Relva Studio, I specialize in architecting production-grade multiplatform Flutter systems, high-performance APIs, and custom design systems built completely from scratch without third-party UI library bloat. From healthcare suites like MAPOTECH to boundary spatial engines like RevGEO and automated input pipelines like RevHelix, my focus is relentlessly on speed, architectural integrity, and delightful user experiences.',
    bioDetailId:
        'Sebagai Founder dan Lead Systems Architect di Relva Studio, saya berfokus pada arsitektur sistem Flutter multiplatform tingkat produksi, API performa tinggi, serta perancangan desain antarmuka kustom murni tanpa beban dependensi UI pihak ketiga. Mulai dari platform kesehatan terpadu MAPOTECH, mesin batas spasial RevGEO, hingga pipeline otomasi input RevHelix, dedikasi saya selalu pada kecepatan, integritas arsitektur, dan pengalaman pengguna optimal.',
    photoAsset: 'assets/ElysiaMeme.gif',
    backgroundMedia: 'assets/ElysiaBackgroundProfile.gif',
    initials: 'AS',
    badgeLabel: 'RELVA OWNER',
    email: 'contact@relvastudio.com',
    locationEn: 'Bondowoso, East Java • Indonesia (Remote & Hybrid)',
    locationId: 'Bondowoso, Jawa Timur • Indonesia (Remote & Hybrid)',
    githubUrl: 'https://github.com',
    linkedinUrl: 'https://linkedin.com',
    experienceYears: '4+',
    deliveredProjects: '10+',
    qualityStandard: '100%',
    techFrameworks: '8+',
    skills: [
      {
        'name': 'Flutter Multiplatform (Web, Mobile, Desktop)',
        'pct': 0.95,
        'category': 1,
      },
      {
        'name': 'Dart (Language & Core SDK)',
        'pct': 0.92,
        'category': 1,
      },
      {
        'name': 'Custom UI/UX, Animations & Canvas CustomPainter',
        'pct': 0.92,
        'category': 1,
      },
      {
        'name': 'UI Prototype & Interactive Design Systems',
        'pct': 0.90,
        'category': 1,
      },
      {
        'name': '3D Artist & Environment Modeling (Blender)',
        'pct': 0.58,
        'category': 1,
      },
      {
        'name': 'Unity Engine & 3D Interactive Exploration',
        'pct': 0.55,
        'category': 1,
      },
      {
        'name': 'PostgreSQL & Relational Data Modeling',
        'pct': 0.82,
        'category': 2,
      },
      {
        'name': 'RevGEO Spatial Boundary & Restriction API Engine',
        'pct': 0.88,
        'category': 2,
      },
      {
        'name': 'RevHelix Automated Data Input & Batch Processing',
        'pct': 0.86,
        'category': 2,
      },
      {
        'name': 'RESTful API Architecture & HTTP Protocols',
        'pct': 0.88,
        'category': 2,
      },
      {
        'name': 'Clean Architecture, Repository Pattern & Reactive State',
        'pct': 0.92,
        'category': 3,
      },
      {
        'name': 'Git Version Control & CI/CD Pipelines',
        'pct': 0.88,
        'category': 3,
      },
    ],
    projects: [
      {
        'title': 'MAPOTECH — Healthcare Operations Platform',
        'subtitle':
            'Medical Application Platform for Operations, Technology & Connected Healthcare',
        'subtitleId':
            'Platform Operasi Medis Terpadu untuk Klinik, Rumah Sakit & Farmasi',
        'badge': 'Flagship Platform',
        'descEn':
            'Comprehensive healthcare operations platform built entirely with Flutter. Features multi-role authentication (Owner, Admin, Doctor), smart EMR with ICD-10 diagnostic indexing, real-time medicine inventory alerts, digital attendance, and financial cashier billing.',
        'descId':
            'Platform operasional kesehatan komprehensif yang dibangun sepenuhnya dengan Flutter. Dilengkapi autentikasi multi-peran (Owner, Admin, Dokter), Rekam Medis Elektronik (EMR) cerdas berstandar ICD-10, peringatan stok obat real-time, absensi digital, serta modul kasir & keuangan.',
        'tags': [
          'Flutter',
          'Clean Architecture',
          'EMR Engine',
          'ICD-10',
          'Healthcare Tech',
        ],
        'icon': Icons.local_hospital_rounded,
        'actionRoute': '/mapotech',
        'actionUrl': null,
        'actionLabelEn': 'View MAPOTECH Platform →',
        'actionLabelId': 'Buka Platform MAPOTECH →',
      },
      {
        'title': 'RevGEO — Boundary Limitation & Geo API Platform',
        'subtitle':
            'High-Performance Spatial Restriction & Geofencing Boundary Engine',
        'subtitleId':
            'Engine Pembatas Wilayah & Validasi Geofencing Performa Tinggi',
        'badge': 'Live Production API',
        'descEn':
            'Specialized boundary API and spatial limitation engine providing coordinates validation, radius restriction, and geofencing boundaries for modern web and mobile ecosystems. Accessible live at https://revgeo.relvastudio.com/.',
        'descId':
            'API pembatas wilayah dan engine spasial khusus yang menyediakan validasi koordinat, restriksi radius, dan batas geofencing untuk ekosistem aplikasi modern. Dapat diakses langsung di https://revgeo.relvastudio.com/.',
        'tags': [
          'Spatial API',
          'Geofencing',
          'Boundary Engine',
          'Microservices',
          'Flutter & REST',
        ],
        'icon': Icons.map_rounded,
        'actionRoute': null,
        'actionUrl': 'https://revgeo.relvastudio.com/',
        'actionLabelEn': 'Access RevGEO Portal ↗',
        'actionLabelId': 'Buka Portal RevGEO ↗',
      },
      {
        'title': 'RevHelix — Automated Input & Data Pipeline Engine',
        'subtitle':
            'Intelligent Workflow Automation & High-Throughput Input Engine',
        'subtitleId':
            'Mesin Otomasi Input Data Cerdas & Pemrosesan Batch Otomatis',
        'badge': 'Automation Engine',
        'descEn':
            'High-speed pipeline automation and robotic input engine designed for structured data entry, batch validation, and automated workflows — specifically applied for automated input operations such as CKG automated processing. Built with Flutter & automation backends.',
        'descId':
            'Mesin otomasi pipeline berkecepatan tinggi yang dirancang untuk input data terstruktur, validasi batch, dan alur kerja otomatis — khususnya diimplementasikan untuk kebutuhan otomasi input seperti pemrosesan CKG. Dibangun dengan Flutter dan sistem otomasi terintegrasi.',
        'tags': [
          'Flutter',
          'Automation Engine',
          'Input Pipelines',
          'CKG Automation',
          'Batch Processing',
        ],
        'icon': Icons.bolt_rounded,
        'actionRoute': null,
        'actionUrl': null,
        'actionLabelEn': 'Automation Architecture',
        'actionLabelId': 'Arsitektur Otomasi',
      },
    ],
    educations: [
      {
        'title': 'Politeknik Negeri Jember (Polije)',
        'degreeEn':
            'Bachelor of Applied Science (D4) in Informatics Engineering (Prodi TIF)',
        'degreeId': 'Sarjana Terapan (D4) Teknik Informatika (Prodi TIF)',
        'departmentEn': 'Department of Information Technology (TI)',
        'departmentId': 'Jurusan Teknologi Informasi (TI)',
        'period': '2024 - Present',
        'badgeEn': 'Higher Education',
        'badgeId': 'Pendidikan Tinggi',
        'isOngoing': true,
        'progress': 0.35,
        'progressNoteEn':
            'Class of 2024 (On-going) • Systems Architecture & Multiplatform Research',
        'progressNoteId':
            'Angkatan 2024 (Sedang Menempuh) • Riset Arsitektur Sistem & Multiplatform',
        'descEn':
            'Currently pursuing D4 Informatics Engineering (Prodi TIF), Department of Information Technology (TI) as Class of 2024. Active research in production Flutter systems, spatial APIs (RevGEO), automated input pipelines (RevHelix), and high-performance computing.',
        'descId':
            'Sedang menempuh jenjang Sarjana Terapan (D4) Teknik Informatika (Prodi TIF) di Jurusan Teknologi Informasi (TI) angkatan 2024. Fokus pada riset produksi Flutter, API spasial (RevGEO), otomasi pipeline data (RevHelix), dan rekayasa perangkat lunak modern.',
        'tags': [
          'Teknik Informatika (Prodi TIF)',
          'Jurusan TI',
          'Polije Jember',
          'Angkatan 2024',
          'Multiplatform Flutter',
          'On-going',
        ],
        'icon': Icons.school_rounded,
        'asset': 'assets/school_polije.png',
        'acronym': 'POLIJE',
        'actionUrl': 'https://polije.ac.id/',
        'actionLabelEn': 'Visit Official Polije Website',
        'actionLabelId': 'Kunjungi Website Resmi Polije',
      },
      {
        'title': 'SMA Negeri 2 Bondowoso (SMADA)',
        'degreeEn': 'Natural Sciences & Mathematics (MIPA)',
        'degreeId': 'Peminatan Matematika & Ilmu Pengetahuan Alam (MIPA)',
        'departmentEn': 'Senior High School Diploma • Accredited A',
        'departmentId': 'Pendidikan Menengah Atas • Terakreditasi A',
        'period': '2021 - 2024',
        'badgeEn': 'Senior High School',
        'badgeId': 'Sekolah Menengah Atas',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Graduated 2024 • 3-Year MIPA Curriculum Completed (100%)',
        'progressNoteId':
            'Lulus Tahun 2024 • Kurikulum 3 Tahun MIPA Selesai (100%)',
        'descEn':
            'Graduated senior high school in 2024 focusing on Natural Sciences and Mathematics (MIPA). Built solid foundations in computational logic, mathematics, physics, and early programming initiatives.',
        'descId':
            'Lulus pendidikan menengah atas pada tahun 2024 di peminatan MIPA (3 tahun). Membangun fondasi kuat dalam logika komputasi, matematika analitis, fisika, serta inisiatif pemrograman komputer.',
        'tags': [
          'SMAN 2 Bondowoso',
          'SMADA',
          'Peminatan MIPA',
          'Lulus 2024',
          'Algoritma & Logika',
          'Lulus / Completed',
        ],
        'icon': Icons.account_balance_rounded,
        'asset': 'assets/school_smada.jpg',
        'acronym': 'SMADA',
        'actionUrl': 'https://sman2bondowoso.sch.id/',
        'actionLabelEn': 'Visit Official SMADA Website',
        'actionLabelId': 'Kunjungi Website Resmi SMAN 2 Bondowoso',
      },
      {
        'title': 'SMP Negeri 1 Bondowoso (SPASA)',
        'degreeEn': 'Junior High School Formal Secondary Education',
        'degreeId': 'Pendidikan Menengah Pertama Formal (SPASA)',
        'departmentEn': 'Junior High School Diploma • Accredited A',
        'departmentId': 'Pendidikan Menengah Pertama • Terakreditasi A',
        'period': '2018 - 2021',
        'badgeEn': 'Junior High School',
        'badgeId': 'Sekolah Menengah Pertama',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Graduated 2021 • 3-Year Junior Secondary Completed (100%)',
        'progressNoteId':
            'Lulus Tahun 2021 • Pendidikan Menengah Pertama 3 Tahun Selesai (100%)',
        'descEn':
            'Completed 3 years of junior secondary education at SMP Negeri 1 Bondowoso (SPASA) with distinction. Early development of computational logic, digital creative skills, and structured problem solving.',
        'descId':
            'Menyelesaikan 3 tahun pendidikan menengah pertama di SMP Negeri 1 Bondowoso (SPASA) dengan rekam jejak akademik yang baik. Mengembangkan logika komputasi awal dan pemecahan masalah terstruktur.',
        'tags': [
          'SMPN 1 Bondowoso',
          'SPASA',
          'Lulus 2021',
          'Pendidikan Menengah Pertama',
          'Fondasi IT & Sains',
          'Lulus / Completed',
        ],
        'icon': Icons.military_tech_rounded,
        'asset': 'assets/school_spasa.jpg',
        'acronym': 'SPASA',
        'actionUrl': 'http://smpn1bondowoso.sch.id/',
        'actionLabelEn': 'View SMPN 1 Bondowoso Portal',
        'actionLabelId': 'Lihat Portal SMPN 1 Bondowoso',
      },
      {
        'title': 'SD Kristen Petra Bondowoso',
        'degreeEn': 'Primary Elementary School Education',
        'degreeId': 'Pendidikan Tingkat Dasar (SD)',
        'departmentEn': 'Elementary School Diploma • Character & Foundation',
        'departmentId': 'Pendidikan Dasar Komprehensif • Karakter & Disiplin',
        'period': '2012 - 2018',
        'badgeEn': 'Elementary School',
        'badgeId': 'Sekolah Dasar',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Graduated 2018 • 6-Year Primary Education Completed (100%)',
        'progressNoteId':
            'Lulus Tahun 2018 • Pendidikan Dasar 6 Tahun Selesai (100%)',
        'descEn':
            'Completed 6-year primary school education at SDK Petra Bondowoso with comprehensive foundations in mathematics, discipline, character, and early digital literacy.',
        'descId':
            'Menyelesaikan pendidikan dasar 6 tahun di SDK Petra Bondowoso dengan fondasi komprehensif pada kemampuan matematika, pembentukan karakter, kedisiplinan, dan literasi digital dasar.',
        'tags': [
          'SDK Petra Bondowoso',
          'Pendidikan Dasar (SD)',
          'Lulus 2018',
          'Pembentukan Karakter',
          'Fondasi Matematika',
          'Lulus / Completed',
        ],
        'icon': Icons.menu_book_rounded,
        'asset': 'assets/school_sd.jpg',
        'acronym': 'PETRA',
        'actionUrl': null,
        'actionLabelEn': null,
        'actionLabelId': null,
      },
    ],
    experiences: [
      {
        'roleEn': 'Owner & Founder',
        'roleId': 'Owner & Founder',
        'company': 'RelvaStudio Innovations',
        'period': '2022 - Present',
        'badgeEn': 'Executive & Engineering',
        'badgeId': 'Kepemimpinan & Rekayasa',
        'descEn':
            'Leading product vision, technical architectures, and software engineering for Relva Studio ventures. Designing resilient Flutter web/mobile software, spatial limitation engines (RevGEO), and automated input pipelines (RevHelix).',
        'descId':
            'Memimpin visi produk, arsitektur teknis, dan rekayasa perangkat lunak Relva Studio. Merancang sistem Flutter multiplatform, API restriksi batas spasial (RevGEO), serta pipeline otomasi data (RevHelix).',
        'tags': ['Executive Leadership', 'System Architecture', 'Product Engineering', 'Flutter', 'APIs'],
      },
      {
        'roleEn': 'Chief Systems Creator',
        'roleId': 'Pencipta Utama Sistem',
        'company': 'MAPOTECH Connected Healthcare',
        'period': '2023 - Present',
        'badgeEn': 'Flagship Project',
        'badgeId': 'Proyek Unggulan',
        'descEn':
            'Spearheading the core conceptualization, UX workflows, and full-stack Flutter implementations for MAPOTECH healthcare platform, including EMR ICD-10 diagnostic indexing and clinic operations.',
        'descId':
            'Memimpin konseptualisasi inti, alur UX, dan implementasi Flutter full-stack untuk platform kesehatan MAPOTECH, termasuk modul rekam medis ICD-10 dan operasional klinik.',
        'tags': ['Healthcare IT', 'Flutter Web', 'EMR Architecture', 'ICD-10', 'Product Design'],
      },
    ],
  );

  static const CvProfileData alvin = CvProfileData(
    id: 'alvin',
    name: 'Alvin Christian',
    roleEn: 'Lead Software Engineer & UI/UX Architect | Relva Studio',
    roleId: 'Lead Software Engineer & Arsitek UI/UX | Relva Studio',
    companyBadge: 'RELVA STUDIO & RSU BONDOWOSO',
    statusEn: 'Software Engineer @ RSU Bondowoso • Relva Core',
    statusId: 'Software Engineer @ RSU Bondowoso • Core Relva',
    bioShortEn:
        'Core software engineer and UI/UX architect at Relva Studio, actively serving at RSU Bondowoso. Specializing in clinical healthcare systems, React web platforms, 2D visual assets, and high-performance data analytics.',
    bioShortId:
        'Software engineer inti dan arsitek UI/UX di Relva Studio yang saat ini bertugas di RSU Bondowoso. Berfokus pada sistem klinis rumah sakit, platform web React, aset visual 2D, dan analitik data performa tinggi.',
    bioDetailEn:
        'With extensive professional experience in healthcare engineering and production web platforms, I bridge the gap between complex hospital operations at RSU Bondowoso and cutting-edge software craft at Relva Studio. My technical domain spans robust React web interfaces, multiplatform Flutter engines, relational database architecture (PostgreSQL), data analytics pipelines, and bespoke 2D vector illustrations.',
    bioDetailId:
        'Dengan pengalaman profesional mendalam pada rekayasa teknologi kesehatan dan platform web skala produksi, saya menjembatani kompleksitas operasional medis di RSU Bondowoso dengan standar perangkat lunak terdepan di Relva Studio. Domain keahlian saya meliputi antarmuka React web, arsitektur Flutter multiplatform, permodelan database PostgreSQL, pipeline analitik data klinis, serta desain visual 2D.',
    photoAsset: 'assets/AlvinPhotoProfile.jpg',
    backgroundMedia: 'assets/AlvinCardBackGround.mp4',
    initials: 'AC',
    badgeLabel: 'CORE ARCHITECT',
    email: 'alvin@relvastudio.com',
    locationEn: 'RSU Bondowoso • Bondowoso, East Java (Hybrid)',
    locationId: 'RSU Bondowoso • Bondowoso, Jawa Timur (Hybrid)',
    githubUrl: 'https://github.com',
    linkedinUrl: 'https://linkedin.com',
    experienceYears: '5+',
    deliveredProjects: '35+',
    qualityStandard: '100%',
    techFrameworks: '15+',
    skills: [
      {
        'name': 'React.js & Modern Web Frontend Ecosystem',
        'pct': 0.90,
        'category': 1,
      },
      {
        'name': 'Flutter Multiplatform (Web, iOS, Android)',
        'pct': 0.94,
        'category': 1,
      },
      {
        'name': '2D Artist, Vector Illustration & Asset Design',
        'pct': 0.88,
        'category': 1,
      },
      {
        'name': 'UI/UX Architecture, Wireframing & Glassmorphism',
        'pct': 0.92,
        'category': 1,
      },
      {
        'name': 'Data Analytics & Clinical Metrics Processing',
        'pct': 0.85,
        'category': 2,
      },
      {
        'name': 'PostgreSQL & Enterprise Relational Modeling',
        'pct': 0.88,
        'category': 2,
      },
      {
        'name': 'Node.js, Express & Microservices REST APIs',
        'pct': 0.86,
        'category': 2,
      },
      {
        'name': 'Hospital Information Systems (SIMRS Integration)',
        'pct': 0.90,
        'category': 2,
      },
      {
        'name': 'Clean Architecture, Repository Pattern & MVVM',
        'pct': 0.94,
        'category': 3,
      },
      {
        'name': 'CI/CD Automation, Git Workflows & Docker Deployments',
        'pct': 0.88,
        'category': 3,
      },
    ],
    projects: [
      {
        'title': 'RSU Bondowoso Clinical Analytics & Data Hub',
        'subtitle':
            'Real-Time Patient Flow Analytics & Clinical Reporting System',
        'subtitleId':
            'Sistem Analitik Alur Pasien Real-Time & Pelaporan Medis Rumah Sakit',
        'badge': 'Hospital Production',
        'descEn':
            'Engineered healthcare analytics and data reporting pipelines for RSU Bondowoso. Aggregates clinical telemetry, patient admission volumes, pharmacy dispatch speeds, and doctor schedules into high-fidelity reactive dashboards.',
        'descId':
            'Mengembangkan pipeline analitik kesehatan dan pelaporan data di RSU Bondowoso. Mengagregasi data kunjungan klinis, volume penerimaan pasien, kecepatan distribusi farmasi, dan jadwal dokter ke dalam dashboard reaktif.',
        'tags': [
          'Data Analytics',
          'RSU Bondowoso',
          'PostgreSQL',
          'React',
          'Healthcare Systems',
        ],
        'icon': Icons.local_hospital_rounded,
        'actionRoute': null,
        'actionUrl': null,
        'actionLabelEn': 'Clinical Infrastructure',
        'actionLabelId': 'Infrastruktur Klinis',
      },
      {
        'title': 'MAPOTECH — Core System Engineering & UI Modules',
        'subtitle':
            'High-Performance Medical Platform & Operational Architecture',
        'subtitleId':
            'Arsitektur Operasional & Modul UI Medis Performa Tinggi',
        'badge': 'Flagship Platform',
        'descEn':
            'Core contributor to MAPOTECH healthcare suite. Designed responsive layouts, 2D iconography, EMR doctor consultation workflows, and clinical cashier ledger architectures with native Flutter rendering.',
        'descId':
            'Kontributor inti platform kesehatan MAPOTECH. Merancang tata letak responsif, ikonografi 2D, alur konsultasi EMR dokter, serta arsitektur kasir klinis dengan rendering native Flutter.',
        'tags': [
          'Flutter Web',
          'MAPOTECH',
          '2D Vector Art',
          'Clean Architecture',
          'Zero-UI-Lib',
        ],
        'icon': Icons.medical_services_rounded,
        'actionRoute': '/mapotech',
        'actionUrl': null,
        'actionLabelEn': 'Explore MAPOTECH →',
        'actionLabelId': 'Jelajahi MAPOTECH →',
      },
      {
        'title': 'React Clinical Monitoring Dashboard',
        'subtitle': 'High-Throughput Responsive Dashboard for Vital Metrics',
        'subtitleId': 'Dashboard Monitoring Vital Medis Berkecepatan Tinggi',
        'badge': 'React Web Application',
        'descEn':
            'Modern single-page application built with React, TypeScript, and WebSocket streams for real-time patient bed monitoring, lab report visualization, and rapid emergency triage alerts.',
        'descId':
            'Aplikasi web modern berbasis React, TypeScript, dan WebSocket stream untuk pemantauan ranjang pasien secara real-time, visualisasi hasil laboratorium, serta peringatan triase cepat darurat.',
        'tags': [
          'React.js',
          'TypeScript',
          'Data Analytics',
          'WebSockets',
          'REST APIs',
        ],
        'icon': Icons.monitor_heart_rounded,
        'actionRoute': null,
        'actionUrl': null,
        'actionLabelEn': 'React Architecture',
        'actionLabelId': 'Arsitektur React',
      },
    ],
    educations: [
      {
        'title': 'Politeknik Negeri Jember (Polije)',
        'degreeEn':
            'Bachelor of Applied Science (D4) in Informatics Engineering (Prodi TIF)',
        'degreeId': 'Sarjana Terapan (D4) Teknik Informatika (Prodi TIF)',
        'departmentEn': 'Department of Information Technology (TI)',
        'departmentId': 'Jurusan Teknologi Informasi (TI)',
        'period': '2018 - 2024',
        'badgeEn': 'Higher Education',
        'badgeId': 'Pendidikan Tinggi',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Class of 2018 • Graduated 2024 with Honors • Applied Thesis Completed',
        'progressNoteId':
            'Angkatan 2018 • Lulus Tahun 2024 • Tugas Akhir Terapan Selesai (100%)',
        'descEn':
            'Enrolled in 2018 and graduated in 2024 with a Bachelor of Applied Science (D4) in Informatics Engineering. Specialized in healthcare software architecture, relational databases, web frameworks, and clinical informatics systems.',
        'descId':
            'Menempuh studi angkatan 2018 dan lulus pada tahun 2024 meraih gelar Sarjana Terapan (D4) Teknik Informatika. Spesialisasi pada arsitektur perangkat lunak kesehatan, basis data relasional, framework web, dan informatika klinis.',
        'tags': [
          'Teknik Informatika (Prodi TIF)',
          'Jurusan TI',
          'Polije Jember',
          'Angkatan 2018 - Lulus 2024',
          'Lulus / Completed',
        ],
        'icon': Icons.school_rounded,
        'asset': 'assets/school_polije.png',
        'acronym': 'POLIJE',
        'actionUrl': 'https://polije.ac.id/',
        'actionLabelEn': 'Visit Official Polije Website',
        'actionLabelId': 'Kunjungi Website Resmi Polije',
      },
      {
        'title': 'SMA Negeri 2 Bondowoso (SMADA)',
        'degreeEn': 'Natural Sciences & Mathematics (MIPA)',
        'degreeId': 'Peminatan Matematika & Ilmu Pengetahuan Alam (MIPA)',
        'departmentEn': 'Senior High School Diploma • Accredited A',
        'departmentId': 'Pendidikan Menengah Atas • Terakreditasi A',
        'period': '2015 - 2018',
        'badgeEn': 'Senior High School',
        'badgeId': 'Sekolah Menengah Atas',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Graduated 2018 • 3-Year MIPA Curriculum Completed (100%)',
        'progressNoteId':
            'Lulus Tahun 2018 • Kurikulum 3 Tahun MIPA Selesai (100%)',
        'descEn':
            'Graduated in 2018 with academic distinction in Natural Sciences and Mathematics (MIPA). Active participant in computer club, physics competitions, and web development foundational projects.',
        'descId':
            'Lulus pada tahun 2018 di peminatan MIPA (3 tahun) dengan capaian akademik unggul. Berpartisipasi aktif dalam ekstrakurikuler komputer, kompetisi sains, dan proyek dasar pengembangan web.',
        'tags': [
          'SMAN 2 Bondowoso',
          'SMADA',
          'Peminatan MIPA',
          'Lulus 2018',
          'Lulus / Completed',
        ],
        'icon': Icons.account_balance_rounded,
        'asset': 'assets/school_smada.jpg',
        'acronym': 'SMADA',
        'actionUrl': 'https://sman2bondowoso.sch.id/',
        'actionLabelEn': 'Visit Official SMADA Website',
        'actionLabelId': 'Kunjungi Website Resmi SMAN 2 Bondowoso',
      },
      {
        'title': 'SMP Negeri 1 Bondowoso (SPASA)',
        'degreeEn': 'Junior High School Formal Secondary Education',
        'degreeId': 'Pendidikan Menengah Pertama Formal (SPASA)',
        'departmentEn': 'Junior High School Diploma • Accredited A',
        'departmentId': 'Pendidikan Menengah Pertama • Terakreditasi A',
        'period': '2012 - 2015',
        'badgeEn': 'Junior High School',
        'badgeId': 'Sekolah Menengah Pertama',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Graduated 2015 • 3-Year Junior Secondary Completed (100%)',
        'progressNoteId':
            'Lulus Tahun 2015 • Pendidikan Menengah Pertama 3 Tahun Selesai (100%)',
        'descEn':
            'Completed 3 years of junior secondary schooling at SMP Negeri 1 Bondowoso (SPASA). Developed strong aptitude in mathematics, logic, and early digital design.',
        'descId':
            'Menyelesaikan 3 tahun pendidikan menengah pertama di SMP Negeri 1 Bondowoso (SPASA). Mengembangkan minat mendalam pada matematika, logika, dan desain digital awal.',
        'tags': [
          'SMPN 1 Bondowoso',
          'SPASA',
          'Lulus 2015',
          'Pendidikan Menengah Pertama',
          'Lulus / Completed',
        ],
        'icon': Icons.military_tech_rounded,
        'asset': 'assets/school_spasa.jpg',
        'acronym': 'SPASA',
        'actionUrl': 'http://smpn1bondowoso.sch.id/',
        'actionLabelEn': 'View SMPN 1 Bondowoso Portal',
        'actionLabelId': 'Lihat Portal SMPN 1 Bondowoso',
      },
      {
        'title': 'SD Kristen Petra Bondowoso',
        'degreeEn': 'Primary Elementary School Education',
        'degreeId': 'Pendidikan Tingkat Dasar (SD)',
        'departmentEn': 'Elementary School Diploma • Character & Foundation',
        'departmentId': 'Pendidikan Dasar Komprehensif • Karakter & Disiplin',
        'period': '2006 - 2012',
        'badgeEn': 'Elementary School',
        'badgeId': 'Sekolah Dasar',
        'isOngoing': false,
        'progress': 1.0,
        'progressNoteEn':
            'Graduated 2012 • 6-Year Primary Education Completed (100%)',
        'progressNoteId':
            'Lulus Tahun 2012 • Pendidikan Dasar 6 Tahun Selesai (100%)',
        'descEn':
            'Completed foundational primary education spanning 6 years at SDK Petra Bondowoso. Fostered strong character, collaborative teamwork, and early analytical thinking.',
        'descId':
            'Menyelesaikan pendidikan dasar 6 tahun di SDK Petra Bondowoso. Menanamkan karakter kuat, kerja sama tim, serta pemikiran analitis sejak dini.',
        'tags': [
          'SDK Petra Bondowoso',
          'Pendidikan Dasar (SD)',
          'Lulus 2012',
          'Pembentukan Karakter',
          'Lulus / Completed',
        ],
        'icon': Icons.menu_book_rounded,
        'asset': 'assets/school_sd.jpg',
        'acronym': 'PETRA',
        'actionUrl': null,
        'actionLabelEn': null,
        'actionLabelId': null,
      },
    ],
    experiences: [
      {
        'roleEn': 'Software Engineer & Clinical Systems',
        'roleId': 'Software Engineer & Sistem Klinis',
        'company': 'RSU Bondowoso',
        'period': '2024 - Present',
        'badgeEn': 'Healthcare Production',
        'badgeId': 'Produksi Layanan Medis',
        'descEn':
            'Serving as Software Engineer at RSU Bondowoso. Maintaining and modernizing electronic medical records, clinical analytics pipelines, digital patient workflows, and hospital data integrity.',
        'descId':
            'Bertugas sebagai Software Engineer di RSU Bondowoso. Mengelola dan memodernisasi rekam medis elektronik, pipeline analitik klinis, alur data pasien, serta keandalan sistem rumah sakit.',
        'tags': ['RSU Bondowoso', 'Clinical Systems', 'Data Analytics', 'PostgreSQL', 'SIMRS'],
      },
      {
        'roleEn': 'Lead Software Engineer & UI/UX Architect',
        'roleId': 'Lead Software Engineer & Arsitek UI/UX',
        'company': 'Relva Studio',
        'period': '2022 - Present',
        'badgeEn': 'Core Engineering',
        'badgeId': 'Rekayasa Inti',
        'descEn':
            'Co-architecting high-performance web systems, custom UI frameworks, and digital healthcare platforms with zero third-party UI library bloat. Authoring 2D visual assets and React web portals.',
        'descId':
            'Merancang bersama arsitektur sistem web performa tinggi, framework antarmuka kustom, dan platform kesehatan digital. Merancang aset visual 2D dan portal web React modern.',
        'tags': ['React.js', 'Flutter Web', '2D Vector Art', 'Clean Architecture', 'UI/UX'],
      },
      {
        'roleEn': 'Full-Stack Developer & Analyst',
        'roleId': 'Full-Stack Developer & Analis',
        'company': 'Tech Innovation Labs',
        'period': '2020 - 2022',
        'badgeEn': 'Systems Development',
        'badgeId': 'Pengembangan Sistem',
        'descEn':
            'Developed reactive web dashboards, REST API backends, and data visualization tools for multiplatform clients.',
        'descId':
            'Mengembangkan dashboard web reaktif, backend REST API, dan modul visualisasi data interaktif untuk berbagai klien multiplatform.',
        'tags': ['React', 'Node.js', 'PostgreSQL', 'Data Visualization', 'REST'],
      },
    ],
  );

  static const List<CvProfileData> allProfiles = [alfon, alvin];

  static CvProfileData getProfile(String? id) {
    if (id == null || id.isEmpty) return alfon;
    final match = allProfiles.firstWhere(
      (p) => p.id.toLowerCase() == id.toLowerCase(),
      orElse: () => alfon,
    );
    return match;
  }
}


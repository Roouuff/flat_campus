import 'package:flutter/material.dart';

void main() {
  runApp(const ECampusApp());
}

class ECampusApp extends StatelessWidget {
  const ECampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eCampus',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF26735F)),
        scaffoldBackgroundColor: const Color(0xFFF6F4EC),
      ),
      home: const CampusHome(),
    );
  }
}

class CampusHome extends StatefulWidget {
  const CampusHome({super.key});

  @override
  State<CampusHome> createState() => _CampusHomeState();
}

class _CampusHomeState extends State<CampusHome> {
  static const String profilePhotoAsset = 'assets/profile_photo.png';
  static const Color _forest = Color(0xFF26735F);
  static const Color _forestDark = Color(0xFF174C42);
  static const Color _canvas = Color(0xFFF6F4EC);
  static const Color _saffron = Color(0xFFE6A943);

  int selectedIndex = 0;
  String selectedDay = 'Semua';
  bool isDarkMode = false;

  final String studentName = 'Muhammad Abdul Rouf';
  final String studentNim = '2495114015';
  final String studyProgram = 'Teknik Informatika';

  final List<Map<String, String>> schedules = [
    {
      'day': 'Senin',
      'time': '08.00 - 10.30',
      'course': 'Teori Graf dan Otomata',
      'room': 'Lab Komputer',
      'code': '1124A',
      'teacher': 'ANITA ANDRIANI',
      'attendance': '7 dari 16 sesi',
    },
    {
      'day': 'Selasa',
      'time': '13.00 - 14.40',
      'course': 'Data Mining',
      'room': 'Belum tersedia',
      'code': '1124A',
      'teacher': 'INDANA LAZULFA',
      'attendance': '8 dari 16 sesi',
    },
    {
      'day': 'Selasa',
      'time': '08.00 - 10.30',
      'course': 'Mobile Programming',
      'room': 'Ruang 202',
      'code': '1124A',
      'teacher': 'EDWIN HARI AGUS PRASTYO dan 1 lainnya',
      'attendance': '8 dari 16 sesi',
    },
    {
      'day': 'Rabu',
      'time': '08.00 - 10.30',
      'course': 'Game Development Techniques',
      'room': 'Belum tersedia',
      'code': '1124A',
      'teacher': 'TANHELLA ZEIN VITADIAR dan 1 lainnya',
      'attendance': '7 dari 16 sesi',
    },
    {
      'day': 'Senin',
      'time': '08.00 - 10.00',
      'course': 'Pemrograman Web Lanjut',
      'room': 'Lab Komputer',
      'code': '1124A',
      'teacher': 'Belum tersedia',
      'attendance': 'Belum tersedia',
    },
  ];

  final List<Map<String, dynamic>> grades = [
    {'course': 'Data Mining', 'score': 88, 'grade': 'A'},
    {'course': 'Game Development Techniques', 'score': 82, 'grade': 'A'},
    {'course': 'Mobile Programming', 'score': 85, 'grade': 'A'},
    {'course': 'Teori Graf dan Otomata', 'score': 85, 'grade': 'A'},
    {'course': 'Pemrograman Web Lanjut', 'score': 80, 'grade': 'A'},
  ];

  // State presensi untuk setiap mata kuliah.
  final Map<String, bool> attendance = {};

  @override
  void initState() {
    super.initState();
    _initializeAttendance();
  }

  void _initializeAttendance() {
    for (final schedule in schedules) {
      final course = schedule['course']!;
      final attendanceText = schedule['attendance'] ?? '';
      final match = RegExp(r'(\d+)\s+dari\s+\d+\s+sesi')
          .firstMatch(attendanceText);

      if (match != null) {
        attendance[course] = int.parse(match.group(1)!) > 0;
      } else {
        attendance[course] = false;
      }
    }
  }

  final List<String> menuItems = [
    'Dashboard',
    'Jadwal Kuliah',
    'Presensi',
    'Nilai Akademik',
    'Profil Mahasiswa',
  ];

  final List<IconData> menuIcons = [
    Icons.dashboard_rounded,
    Icons.calendar_month_rounded,
    Icons.fact_check_rounded,
    Icons.school_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _forest,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        scaffoldBackgroundColor: isDarkMode ? const Color(0xFF111B18) : _canvas,
        cardTheme: CardThemeData(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: isDarkMode
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFE9E5D9),
            ),
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;

          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  if (isWide) _buildSidebar(),
                  Expanded(
                    child: Column(
                      children: [
                        _buildHeader(isWide),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: _buildPage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: isWide
                ? null
                : NavigationBar(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() => selectedIndex = index);
                    },
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: 'Beranda',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.calendar_month),
                        label: 'Jadwal',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.fact_check),
                        label: 'Presensi',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.school),
                        label: 'Nilai',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.person),
                        label: 'Profil',
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 245,
      color: _forestDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(Icons.school_rounded, color: Colors.white, size: 34),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'E-CAMPUS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'MENU UTAMA',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < menuItems.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: ListTile(
                selected: selectedIndex == i,
                selectedTileColor: Colors.white.withValues(alpha: 0.14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(menuIcons[i], color: Colors.white),
                title: Text(
                  menuItems[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: selectedIndex == i
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
                onTap: () {
                  setState(() => selectedIndex = i);
                },
              ),
            ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Sistem Informasi Akademik\nUniversitas Hasyim Asy\'ari',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isWide) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              menuItems[selectedIndex],
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: () {
              setState(() => isDarkMode = !isDarkMode);
            },
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          if (isWide) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: const AssetImage(profilePhotoAsset),
              backgroundColor: const Color(0xFFDBEAFE),
            ),
            const SizedBox(width: 10),
            Flexible(child: Text(studentName, overflow: TextOverflow.ellipsis)),
          ],
        ],
      ),
    );
  }

  Widget _buildPage() {
    switch (selectedIndex) {
      case 1:
        return _buildSchedulePage();
      case 2:
        return _buildAttendancePage();
      case 3:
        return _buildGradesPage();
      case 4:
        return _buildProfilePage();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    final presentCount = attendance.values.where((present) => present).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_forestDark, _forest],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, $studentName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pantau aktivitas akademikmu dalam satu tempat.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.82),
                      ),
                    ),
                    const SizedBox(height: 18),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: _saffron,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Text(
                          'SEMESTER AKTIF',
                          style: TextStyle(
                            color: _forestDark,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white.withValues(alpha: 0.14),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final count = constraints.maxWidth > 650 ? 3 : 1;
            final cardWidth = (constraints.maxWidth - (count - 1) * 16) / count;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _statCard(
                  'Mata Kuliah',
                  '${schedules.map((s) => s['course']).toSet().length}',
                  Icons.menu_book,
                  _forest,
                  cardWidth,
                ),
                _statCard(
                  'Presensi Hadir',
                  '$presentCount',
                  Icons.fact_check,
                  _saffron,
                  cardWidth,
                ),
                _statCard(
                  'Data Nilai',
                  '${grades.length} mata kuliah',
                  Icons.grade,
                  const Color(0xFF8C6A9E),
                  cardWidth,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        const Text(
          'Jadwal Perkuliahan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...schedules
            .take(3)
            .map(
              (schedule) => Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.book_outlined)),
                  title: Text(schedule['course']!),
                  subtitle: Text('${schedule['day']} • ${schedule['time']}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    setState(() => selectedIndex = 1);
                  },
                ),
              ),
            ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () {
            setState(() => selectedIndex = 2);
          },
          icon: const Icon(Icons.fact_check),
          label: const Text('Buka Presensi'),
        ),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.14),
                child: Icon(icon, color: color, size: 25),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchedulePage() {
    final filteredSchedules = selectedDay == 'Semua'
        ? schedules
        : schedules
              .where((schedule) => schedule['day'] == selectedDay)
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jadwal Kuliah Mingguan',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: selectedDay,
          decoration: const InputDecoration(
            labelText: 'Filter hari',
            border: OutlineInputBorder(),
          ),
          items: ['Semua', 'Senin', 'Selasa', 'Rabu', 'Kamis']
              .map((day) => DropdownMenuItem(value: day, child: Text(day)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedDay = value);
            }
          },
        ),
        const SizedBox(height: 16),
        Text('Jumlah jadwal: ${filteredSchedules.length}'),
        const SizedBox(height: 8),
        ...filteredSchedules.map(
          (schedule) => Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month, color: _forest),
              title: Text('${schedule['course']} (${schedule['code']})'),
              subtitle: Text(
                '$studyProgram\n'
                'Jenis kelas tidak tersedia\n'
                '${schedule['teacher']}\n'
                '${schedule['day']}, ${schedule['time']}\n'
                '${schedule['room']}\n'
                'Kehadiran: ${schedule['attendance']}',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendancePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Presensi Perkuliahan',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Tekan tombol untuk mengubah status presensi simulasi.'),
        const SizedBox(height: 16),
        ...schedules.map((schedule) {
          final course = schedule['course']!;
          final isPresent = attendance[course] ?? false;

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$course (${schedule['code']})',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('$studyProgram • ${schedule['teacher']}'),
                  const SizedBox(height: 6),
                  Text('${schedule['day']} • ${schedule['time']}'),
                  const SizedBox(height: 6),
                  Text('Kehadiran: ${schedule['attendance']}'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          isPresent ? 'Status: Hadir' : 'Status: Belum Hadir',
                          style: TextStyle(
                            color: isPresent ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            attendance[course] = !isPresent;
                          });
                        },
                        child: Text(isPresent ? 'Batalkan' : 'Hadir'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGradesPage() {
    final average =
        grades.fold<int>(0, (sum, item) => sum + (item['score'] as int)) /
        grades.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nilai Akademik',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.analytics, color: _forest, size: 35),
            title: const Text('Rata-rata nilai simulasi'),
            subtitle: Text(average.toStringAsFixed(1)),
          ),
        ),
        const SizedBox(height: 12),
        ...grades.map(
          (item) => Card(
            child: ListTile(
              leading: const Icon(Icons.school),
              title: Text('${item['course']} (1124A)'),
              subtitle: Text('Nilai: ${item['score']}'),
              trailing: Chip(label: Text(item['grade'] as String)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Catatan: data nilai di atas adalah data contoh, '
          'bukan nilai resmi mahasiswa.',
        ),
      ],
    );
  }

  Widget _buildProfilePage() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage(profilePhotoAsset),
        ),
        const SizedBox(height: 16),
        Text(
          studentName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Card(
          child: Column(
            children: [
              _profileTile('NIM', studentNim, Icons.badge),
              const Divider(height: 1),
              _profileTile('Program Studi', studyProgram, Icons.menu_book),
              const Divider(height: 1),
              _profileTile(
                'Fakultas',
                'Fakultas Teknologi Informasi',
                Icons.account_balance,
              ),
              const Divider(height: 1),
              _profileTile(
                'Universitas',
                'Universitas Hasyim Asy\'ari',
                Icons.school,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () {
            setState(() => selectedIndex = 0);
          },
          icon: const Icon(Icons.home),
          label: const Text('Kembali ke Dashboard'),
        ),
      ],
    );
  }

  Widget _profileTile(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label, style: const TextStyle(fontSize: 12)),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

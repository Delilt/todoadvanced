# ToDo Advanced Flutter Uygulaması

Bu doküman, "ToDo Advanced" adlı Flutter uygulamasının geliştirme sürecini, mimarisini, kullanılan teknolojileri ve bileşenlerini detaylı bir şekilde açıklamaktadır.

## 1. Proje Genel Bakış

"ToDo Advanced", kullanıcıların görevlerini kategorilere ayırarak yönetmelerini sağlayan, modern ve kullanıcı dostu bir mobil uygulamadır. Herhangi bir kullanıcı girişi gerektirmeden, tüm verileri cihazın yerel depolama alanında saklar.

### Temel Özellikler

- **Splash Screen:** Uygulama başlarken bir yüklenme ekranı gösterir.
- **Kategori Yönetimi:** Kullanıcılar mevcut kategorilerdeki görevleri yönetebilir ve yeni kategoriler oluşturabilir.
- **Görev Yönetimi:** Her kategoriye özel görevler eklenebilir.
- **Görev Durumu:** Görevler "beklemede" veya "tamamlandı" olarak işaretlenebilir.
- **Filtreleme:** Görevler tamamlanma durumlarına göre ayrı ekranlarda listelenir.
- **Yerel Depolama:** Tüm veriler, Hive veritabanı kullanılarak cihazda saklanır.
- **Modern Arayüz:** Animasyonlu ve şık bir alt navigasyon menüsü içerir.

## 2. Mimari ve Teknoloji

### Mimari Yaklaşım: MVVM (Model-View-ViewModel)

Uygulama, kodun okunabilirliğini, sürdürülebilirliğini ve test edilebilirliğini artırmak amacıyla **MVVM (Model-View-ViewModel)** mimari deseni kullanılarak geliştirilmiştir.

- **Model:** Uygulamanın veri yapısını ve iş mantığını temsil eder. (`Category`, `Task` modelleri ve `DatabaseService`).
- **View:** Kullanıcı arayüzünü (UI) temsil eder. Kullanıcı etkileşimlerini ViewModel'e iletir ve ViewModel'den gelen verileri gösterir. (örn: `HomeScreen`, `TaskListScreen`).
- **ViewModel:** View için veri ve komutları hazırlar. View'dan gelen isteklere yanıt verir ve Model ile etkileşime girer. (`HomeViewModel`, `TaskViewModel`).

### Kullanılan Teknolojiler ve Paketler

- **State Management:** `provider` - View ve ViewModel arasındaki bağlantıyı kurmak ve uygulama durumunu verimli bir şekilde yönetmek için kullanılmıştır.
- **Database:** `hive` / `hive_flutter` - Hızlı ve hafif bir NoSQL anahtar-değer veritabanıdır. Tüm kategori ve görev verilerini yerel olarak saklamak için tercih edilmiştir.
- **Path Provider:** `path_provider` - Hive veritabanının saklanacağı dosya sistemi yolunu bulmak için kullanılır.
- **UUID:** `uuid` - Her kategori ve görev için benzersiz kimlikler (ID) oluşturmak için kullanılmıştır.
- **Code Generation:** `hive_generator` ve `build_runner` - Hive'ın özel veri modellerini (TypeAdapter) otomatik olarak oluşturması için kullanılır.

## 3. Kod Yapısı ve Bileşenler

Proje, özelliklere göre modüler bir klasör yapısı izler.

```
lib/
├── data/
│   ├── models/
│   │   ├── category_model.dart       # Kategori veri modeli
│   │   └── task_model.dart           # Görev veri modeli
│   └── services/
│       └── database_service.dart     # Hive veritabanı işlemleri
├── features/
│   ├── home/
│   │   ├── screens/
│   │   │   └── home_screen.dart      # Kategorileri listeleyen anasayfa
│   │   ├── viewmodels/
│   │   │   └── home_viewmodel.dart   # Anasayfa'nın state yönetimi
│   │   └── widgets/
│   │       ├── add_category_dialog.dart # Yeni kategori ekleme diyalogu
│   │       └── category_card.dart    # Kategori kartı widget'ı
│   ├── splash/
│   │   └── screens/
│   │       └── splash_screen.dart    # Başlangıç ekranı
│   ├── tasks/
│   │   ├── screens/
│   │   │   ├── add_task_screen.dart       # Yeni görev ekleme ekranı
│   │   │   ├── completed_tasks_screen.dart # Tamamlanmış görevler ekranı
│   │   │   ├── pending_tasks_screen.dart   # Bekleyen görevler ekranı
│   │   │   └── task_list_screen.dart       # Bir kategoriye ait görevleri listeleme
│   │   ├── viewmodels/
│   │   │   └── task_viewmodel.dart   # Görevlerin state yönetimi
│   │   └── widgets/
│   │       └── task_list_item.dart   # Görev listesi elemanı (animasyonlu buton ile)
├── navigation/
│   └── main_screen.dart              # Alt navigasyon barını ve ana ekranları yönetir
└── main.dart                         # Uygulamanın başlangıç noktası
```

### Detaylı Bileşen Açıklamaları

#### `main.dart`
- Uygulamanın ana giriş noktasıdır.
- `WidgetsFlutterBinding.ensureInitialized()` ile Flutter binding'lerini başlatır.
- `Hive` veritabanını başlatır, `TypeAdapter`'ları kaydeder ve `Box`'ları açar.
- `MultiProvider` ile `HomeViewModel` ve `TaskViewModel`'i tüm uygulama ağacına sağlar.
- `MaterialApp`'i yapılandırır ve başlangıç ekranı olarak `SplashScreen`'i ayarlar.

#### Veri Katmanı (`data`)
- **`category_model.dart` & `task_model.dart`:** Hive ile uyumlu, `@HiveType` ve `@HiveField` annotasyonları içeren veri sınıflarıdır. `id` alanları `uuid` paketi ile otomatik olarak oluşturulur.
- **`database_service.dart`:** Hive veritabanı ile olan tüm etkileşimleri merkezileştiren bir servis sınıfıdır. Kategori ve görevler için CRUD (Create, Read, Update, Delete) operasyonlarını içerir. Bu, ViewModel'lerin doğrudan Hive API'si ile konuşmasını engeller ve soyutlama sağlar.

#### Özellikler Katmanı (`features`)

- **`splash_screen.dart`:** Uygulama açıldığında 2.5 saniye boyunca bir logo ve yüklenme animasyonu gösterir, ardından `MainScreen`'e yönlendirir.
- **`home_screen.dart`:**
  - `HomeViewModel`'den aldığı kategorileri bir `GridView` içinde `CategoryCard` widget'ları ile gösterir.
  - "Yeni Kategori Ekle" butonu ile `add_category_dialog`'u tetikler.
- **`home_viewmodel.dart`:**
  - `DatabaseService` aracılığıyla kategorileri yükler ve yönetir.
  - Uygulama ilk açıldığında varsayılan kategorileri ekler.
  - `notifyListeners()` ile UI'ın güncellenmesini sağlar.
- **`category_card.dart`:**
  - Her bir kategoriyi temsil eden karttır.
  - Tıklandığında o kategoriye ait görevlerin listelendiği `TaskListScreen`'e yönlendirir.
  - İçindeki '+' butonu ile o kategoriye yeni bir görev eklemek için `AddTaskScreen`'i açar.
- **`task_list_screen.dart`:** Belirli bir kategoriye ait görevleri listeler.
- **`add_task_screen.dart`:** Yeni bir görev oluşturmak için bir form içerir ve sonucu `TaskViewModel`'e iletir.
- **`pending_tasks_screen.dart` & `completed_tasks_screen.dart`:**
  - `TaskViewModel`'den sırasıyla `pendingTasks` ve `completedTasks` listelerini alarak `TaskListItem` widget'ları ile gösterirler.
- **`task_viewmodel.dart`:**
  - Tüm görevleri `DatabaseService` üzerinden yönetir.
  - Görevlerin tamamlanma durumunu değiştiren (`toggleTaskCompletion`) metodu içerir.
  - UI'ın farklı ekranlarda (bekleyen, tamamlanmış) doğru veriyi göstermesi için filtrelenmiş görev listeleri sağlar.
- **`task_list_item.dart`:**
  - Her bir görevi temsil eden liste elemanıdır.
  - Görevin tamamlanma durumuna göre arkaplan rengini ve metin stilini `AnimatedContainer` ile yumuşak bir geçişle değiştirir.
  - **`WaterDropButton`**: Görev tamamlama butonu.
    - `isCompleted` durumuna göre yeşil (`✓`) veya kırmızı (`X`) renk alır.
    - Tıklandığında küçük bir ölçeklenme animasyonu (`ScaleTransition`) çalıştırarak kullanıcıya geri bildirimde bulunur.

#### Navigasyon (`navigation`)
- **`main_screen.dart`:**
  - Uygulamanın ana iskeletidir.
  - `BottomAppBar` ve `FloatingActionButton` kullanarak modern ve animasyonlu bir alt navigasyon menüsü oluşturur.
  - Ortadaki "Anasayfa" butonu, diğerlerinden daha belirgin olan bir `FloatingActionButton`'dur.
  - Seçili sekmeye göre ilgili ekranı (`HomeScreen`, `PendingTasksScreen`, `CompletedTasksScreen`) gövdede gösterir.

## 4. Geliştirme Süreci

1. **Proje Kurulumu:** Boş bir Flutter projesi oluşturuldu.
2. **Klasör Yapısı:** MVVM mimarisine uygun olarak `data`, `features`, `navigation` gibi ana dizinler ve alt dizinler oluşturuldu.
3. **Paketlerin Eklenmesi:** `provider`, `hive`, `uuid` gibi temel bağımlılıklar `pubspec.yaml` dosyasına eklendi.
4. **Veri Modelleri:** `Category` ve `Task` modelleri Hive annotasyonları ile oluşturuldu ve `build_runner` ile `TypeAdapter`'lar generate edildi.
5. **Hive Kurulumu:** `main.dart` içinde Hive başlatıldı, adaptörler kaydedildi ve box'lar açıldı.
6. **Temel UI İskeleti:** `SplashScreen` ve `MainScreen` (içinde `BottomAppBar` ile) oluşturuldu.
7. **ViewModel ve Servislerin Geliştirilmesi:** `DatabaseService`, `HomeViewModel` ve `TaskViewModel` yazılarak iş mantığı ve veri akışı sağlandı.
8. **Ekranların Geliştirilmesi:** Her bir ekran, ilgili ViewModel'den veri alacak ve kullanıcı etkileşimlerini ViewModel'e iletecek şekilde `Provider` ile geliştirildi.
9. **Widget'ların Oluşturulması:** `CategoryCard`, `TaskListItem`, `WaterDropButton` gibi tekrar kullanılabilir UI bileşenleri oluşturuldu.
10. **Son Rötuşlar ve Dokümantasyon:** Animasyonlar eklendi, UI detayları iyileştirildi ve bu doküman hazırlandı.

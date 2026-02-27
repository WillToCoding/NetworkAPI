# NetworkAPI

<p align="center">
  <img src="https://img.shields.io/badge/📡-Network-007AFF?style=for-the-badge&labelColor=1a1a1a" alt="NetworkAPI" width="120">
</p>

<h3 align="center">Lightweight async/await networking layer for Apple platforms</h3>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-6.0-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  <img src="https://img.shields.io/badge/SPM-Compatible-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SPM">
  <img src="https://img.shields.io/badge/Platforms-5-9B59B6?style=for-the-badge&logo=apple&logoColor=white" alt="Platforms">
  <img src="https://img.shields.io/badge/License-MIT-2ECC71?style=for-the-badge" alt="License">
</p>

<p align="center">
  <i>Zero dependencies · Protocol-oriented · Type-safe</i>
</p>

---

<img src="https://img.shields.io/badge/FEATURES-2ECC71?style=for-the-badge" alt="Features">

| | Feature | Description |
|:--:|---------|-------------|
| ⚡ | **Async/Await** | Modern Swift concurrency, no callbacks |
| 🔒 | **Type-Safe** | Generic JSON decoding with Codable |
| 🖼️ | **Image Caching** | In-memory cache with disk persistence |
| 🛡️ | **Error Handling** | Comprehensive NetworkError enum |
| 📦 | **Zero Dependencies** | 100% Apple frameworks |

---

<img src="https://img.shields.io/badge/📂_LIBRARY_STRUCTURE-95A5A6?style=for-the-badge" alt="Structure">

```
Sources/NetworkAPI/
├── NetworkInteractor.swift    # Main protocol with getJSON/postJSON
├── URLRequest.swift           # Request builders (.get, .post)
├── URLSession.swift           # getData extension with typed errors
├── NetworkError.swift         # Error enum with LocalizedError
├── ImageDownloader.swift      # Actor-based image cache (iOS/tvOS/watchOS/visionOS)
└── Extensions/
    └── UIImage.swift          # Resize helper for all platforms
```

---

<img src="https://img.shields.io/badge/🔌_NetworkInteractor.swift-3498DB?style=for-the-badge" alt="NetworkInteractor">

**Protocolo principal** — Conforma cualquier repositorio a este protocolo para obtener los métodos de red.

| Method | Description |
|--------|-------------|
| `getJSON(_:type:)` | GET request → Decodes JSON to `Codable` type |
| `postJSON(_:status:)` | POST/PUT/DELETE → Validates expected HTTP status |

---

<img src="https://img.shields.io/badge/📤_URLRequest.swift-9B59B6?style=for-the-badge" alt="URLRequest">

**Request builders** — Métodos estáticos para crear peticiones con headers JSON preconfigurados.

| Method | Description |
|--------|-------------|
| `.get(url:)` | Creates GET request with JSON headers, 60s timeout |
| `.post(url:body:method:)` | Creates POST/PUT/PATCH/DELETE with Codable body |

---

<img src="https://img.shields.io/badge/🌐_URLSession.swift-E67E22?style=for-the-badge" alt="URLSession">

**Extension de URLSession** — Wrapper tipado que devuelve `(Data, HTTPURLResponse)` o lanza `NetworkError`.

| Method | Description |
|--------|-------------|
| `getData(for:)` | Executes request, validates HTTPURLResponse, throws typed errors |

---

<img src="https://img.shields.io/badge/⚠️_NetworkError.swift-E74C3C?style=for-the-badge" alt="NetworkError">

**Enum de errores** — Implementa `LocalizedError` con descripciones legibles.

| Case | When |
|------|------|
| `.general(Error)` | URLSession or system errors |
| `.status(Int)` | HTTP status doesn't match expected |
| `.json(Error)` | JSON decoding failed |
| `.dataNotValid` | Response data is nil or invalid |
| `.nonHTTP` | Response is not HTTPURLResponse |

---

<img src="https://img.shields.io/badge/🖼️_ImageDownloader.swift-1ABC9C?style=for-the-badge" alt="ImageDownloader">

**Actor para descarga de imágenes** — Cache en memoria con persistencia a disco. Disponible en iOS, tvOS, watchOS y visionOS.

| Method | Description |
|--------|-------------|
| `image(for:)` | Downloads image, caches in memory, persists to disk |
| `saveImage(url:)` | Saves cached image to disk (resized to 300px width) |
| `getFileURL(url:)` | Returns local cache file URL (nonisolated) |

---

<img src="https://img.shields.io/badge/🔧_UIImage.swift-FF2D55?style=for-the-badge" alt="UIImage">

**Extension de resize** — Redimensiona imágenes de forma asíncrona según la plataforma.

| Platform | Implementation |
|----------|---------------|
| **iOS / visionOS** | `byPreparingThumbnail(ofSize:)` |
| **tvOS** | `UIGraphicsImageRenderer` |
| **watchOS** | Returns original (no resize) |
| **macOS** | `CGContext` with high quality interpolation |

---

<img src="https://img.shields.io/badge/PLATFORMS-9B59B6?style=for-the-badge" alt="Platforms">

| Platform | Version |
|:--------:|:-------:|
| iOS | 26+ |
| macOS | 15+ |
| watchOS | 26+ |
| tvOS | 26+ |
| visionOS | 26+ |

---

<img src="https://img.shields.io/badge/INSTALLATION-007AFF?style=for-the-badge" alt="Installation">

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/WillToCoding/NetworkAPI.git", from: "1.0.0")
]
```

Or in Xcode: **File → Add Package Dependencies** → paste the URL.

---

<img src="https://img.shields.io/badge/QUICK_START-E67E22?style=for-the-badge" alt="Quick Start">

```swift
import NetworkAPI

struct MangaRepository: NetworkInteractor {
    func fetchMangas() async throws -> [Manga] {
        let request = URLRequest.get(url: URL(string: "https://api.example.com/mangas")!)
        return try await getJSON(request, type: [Manga].self)
    }

    func createManga(_ manga: Manga) async throws {
        let request = URLRequest.post(url: URL(string: "https://api.example.com/mangas")!, body: manga)
        try await postJSON(request, status: 201)
    }
}
```

---

<img src="https://img.shields.io/badge/USED_BY-F1C40F?style=for-the-badge" alt="Used By">

| Project | Description |
|:-------:|-------------|
| [**MisMangas**](https://github.com/WillToCoding/MisMangas) | Multi-platform manga collection manager |

---

<p align="center">
  <b>MIT License</b> · Made with ❤️ by <b>Juan Carlos</b>
</p>

<p align="center">
  <i>Swift Developer Program 2026 — Apple Coding Academy</i>
</p>

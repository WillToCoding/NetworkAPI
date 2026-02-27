# NetworkAPI

<p align="center">
  <img src="https://img.shields.io/badge/Swift-6.0-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  <img src="https://img.shields.io/badge/SPM-Compatible-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SPM">
  <img src="https://img.shields.io/badge/Platforms-5-9B59B6?style=for-the-badge&logo=apple&logoColor=white" alt="Platforms">
  <img src="https://img.shields.io/badge/License-MIT-2ECC71?style=for-the-badge" alt="License">
</p>

<h3 align="center">Lightweight async/await networking layer for Apple platforms</h3>

<p align="center">
  <i>Zero dependencies · Protocol-oriented · Type-safe</i>
</p>

---

<img src="https://img.shields.io/badge/FEATURES-2ECC71?style=for-the-badge" alt="Features">

| | Feature | Description |
|:--:|---------|-------------|
| ⚡ | **Async/Await** | Modern Swift concurrency, no callbacks |
| 🔒 | **Type-Safe** | Generic JSON decoding with Codable |
| 🖼️ | **Image Caching** | Automatic disk cache for downloaded images |
| 🛡️ | **Error Handling** | Comprehensive NetworkError enum |
| 📦 | **Zero Dependencies** | 100% Apple frameworks |

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

<img src="https://img.shields.io/badge/PLATFORMS-9B59B6?style=for-the-badge" alt="Platforms">

| Platform | Version |
|:--------:|:-------:|
| iOS | 17.0+ |
| macOS | 14.0+ |
| watchOS | 10.0+ |
| tvOS | 17.0+ |
| visionOS | 1.0+ |

---

<img src="https://img.shields.io/badge/QUICK_START-E67E22?style=for-the-badge" alt="Quick Start">

### 1. Conform to NetworkInteractor

```swift
import NetworkAPI

struct MangaRepository: NetworkInteractor {
    func fetchMangas() async throws -> [Manga] {
        let request = URLRequest.get(url: URL(string: "https://api.example.com/mangas")!)
        return try await getJSON(request, type: [Manga].self)
    }
}
```

### 2. Make Requests

```swift
// GET - Fetch data
let mangas = try await repository.fetchMangas()

// POST - Create resource
let request = URLRequest.post(url: url, body: newManga)
try await repository.postJSON(request, status: 201)
```

### 3. Download Images (iOS)

```swift
// Download with automatic caching
let image = try await ImageDownloader.shared.image(for: coverURL)

// Check if cached
let fileURL = ImageDownloader.shared.getFileURL(url: coverURL)
```

---

<img src="https://img.shields.io/badge/API_REFERENCE-E74C3C?style=for-the-badge" alt="API Reference">

### NetworkInteractor Protocol

```swift
protocol NetworkInteractor {
    func getJSON<T: Codable>(_ request: URLRequest, type: T.Type) async throws -> T
    func postJSON(_ request: URLRequest, status: Int) async throws
}
```

| Method | Description |
|--------|-------------|
| `getJSON(_:type:)` | Performs GET, decodes JSON to specified type |
| `postJSON(_:status:)` | Performs POST, validates expected status code |

### URLRequest Extensions

```swift
extension URLRequest {
    static func get(url: URL, token: String? = nil) -> URLRequest
    static func post<T: Codable>(url: URL, body: T, method: String = "POST", token: String? = nil) -> URLRequest
}
```

| Method | Description |
|--------|-------------|
| `.get(url:token:)` | Creates GET request with optional Bearer token |
| `.post(url:body:method:token:)` | Creates POST/PUT/PATCH/DELETE with JSON body |

### ImageDownloader (iOS only)

```swift
actor ImageDownloader {
    static let shared: ImageDownloader
    func image(for url: URL) async throws -> UIImage
    func getFileURL(url: URL) -> URL
}
```

| Method | Description |
|--------|-------------|
| `image(for:)` | Downloads image, caches to disk, returns UIImage |
| `getFileURL(url:)` | Returns local cache file URL |

### NetworkError

```swift
enum NetworkError: Error {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP
}
```

| Case | When |
|------|------|
| `.general(Error)` | URLSession or other system errors |
| `.status(Int)` | HTTP status doesn't match expected |
| `.json(Error)` | JSON decoding failed |
| `.dataNotValid` | Response data is nil or invalid |
| `.nonHTTP` | Response is not HTTPURLResponse |

---

<img src="https://img.shields.io/badge/EXAMPLE-1ABC9C?style=for-the-badge" alt="Example">

### Complete Repository Example

```swift
import NetworkAPI

struct UserRepository: NetworkInteractor {
    let baseURL = URL(string: "https://api.example.com")!
    var token: String?

    // GET users
    func fetchUsers() async throws -> [User] {
        let request = URLRequest.get(url: baseURL.appendingPathComponent("users"), token: token)
        return try await getJSON(request, type: [User].self)
    }

    // POST new user
    func createUser(_ user: User) async throws {
        let request = URLRequest.post(
            url: baseURL.appendingPathComponent("users"),
            body: user,
            token: token
        )
        try await postJSON(request, status: 201)
    }

    // PUT update user
    func updateUser(_ user: User) async throws {
        let request = URLRequest.post(
            url: baseURL.appendingPathComponent("users/\(user.id)"),
            body: user,
            method: "PUT",
            token: token
        )
        try await postJSON(request, status: 200)
    }

    // DELETE user
    func deleteUser(id: Int) async throws {
        let url = baseURL.appendingPathComponent("users/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        if let token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        try await postJSON(request, status: 204)
    }
}
```

---

<img src="https://img.shields.io/badge/ARCHITECTURE-95A5A6?style=for-the-badge" alt="Architecture">

```
NetworkAPI/
├── Sources/NetworkAPI/
│   ├── NetworkInteractor.swift      # Main protocol
│   ├── URLRequest+Extensions.swift  # Request builders
│   ├── NetworkError.swift           # Error types
│   └── ImageDownloader.swift        # Image caching (iOS)
└── Package.swift
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
  <i>Swift Developer Program 2025 — Apple Coding Academy</i>
</p>

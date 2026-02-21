# NetworkAPI

Swift networking library - URLSession wrapper for async/await.

## Installation

Add the package to your project via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/tu-usuario/NetworkAPI.git", from: "1.0.0")
]
```

## Platforms

- iOS 17+
- macOS 14+
- watchOS 10+
- tvOS 17+
- visionOS 1+

## Usage

### GET Request

```swift
import NetworkAPI

struct MyRepository: NetworkInteractor {
    func fetchItems() async throws -> [Item] {
        let request = URLRequest.get(url: URL(string: "https://api.example.com/items")!)
        return try await getJSON(request, type: [Item].self)
    }
}
```

### POST Request

```swift
struct MyRepository: NetworkInteractor {
    func createUser(_ user: User) async throws {
        let request = URLRequest.post(url: URL(string: "https://api.example.com/users")!, body: user)
        try await postJSON(request, status: 201)
    }
}
```

### Image Download (iOS)

```swift
let image = try await ImageDownloader.shared.image(for: imageURL)

// Check cached file
let fileURL = ImageDownloader.shared.getFileURL(url: imageURL)
```

## API

### NetworkInteractor Protocol

| Method | Description |
|--------|-------------|
| `getJSON(_:type:)` | GET request returning decoded JSON |
| `postJSON(_:status:)` | POST request with expected status code |

### URLRequest Extensions

| Method | Description |
|--------|-------------|
| `.get(url:)` | Create GET request |
| `.post(url:body:method:)` | Create POST/PUT/PATCH/DELETE request |

### ImageDownloader (iOS)

| Method | Description |
|--------|-------------|
| `image(for:)` | Download and cache image |
| `getFileURL(url:)` | Get cached file URL |

### NetworkError

| Case | Description |
|------|-------------|
| `.general(Error)` | General error |
| `.status(Int)` | HTTP status error |
| `.json(Error)` | JSON decode error |
| `.dataNotValid` | Invalid data |
| `.nonHTTP` | Not an HTTP response |

## License

MIT

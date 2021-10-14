# InstagramPrivateAPI

Swift package of `Codable` types for https://github.com/dilame/instagram-private-api.

## Usage

```
import InstagramPrivateAPI

let timeline = try NodeDecoder(env: env).decode([Post].self, from: value)
```

See https://github.com/kewlbear/NodeDecoder for `NodeDecoder`.
See https://github.com/kewlbear/Inssagram for a working iOS app.

### Swift Package Manager

```
.package(url: "https://github.com/kewlbear/InstagramPrivateAPI.git", .branch("main")),
```

## License

MIT

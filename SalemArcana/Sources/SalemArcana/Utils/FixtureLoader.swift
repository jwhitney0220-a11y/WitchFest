import Foundation

public class FixtureLoader {
    public static func load<T: Decodable>(fileName: String, bundle: Bundle = .module) throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "FixtureLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found: \(fileName)"])
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

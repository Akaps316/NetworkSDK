import Foundation

public class NetworkSDK {
    
    public static let shared = NetworkSDK()
    
    private let baseURL: String
    private let apiKey: String
    
    public init(baseURL: String = "https://api.themoviedb.org/3", apiKey: String = "909594533c98883408adef5d56143539") {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    public func fetchMoviesList(completion: @escaping ([Movie]?, Error?) -> Void) {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(MoviesResponse.self, from: data)
                completion(movies.results, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

public struct Movie: Codable {
    let title: String
    let overview: String
}

public struct MoviesResponse: Codable {
    let results: [Movie]
}

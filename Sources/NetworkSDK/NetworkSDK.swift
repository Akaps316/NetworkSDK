// NetworkSDK.swift

import Foundation

public class NetworkSDK {
    public static let shared = NetworkSDK()
    
    private var apiKey = "909594533c98883408adef5d56143539"
    private var baseURL = "https://api.themoviedb.org/3"
    
    private init() {}
    
    func setApiKey(newApiKey: String)
    {
        apiKey = newApiKey
    }
    
    func setBaseURL(newBaseURL: String)
    {
        baseURL = newBaseURL
    }
    
    enum Endpoint {
        case latestMovies
        case popularMovies
        case movieDetail(movieId: Int)
        
        var path: String {
            switch self {
            case .latestMovies:
                return "/movie/latest"
            case .popularMovies:
                return "/movie/popular"
            case .movieDetail(let movieId):
                return "/movie/\(movieId)"
            }
        }
        
        var queryItems: [URLQueryItem] {
            return [
                URLQueryItem(name: "api_key", value: NetworkSDK.shared.apiKey)
            ]
        }
    }
    
    public func fetchLatestMovies(completion: @escaping (Movie?, Error?) -> Void) {
        fetchData(for: .latestMovies, completion: completion)
    }
    
    public func fetchPopularMovies(completion: @escaping (MovieResponse?, Error?) -> Void) {
        fetchData(for: .popularMovies, completion: completion)
    }
    
    public func fetchMovieDetail(for movieId: Int, completion: @escaping (Movie?, Error?) -> Void) {
        fetchData(for: .movieDetail(movieId: movieId)) { (movie: Movie?, error: Error?) in
            completion(movie, error)
        }
    }
    
    private func fetchData<T: Decodable>(for endpoint: Endpoint, completion: @escaping (T?, Error?) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL + endpoint.path) else {
            completion(nil, NSError(domain: "NetworkSDK", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            completion(nil, NSError(domain: "NetworkSDK", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }.resume()
    }
}

public struct Movie: Decodable, Identifiable {
    public let id: Int
    public let title: String
    public let overview: String
    public let release_date: String
    public let poster_path: String?
    // Add other properties as needed
    
}

public struct MovieResponse: Decodable {
    public let page: Int
    public let results: [Movie]
    public let total_pages: Int
    public let total_results: Int
}

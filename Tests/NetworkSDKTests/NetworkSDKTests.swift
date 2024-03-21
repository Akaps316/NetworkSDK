import XCTest
@testable import NetworkSDK

class NetworkSDKTests: XCTestCase {
    
    func testFetchLatestMovies_Success() {
        let expectation = self.expectation(description: "Fetch latest movies")
        var fetchedMovies: Movie?
        var fetchError: Error?
        
        NetworkSDK.shared.fetchLatestMovies { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchedMovies)
        XCTAssertNil(fetchError)
    }
    
    func testFetchPopularMovies_Success() {
        let expectation = self.expectation(description: "Fetch latest movies")
        var fetchedMovies: MovieResponse?
        var fetchError: Error?
        
        NetworkSDK.shared.fetchPopularMovies { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchedMovies)
        XCTAssertNil(fetchError)
    }
    
    func testFetchLatestMovies_InvalidAPIKey() {
        let expectation = self.expectation(description: "Fetch latest movies with invalid API key")
        var fetchError: Error?
        
        // Replace API key with an invalid key
        NetworkSDK.shared.setApiKey(newApiKey: "invalid_api_key")
        
        NetworkSDK.shared.fetchLatestMovies { (movies, error) in
            fetchError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchError)
        XCTAssertEqual((fetchError! as NSError).code, 4865)
    }
    
    func testFetchLatestMovies_InvalidURL() {
        let expectation = self.expectation(description: "Fetch latest movies with invalid URL")
        var fetchError: Error?
        
        // Replace baseURL with an invalid URL
        NetworkSDK.shared.setBaseURL(newBaseURL: "invalid_url")
        
        NetworkSDK.shared.fetchLatestMovies { (movies, error) in
            fetchError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchError)
        XCTAssertEqual((fetchError! as NSError).code, -1002)
    }
    
    func testFetchLatestMovies_NoInternetConnection() {
        // Simulate no internet connection
        // (This test assumes that the device is not connected to the internet)
        let networkSDK = NetworkSDK.shared
        
        let expectation = self.expectation(description: "Fetch latest movies with no internet connection")
        var fetchError: Error?
        
        networkSDK.fetchLatestMovies { (movies, error) in
            fetchError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchError)
        XCTAssertEqual((fetchError! as NSError).code, -1002) // NSURLErrorNotConnectedToInternet
    }
    
    func testFetchMovieDetail_Success() {
        let expectation = self.expectation(description: "Fetch movie detail")
        var fetchedMovie: Movie?
        var fetchError: Error?
        
        let movieId = 1262535
        
        NetworkSDK.shared.fetchMovieDetail(for: movieId) { (movie, error) in
            fetchedMovie = movie
            fetchError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(fetchedMovie)
        XCTAssertNil(fetchError)
    }

}

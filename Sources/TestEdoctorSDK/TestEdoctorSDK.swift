import SwiftUI
import WebKit



public func openWebView(withURL urlString: String) {


    if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            let customWebViewController = CustomWebViewController(urlString: urlString)
            topViewController.present(customWebViewController, animated: true, completion: nil)
   }
}

public func showFullScreenWebView(withURL urlString: String) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    let fullScreenWebView = FullScreenWebView(urlString: urlString)
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: fullScreenWebView)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}

public func getUser(accessToken: String) async throws -> User {
    let user = try await UserAPIClient(baseURL: URL(string: "https://api.example.com/")!, accessToken: accessToken).fetchUser()
    return user
}

public func fetchUser(accessToken: String, completion: @escaping (Result<User, Error>) -> Void) {
    let url = URL(string: "https://api.example.com/")!.appendingPathComponent("user")
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Set AccessToken in the request header
    
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data = data, error == nil else {
            completion(.failure(error ?? NSError(domain: "Error", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}


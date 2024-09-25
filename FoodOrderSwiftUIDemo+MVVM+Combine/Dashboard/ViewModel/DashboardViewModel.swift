//
//  DashboardViewModel\.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 29/08/24.
//

import Foundation
import CoreLocation
import Combine

class DashboardViewModel: ObservableObject {
    
    @Published var currenLocation: String?
    private var location = Location()
    private let FoodAPIurl = "https://www.themealdb.com/api/json/v1/1/categories.php"
    private var cancellable = Set<AnyCancellable>()
    @Published var foodCategories : [Category] = []
    init() {
        location.$currentLocation.assign(to: &$currenLocation)
    }
    
    func getCurrentLocation() {
        location.checkLocationAuthorization()
    }
    
    func getFoodItems() {
        
        if let url = URL(string: FoodAPIurl) {
         
            let request = URLRequest(url: url)
            
            let session = URLSession(configuration: .default, delegate: SSLTrustDelegate(), delegateQueue: nil)
            let _ = session.dataTaskPublisher(for: request)

                .map(\.data)
                .decode(type: FoodItems.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }) { foodItem in
                    if let categories = foodItem.categories {
                        self.foodCategories = categories
                    }
                }
                .store(in: &cancellable)
        }
    }
}

class SSLTrustDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

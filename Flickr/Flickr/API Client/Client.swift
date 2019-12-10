//
//  Client.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

enum RequestConfig {
    
    case searchRequest(String, Int)
    
    var value: Request? {
        
        switch self {
            
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: Statics.searchURL, searchText, pageNo)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}

class Client: NSObject {
    
    private var searchText = ""
    private var pageNo = 1
    private var totalPageNo = 1
    
    var showAlert: ((String) -> Void)?
    var dataUpdated: (() -> Void)?
    
    func fetchResults(text: String, completion: @escaping ([Photos]) -> Void, failure: @escaping () -> Void) {
        searchText = text
        self.request(searchText, pageNo: pageNo) { (result) in
            
            Threads.runOnMainThread {
                switch result {
                case .Success(let results):
                    if let result = results {
                        self.totalPageNo = result.pages
                        
                        completion(result.photo)
                    }
                    
                case .Failure(_):
                    failure()
                case .Error(_):
                    failure()
                }
            }
        }
    }
    
    func fetchNextPage(completion: @escaping ([Photos]) -> Void, failure: @escaping () -> Void) {
        if pageNo < totalPageNo {
            pageNo += 1

            fetchResults(text: "\(self.searchText)", completion: { (data) in
                completion(data)
            }) {
                failure()
            }
        } else {
            failure()
        }
    }
    
    func request(_ searchText: String, pageNo: Int, completion: @escaping (Result<FlickrPhotos?>) -> Void) {
        
        guard let request = RequestConfig.searchRequest(searchText, pageNo).value else {
            return
        }
        
        Manager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if let stat = model.stat, stat.uppercased().contains("OK") {
                        return completion(.Success(model.photos))
                    } else {
                        return completion(.Failure(Manager.errorMessage))
                    }
                } else {
                    return completion(.Failure(Manager.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> SearchResults? {
        do {
            let responseModel = try JSONDecoder().decode(SearchResults.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}

//
//  APIManager.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 04/11/2021.
//

import Foundation

struct APIManager
{
    private static var baseURL = "https://data.gov.il/api/3/action/datastore_search"
    
    static func makeRequest(settelmentName: String ,callbackResult: @escaping (JSONDataResult?) -> Void)
    {
        if settelmentName.isInt || settelmentName == "" || settelmentName.isNotAChar 
        {
            callbackResult(nil)
            return
        }
        
        let queryItems          = [URLQueryItem(name: "q", value: settelmentName), URLQueryItem(name: "resource_id", value: "5c78e9fa-c2e2-4771-93ff-7f400a12f7ba")]
        guard var urlComps      = URLComponents(string: baseURL) else
        {
            callbackResult(nil)
            return
        }
        urlComps.queryItems     = queryItems
        
        guard let url           = urlComps.url else
        {
            callbackResult(nil)
            return
        }
        
        let session         = URLSession(configuration: .default)
        session.dataTask(with: url)
        { (data, response, error) in
            if error != nil
            {
                callbackResult(nil)
            }
            do
            {
                guard let data  = data else { return }
                let result      = try JSONDecoder().decode(JSONDataResult.self, from: data)
                callbackResult(result)
            } catch
            {
                callbackResult(nil)
            }
        }.resume()
    }
}

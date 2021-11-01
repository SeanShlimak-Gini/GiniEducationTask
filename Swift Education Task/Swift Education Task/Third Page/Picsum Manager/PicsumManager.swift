//
//  PicsumManager.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import Foundation
import EzImageLoader
import EzHTTP

struct PicsumManager
{
    //MARK: - Public methods
    static func getImage(url: String, completion: @escaping (_ image: UIImage?) -> Void)
    {
        guard let request = HTTP.createRequest(.GET, url, params: [:], headers: [:]) else
        {
            completion(nil)
            return
        }
        
        ImageLoader.request(request)
        {
            completion($0.image)
        }
    }
}

//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Tanaka Mazivanhanga on 11/25/20.
//

import Foundation

class Model {
    func getVideos() {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = Constants.BASE_URL
        urlComponent.path = Constants.PLAYLIST_ITEMS_ENDPOINT
        let part = URLQueryItem(name: "part", value: "snippet")
        let maxResults = URLQueryItem(name: "maxResults", value: "50")
        let playlistIdQ = URLQueryItem(name: "playlistId", value: Constants.PLAYLIST_ID)
        urlComponent.queryItems = [part,maxResults,playlistIdQ, .init(name: "key", value: Constants.API_KEY)]

        guard let url = urlComponent.url else {return}

        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err{
                print(err.localizedDescription)
            }

            if let data = data {
//                do something

                print(String(data: data, encoding: .utf8))
            }
        }.resume()
    }
}

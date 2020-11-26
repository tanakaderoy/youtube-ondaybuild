//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Tanaka Mazivanhanga on 11/25/20.
//

import Foundation




protocol ModelDelegate {
    func videosFetched(_ vids: [Video])
}



class Model {
    var delegate: ModelDelegate?
    typealias videoClosure = ([Video]) -> ()
    func getVideos() {
        //(_ completion: @escaping videoClosure)
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = Constants.BASE_URL
        urlComponent.path = Constants.PLAYLIST_ITEMS_ENDPOINT
        let part = URLQueryItem(name: "part", value: "snippet")
        let maxResults = URLQueryItem(name: "maxResults", value: "50")
        let playlistIdQ = URLQueryItem(name: "playlistId", value: Constants.PLAYLIST_ID)
        urlComponent.queryItems = [part,maxResults,playlistIdQ, .init(name: "key", value: Constants.API_KEY)]

        guard let url = urlComponent.url else {return}

        URLSession.shared.playlistListItemResponseTask(with: url) { (playListItemRes, res, err) in
            if let err = err {
                print(err.localizedDescription)
            }

            if let data = playListItemRes {

                let vids = data.items.map({Video.toVideoFrom(snippet: $0.snippet)})
                self.delegate?.videosFetched(vids)
                //completion(vids)

            }
        }.resume()
    }
}

extension Video {
    static func toVideoFrom(snippet: PlaylistListItemResponse.Snippet) -> Video{
        return Video(title: snippet.title, description: snippet.snippetDescription, thumbnail: snippet.thumbnails.high.url, videoId: snippet.resourceID.videoID, playlistId: snippet.playlistID, published: Date.fromString(isoDate: snippet.publishedAt))
    }
}

extension Date {
    static func fromString(isoDate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:isoDate) ?? Date()
    }

    func toString(_ format:String = "MM dd, yyy") -> String {
        let dateFormmatter = DateFormatter()
        dateFormmatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormmatter.dateFormat = format
        return dateFormmatter.string(from: self)
    }
}

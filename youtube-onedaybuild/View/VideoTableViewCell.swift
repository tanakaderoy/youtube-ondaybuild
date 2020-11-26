//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by Tanaka Mazivanhanga on 11/26/20.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
static let videoCellID = "VideoCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ video:Video){
        titleLabel.text = video.title
        dateLabel.text = video.published.toString("EEEE, MMM d, yyy")
        imageFromUrl( video) {[weak self] (image) in
            DispatchQueue.main.async {
                self?.thumbnailImageView.contentMode = .scaleAspectFill
                self?.thumbnailImageView.image = image
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func imageFromUrl(_ video: Video,_ completion: @escaping (UIImage)->()){
        if (CacheManager.getVideoCache(video.thumbnail) != nil) {
            guard let data = CacheManager.getVideoCache(video.thumbnail), let img = UIImage(data: data)  else{return}
            completion(img)
            return
        }
        guard let url = URL(string: video.thumbnail) else{ return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err{
                print(err.localizedDescription)
            }
            if url.absoluteString != video.thumbnail {
                return
            }
            if let data = data{
                CacheManager.setVideoCache(video.thumbnail, data)
                guard let image = UIImage(data: data) else {return}
                completion(image)
            }else{
                completion(UIImage(systemName: "xmark.octagon")!)
            }
        }.resume()
    }

}




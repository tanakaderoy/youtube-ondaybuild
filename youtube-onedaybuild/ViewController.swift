//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Tanaka Mazivanhanga on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var model: Model = Model()
    var videos = [Video]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate  = self
        model.getVideos()



    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.videoCellID, for: indexPath) as? VideoTableViewCell else {return UITableViewCell()}
        let vid = videos[indexPath.row]
        cell.configure(vid)
        return cell
    }


}



extension ViewController: ModelDelegate {
    func videosFetched(_ vids: [Video]) {
        DispatchQueue.main.async {
            self.videos = vids
            self.tableView.reloadData()
        }
    }


}

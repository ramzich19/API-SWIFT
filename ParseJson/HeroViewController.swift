//
//  HeroViewController.swift
//  ParseJson
//
//  Created by Рамазан Нуриев on 16.11.2021.
//

import UIKit
import Foundation


extension UIImageView {
    func downloadedFrom (url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadedFrom (link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class HeroViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var textLbl: UITextView!
    @IBOutlet weak var priceLbl: UILabel!
    var hero: Lesson?

    override func viewDidLoad() {
        super.viewDidLoad()

        let time = hero?.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDateInString = dateFormatter.string(from: (time)!)
        

        dateLbl.text = formattedDateInString
        nameLbl.text = hero?.name
        textLbl.text = hero?.text
        priceLbl.text = (hero?.price)!

        let urlString = (hero?.image)!
        let url = URL(string: urlString)
        imageView.downloadedFrom(url: url!)

    }
}


//
//  ViewController.swift
//  ParseJson
//
//  Created by Рамазан Нуриев on 15.11.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func pushRefreshAction(_ sender: Any) {
    }
    
    var heroes = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping ()->()){
    
        let url = URL(string: "http://185.5.206.149/api/articles")
        
//        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
//                print(error)
//                return
//            }
            
//            guard let data = data else { return }
//            2021-11-15
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                self.heroes = try decoder.decode([Lesson].self, from: data!)
                
                DispatchQueue.main.async {
                    completed()
                }
//                self.heroes .forEach { list in
//                    print(list.name, list.text, list.image)
//
//                }
            }catch{
                print("JSON ERROR")
            }
            }
        }.resume()

    }
}



//
//  ViewController.swift
//  ChuckNorrisFactRetriever
//
//  Created by Pedro Azevedo on 07/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController,ShareDelegate{
    
    override func loadView() {
        super.loadView()
        getCategories()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        safeArea = view.layoutMarginsGuide
        setContraints()
    }
    
    var safeArea:UILayoutGuide!
    
    var categoryIndex = 0
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.barTintColor = .clear
        searchBar.barStyle = .default
        searchBar.isTranslucent = tru
        searchBar.placeholder = "Search for fact"
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    lazy var dropDownTable:UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.reloadData()
        return tableView
    }()
    
    lazy var dropDownButton:UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(popDropDownTable), for: .touchDown)
        button.setTitle(">", for: .normal)
        button.sizeToFit()
        button.titleLabel?.textColor = .red
        
        return button
    }()
    
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.reloadData()
        return tableView
    }()
    
    lazy var addFactButton:UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addFact), for: .touchDown)
        button.setTitle("Add random fact", for: .normal)
        button.sizeToFit()
        button.titleLabel?.textColor = .red
        
        return button
    }()
    
    //fetch api from category
    @objc private func addFact(){
        //change the category to be searched
        var url = String()
        if self.categoryIndex == 0 {
            url = dao.randomUrl
        }else{
            url = dao.categoryUrl + "\(dao.categories[categoryIndex])"
        }
        
        
        let anonymousFunc = {(fetchedData:Fact) in
            DispatchQueue.main.async {
                fetchedData.category = dao.categories[self.categoryIndex]
                dao.fakeFacts.append(fetchedData)
                self.tableView.reloadData()
            }
        }
        api.ramdomfetch(urlStr: url, onCompletion: anonymousFunc)
    }
    
    @objc func popDropDownTable(){
        if self.dropDownTable.isHidden{
            self.dropDownTable.isHidden = false
            self.view.bringSubviewToFront(self.dropDownTable)
        }else{
            self.dropDownTable.isHidden = true
        }
    }
    
    internal func didPressButton(fact: String) {
        let activityControl = UIActivityViewController(activityItems:[fact], applicationActivities: nil)
        self.present(activityControl, animated: true, completion: nil)
    }
    
    private func showSearchAlert() {
        //Create the AlertController
        let myAlertController: UIAlertController = UIAlertController(title: "Chuck says:", message: "No resuld could be found", preferredStyle: .alert)

        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        myAlertController.addAction(cancelAction)
        //Present the AlertController
        self.present(myAlertController, animated: true, completion: nil)
    }
    
    //retrieve available categories from api
    private func getCategories(){
        let anonymousFunc = {(fetchedData:[String]) in
            DispatchQueue.main.async {
                for category in fetchedData{
                    dao.categories.append(category)
                }
                self.dropDownTable.reloadData()
            }
        }
        api.getCategories(onCompletion: anonymousFunc)
        
    }
    
    private func setContraints(){
        
        //add button
        addFactButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  0).isActive = true
        addFactButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        addFactButton.widthAnchor.constraint(equalToConstant: view.frame.width * 4/5).isActive = true
        addFactButton.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        
        dropDownButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  0).isActive = true
        dropDownButton.leftAnchor.constraint(equalTo: addFactButton.rightAnchor, constant: 0).isActive = true
        dropDownButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        dropDownButton.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        
        searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height/8).isActive = true
        
        //table view
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo:addFactButton.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //dropDown category
        dropDownTable.bottomAnchor.constraint(equalTo: addFactButton.topAnchor).isActive = true
        dropDownTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        dropDownTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        dropDownTable.heightAnchor.constraint(equalToConstant: view.frame.height/8).isActive = true
    }
    
    
}

// MARK: - DataSource
extension FeedViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return dao.fakeFacts.count
        }else{
            return dao.categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create cell
        if tableView == self.tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FactTableViewCell
            
            cell.setup(factModel: dao.fakeFacts[indexPath.row])

            cell.shareDelegate = self
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = dao.categories[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView{
            return 200
        }else{
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.dropDownTable{
            addFactButton.setTitle("Add \(dao.categories[indexPath.row]) fact", for: .normal)
            //sets index for category selection
            categoryIndex = indexPath.row
            
            //removes dropTable
            if !dropDownTable.isHidden{
                dropDownTable.isHidden = true
            }
        }
    }
    
    func deleteAction(at indexPath:IndexPath) ->UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            dao.fakeFacts.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return action
    }
    
}

extension FeedViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getTextFacts(text:(searchBar.text!))
    }
    
    private func getTextFacts(text:String){
        let anonymousFunc = {(fetchedData:FactSearch) in
            DispatchQueue.main.async {
                if fetchedData.total! > 0{
                for category in fetchedData.result!{
                    dao.fakeFacts.append(category)
                }
                self.tableView.reloadData()
                }else{
                    
                    self.showSearchAlert()
                }
            }
        }
        api.searchFetch(text: text, onCompletion:anonymousFunc)
    }
    
    
}





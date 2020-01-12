//
//  FactTableViewCell.swift
//  ChuckNorrisFactRetriever
//
//  Created by Pedro Azevedo on 08/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

import UIKit

class FactTableViewCell: UITableViewCell {

    var safeArea:UILayoutGuide!
    var shareDelegate:ShareDelegate!
    
    
    

    lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        label.frame.inset(by: inset)
        label.textColor = .white
        label.backgroundColor = .red
        
        return label
        
    }()
    
    
    lazy var factLabel:UILabel = {
        let label = UILabel()
        addSubview(label)
        //configs label properties
       
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .black
        label.font = label.font.withSize(40)
        label.adjustsFontSizeToFitWidth = true
        debugPrint(label.font.lineHeight,label.numberOfLines)
        //configs constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var shareButton:UIButton = {
        let button = UIButton()
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        let buttonImage = UIImage(named: "share")
        button.imageView?.contentMode = .center
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(shareFact), for: .touchDown)
        
        return button
    }()
    
    func setUpContraints(){
        //those should be applied in order
        
        //category Label
        
        categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -categoryLabel.frame.height * 1.2).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //share button
        shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -shareButton.frame.height * 1.2).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -10).isActive = true
        
        
        //text label
        factLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30).isActive = true
        factLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        factLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -20).isActive = true
        factLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.selectionStyle = .none
        setUpView()
        setUpContraints()
        isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup
    func setUpView(){
        safeArea = layoutMarginsGuide
        
    }
    
    ///adds model to viewmodel
    func setup(factModel:Fact){
        self.categoryLabel.text = factModel.category
        self.factLabel.text = factModel.value
          
    }
    
   // MARK: - Share
    @objc func shareFact(){
           shareDelegate.didPressButton(fact: self.factLabel.text!)
       }
       
}

protocol ShareDelegate : UIViewController {
    func didPressButton(fact:String)
}




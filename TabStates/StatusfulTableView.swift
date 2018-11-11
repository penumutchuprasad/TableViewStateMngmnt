//TabState1.swift
/*
 * TabStates
 * Created by penumutchu.prasad@gmail.com on 11/11/18
 * Is a product created by abnboys
 * For the TabStates in the TabStates
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit

class StatusfulTableView: UITableView {
    
    //MARK: Class for view
    
    class TabBackgroundView: UIView {
        
        var desc: String? {
            didSet{
                self.descLabel.text = desc
            }
        }
        
        var imgView: UIImageView!
        var descLabel: UILabel!
        
        convenience init(with image: UIImage, andDescription desc: String) {
            
            self.init(frame: .zero)
            
            self.imgView.image = image
            self.descLabel.text = desc
        }
        
        private override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            setupViews()
        }
        
        private func setupViews() {
            
            imgView = UIImageView.init()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgView)
            
            descLabel = UILabel()
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            descLabel.textAlignment = .center
            descLabel.textColor = .green
            addSubview(descLabel)
            
            addConstraints([
                
                imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor),
                imgView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
                
                descLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 16),
                descLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                descLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
                
                ])
            
        }
        
    }
    
    //MARK: Enum for state

    enum TableState {
        
        case Loading
        case Failed
        case NoItems
        case Success
        
    }
    
    //MARK: Properties
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setupBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBackgroundView()
    }
    
    override var bounds: CGRect {
        didSet{
            if subviews.contains(bgView) {
                bgView.frame = self.bounds
            }
        }
    }

    private var state: TableState = .Loading
    
    var bgView = TabBackgroundView.init(with: #imageLiteral(resourceName: "timer"), andDescription: "Connecting...") {
        
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    func setupBackgroundView() {
        
        bgView.frame = self.bounds
        addSubview(bgView)

    }
    
    func setState(_ state: TableState) {
        
        self.state = state
        self.handleStatesUI()

    }
    
    func handleStatesUI() {
        
        switch state {
        case .Loading:
            
            self.bgView.desc = "Loading data"
            self.bgView.imgView.image = #imageLiteral(resourceName: "timer")
            
        case .Failed:
            
            DispatchQueue.main.async {
                self.bgView.desc = "Failed to load"
                self.bgView.imgView.image = #imageLiteral(resourceName: "timer")
            }
            
        case .NoItems:
            
            self.bgView.descLabel.text = "No data. Please try again"
            self.bgView.imgView.image = #imageLiteral(resourceName: "plus")
            
        case .Success:
            
            UIView.animate(withDuration: 0.35, animations: {
                self.bgView.alpha = 0
            }) { (_) in
                self.bgView.removeFromSuperview()
                self.reloadData()
            }

        }
        
    }
}


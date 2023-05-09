//
//  ViewController.swift
//  Music genre generator
//
//  Created by user on 23.04.2023.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(firstBackgroundView)
        firstBackgroundView.addSubview(secondBackgroundView)
        secondBackgroundView.addSubview(thridBackgroundView)
        thridBackgroundView.addSubview(segmentedControl)
        thridBackgroundView.addSubview(button)
        thridBackgroundView.addSubview(textLabel)
        thridBackgroundView.addSubview(imageView)
                
        firstBackgroundView.frame = CGRect(x: 20, y: 35, width: view.frame.width - 40, height: view.frame.height - 70)
        secondBackgroundView.frame = CGRect(x: 0, y: 35, width: view.frame.width - 40 , height: firstBackgroundView.frame.height - 70)
        thridBackgroundView.frame = CGRect(x: 0, y: 35, width: view.frame.width - 40 , height: secondBackgroundView.frame.height - 70)
                        
        imageView.frame = CGRect(x: view.frame.width / 2 - 115, y: 115, width: 170 , height: 170)
        segmentedControl.frame = CGRect(x: 20 , y: 330, width: 300, height: 50)
        button.frame = CGRect(x: thridBackgroundView.frame.width / 2 - 75, y: thridBackgroundView.frame.height / 2 + 75, width: 150, height: 50)
        textLabel.frame = CGRect(x: 20, y: thridBackgroundView.frame.height / 2 + 125, width: 300, height: 100)
        
        button.addTarget(self, action: #selector(networkingRequest), for: .touchDown)
    }

        private let firstBackgroundView: UIView  = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0, alpha: 1.0)
        view.layer.cornerRadius = 147
        return view
    }()
    
    private let secondBackgroundView: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 248 / 255.0,green: 244/255.0,blue: 244 / 255.0, alpha: 1.0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 147
        return view
    }()
    
    private let thridBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 237 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 1.0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 147
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "note"))
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor( red: 221 / 255.0, green: 222/255.0, blue: 214 / 255.0, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Click on it", for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["ganre", "story"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
}

extension ViewController {
    @objc func networkingRequest() {
        var url = ""
        switch segmentedControl.selectedSegmentIndex {
        case 0: url = "https://binaryjazz.us/wp-json/genrenator/v1/genre/"
        case 1: url = "https://binaryjazz.us/wp-json/genrenator/v1/story/"
        default: break
        }
            Networking.load(url) { result in
            let text = result.replacingOccurrences(of: "\"", with: "")
            DispatchQueue.main.async { self.textLabel.text = text }
        } errorCompletion: { error in
            switch error {
            case .notValidLink:
                DispatchQueue.main.async { self.displayAlert(message: "Link isn't valid") }
            case .notValidData:
                DispatchQueue.main.async { self.displayAlert(message: "Data isn't valid") }
            }
        }
    }
    private func  displayAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(actionAlert)
        present(alert, animated: true)
    }
}


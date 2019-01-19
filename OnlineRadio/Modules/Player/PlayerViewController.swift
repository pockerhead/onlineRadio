//
//  PlayerViewController.swift
//  OnlineRadio
//
//  Created Артём Балашов on 19/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//
//  Template generated by Sakhabaev Egor @Banck
//  https://github.com/Banck/Swift-viper-template-for-xcode
//

import UIKit

class PlayerViewController: UIViewController {
    // MARK: - Properties
	var presenter: PlayerPresenterInterface?
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationImageView: UIImageView!
    @IBOutlet weak var activite: UIActivityIndicatorView!
    
    // MARK: - Lifecycle -
	override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
}

//MARK: - Actions
extension PlayerViewController {
    @IBAction func didSelectPlayPauseButtton(_ sender: UIButton) {
        presenter?.didSelectPlayPauseButton()
    }
}

// MARK: - PlayerView
extension PlayerViewController: PlayerView {
    func displayButtonImage(played: Bool) {
        let image: UIImage = UIImage(named: played ? "pauseIcon" : "playIcon") ?? UIImage()
        playPauseButton.setImage(image, for: .normal)
        playPauseButton.setImage(image, for: .highlighted)
        playPauseButton.isHidden = false
        activite.stopAnimating()
    }
    
    func displayButtonImage(_ image: UIImage) {
        
    }
    
    func displayStationName(_ stationName: String) {
       stationNameLabel.text = stationName
    }
    
    func displaySongName(_ songName: String) {
        
    }
    
    func displayLoading() {
        playPauseButton.isHidden = true
        activite.isHidden = false
        activite.startAnimating()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "2c3e50")
        stationNameLabel.textColor = UIColor.hexStringToUIColor(hex: "ecf0f1")
        playPauseButton.tintColor = UIColor.hexStringToUIColor(hex: "ecf0f1")
        activite.tintColor = UIColor.hexStringToUIColor(hex: "ecf0f1")
        stationImageView.clipsToBounds = true
        stationImageView.layer.masksToBounds = true
        stationImageView.layer.cornerRadius = 16
    }
    
    func displayImage(_ image: UIImage) {
        stationImageView.image = image
    }
    
    
}

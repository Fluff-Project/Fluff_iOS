//
//  NextTasteAnalysisVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class NextTasteAnalysisVC: UIViewController {

    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var followTableView: UITableView!
    var images = [UIImage(named: "2019122024421"),
        UIImage(named: "2019122022738"),
        UIImage(named: "2019122023153"),
        UIImage(named: "2019122024223"),
        UIImage(named: "2019122024353"),
        UIImage(named: "2019122024421")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialCompleteButton()
        followTableView.dataSource = self
        followTableView.delegate = self
    }
    
    private func initialCompleteButton() {
        completeButton.makeCornerRounded(radius: completeButton.frame.width / 13.6)
    }
    
    @IBAction func completeSignin(_ sender: Any) {
        guard let mainTabbarController = self.storyboard?.instantiateViewController(identifier: "WelcomeViewController") as? WelcomeViewController else { return }
        mainTabbarController.modalPresentationStyle = .fullScreen
        self.present(mainTabbarController, animated: true, completion: nil)
    }
}

extension NextTasteAnalysisVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "analysisCell") else { return UITableViewCell() }
        return cell
    }
    
}

extension NextTasteAnalysisVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? AnalysisHeaderTableViewCell else { return UIView() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 4.0
    }
}

extension NextTasteAnalysisVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fluvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "fluvCell", for: indexPath) as? FluvCollectionViewCell else { return UICollectionViewCell() }
        fluvCell.setProfile(images[indexPath.row]!)
        return fluvCell
    }
}

extension NextTasteAnalysisVC: UICollectionViewDelegate {
}

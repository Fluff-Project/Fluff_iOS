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
    
    private var isResetting: Bool?
    
    private var analysisStatus: AnalysisStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        followTableView.dataSource = self
        followTableView.delegate = self
        initialCompleteButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNaviBar()
    }
    
    func setAnalysisStatus(_ analysisStatus: AnalysisStatus) {
        self.analysisStatus = analysisStatus
    }
    
    private func setNaviBar() {
        guard let analysisStatus = self.analysisStatus else { return }
        switch analysisStatus {
        case .signup:
            self.navigationController?.navigationBar.isHidden = true
        case .recommend:
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.tintColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
            self.navigationController?.navigationBar.topItem?.title = ""
            self.setNavigationBarClear()
        case .resetting:
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func initialCompleteButton() {
        completeButton.makeCornerRounded(radius: completeButton.frame.width / 13.6)
        
        guard let analysisStatus = self.analysisStatus else { return }
        switch analysisStatus {
        case .signup:
            completeButton.setTitle("가입 완료", for: .normal)
        case .resetting:
            completeButton.setTitle("설정 완료", for: .normal)
        case .recommend:
            completeButton.isHidden = true
        }
    }
    
    @IBAction func completeSignin(_ sender: Any) {
        guard let analysisStatus = self.analysisStatus else { return }
        switch analysisStatus {
        case .signup:
            guard let mainTabbarController = self.storyboard?.instantiateViewController(identifier: "WelcomeViewController") as? WelcomeViewController else { return }
            mainTabbarController.modalPresentationStyle = .fullScreen
            self.present(mainTabbarController, animated: true, completion: nil)
        case .resetting:
            self.navigationController?.popToRootViewController(animated: true)
        case .recommend:
            return
        }
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

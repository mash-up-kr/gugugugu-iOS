//
//  HomeViewController.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/07/25.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleView: HomeTitleView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var letterWriteButton: UIButton!

    @IBAction func letterWriteButtonTouchUpInside(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Letter", bundle: nil).instantiateViewController(withIdentifier: "Letter") as? LetterViewController else { return }
        present(viewController, animated: true, completion: nil)
    }
    
    var letters: [String] = ["다람쥐", "미노스", "주의하라", "브랜"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        titleView.configure(with: "도토리")
        collectionView.reloadData()
    }

    private func setupView() {
        let coverLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(1))
        let coverItem = NSCollectionLayoutItem(layoutSize: coverLayoutSize)
        let coverGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(235), heightDimension: .absolute(360))
        let coverGroup = NSCollectionLayoutGroup.horizontal(layoutSize: coverGroupSize, subitems: [coverItem])
        let coverSectionLayout = NSCollectionLayoutSection(group: coverGroup)
        coverSectionLayout.interGroupSpacing = 24
        coverSectionLayout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        coverSectionLayout.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: coverSectionLayout)
        collectionView.setCollectionViewLayout(compositionalLayout, animated: false)
        collectionView.register(LetterCoverCell.self, forCellWithReuseIdentifier: "LetterCoverCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterCoverCell",
                                                      for: indexPath) as! LetterCoverCell
        cell.configure(date: Date(), andFromUser: letters[indexPath.item])
        cell.backgroundColor = .gray
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
}

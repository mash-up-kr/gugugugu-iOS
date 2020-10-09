//
//  LetterBoxViewController.swift
//  gugugugu
//
//  Created by juhee on 2020/07/26.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

final class LetterBoxViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare to load letters
        for index in 0...10 {
            let letter = Letter(letterID: index.description,
                                title: "다람쥐가 보내는 편지 \(index)",
                from: "다람쥐",
                to: "주희",
                content: "여러분 안녕 \n 모두들 행복한 하루가 됐으면 좋겟네",
                background: nil)
            self.letters.append(letter)
        }
        
        setupSegmentControl()
    
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var headerView: UIView!
    
    @IBOutlet weak var onlineHeight: NSLayoutConstraint!
    
    private var navigationBarHeight: CGFloat = .zero
    private var letters: [Letter] = []
    
    private lazy var segmentControl: TransparentSegmentControl = {
        let segmentControl = TransparentSegmentControl(items: ["전체", "보낸 편지", "받은 편지"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.delegate = self
        return segmentControl
    }()

}

extension LetterBoxViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.letters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "letter_box_cell", for: indexPath) as? LetterBoxTableViewCell else {
            #if DEBUG
            preconditionFailure("Can not dequeue reusableCell ")
            #else
            return UITableViewCell()
            #endif
            
        }
        // TODO:- 실제 데이터 바인딩 필요~
        let themes = LetterTheme.themes
        let theme = themes[indexPath.item % themes.count]
        tableViewCell.setContainerView(backgroundColor: theme.color)
        return tableViewCell
    }
    
    
}


extension LetterBoxViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionn) in
            self?.letters.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionn(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = UIColor(named: "darkGrey")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.letters.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        default:
            return
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 0, self.headerView.frame.height > 90 {
            self.onlineHeight.constant -= scrollView.contentOffset.y
            self.onlineHeight.constant = max(90, self.onlineHeight.constant)
            let contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
            scrollView.setContentOffset(contentOffset, animated: false)
            self.view.layoutIfNeeded()
        } else if scrollView.contentOffset.y < 0, self.headerView.frame.height < 147 {
            self.onlineHeight.constant -= scrollView.contentOffset.y
            self.onlineHeight.constant = min(147, self.onlineHeight.constant)
            let contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
            scrollView.setContentOffset(contentOffset, animated: false)
            self.view.layoutIfNeeded()
        }
    }
    
}

extension LetterBoxViewController: TransparentSegmentControlDelegate {

    func didSelectedControlChange(index: Int) {
        
    }
    
    
}


private extension LetterBoxViewController {

    
    func updateNavigationItems(hideLargeTitle: Bool) {
        // FIXME:- 누가 좀 더 깔쌈하게 바꿔줘봐바
//        if hideLargeTitle {
//            self.navigationItem.setRightBarButton(self.segmentControlBarButtonItem, animated: true)
//            self.navigationItem.setLeftBarButton(self.leftAlignmentTitleBarButtonItem, animated: true)
//            self.navigationItem.title = nil
//        } else {
//            self.navigationItem.setRightBarButton(nil, animated: true)
//            self.navigationItem.setLeftBarButton(nil, animated: true)
//            self.navigationItem.title = "편지함"
//        }
//
//        UIView.animate(withDuration: 0.2) {
//            self.filterSegmentControl.alpha = hideLargeTitle ? 0 : 1
//        }
    
    }
    
    func setupSegmentControl() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 22.0),
            segmentControl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -21.0),
            
        ])
    }
    
}

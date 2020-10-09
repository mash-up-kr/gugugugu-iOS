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
        if let navigationBarHeight = self.navigationController?.navigationBar.frame.height {
            self.navigationBarHeight = navigationBarHeight
        }
    
    }
    // FIXME: 디자인 나오면 Custom Segment Control 만들기
    @IBOutlet private weak var filterSegmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    private var navigationBarHeight: CGFloat = .zero
    private var letters: [Letter] = []
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["전체", "보낸 편지", "받은 편지"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(self.didChangeSegmentedControl(_:)), for: .valueChanged)
        return segmentControl
    }()
    private lazy var segmentControlBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(customView: self.segmentControl)
    }()
    private lazy var leftAlignmentTitleBarButtonItem: UIBarButtonItem = {
        let label = UILabel()
        label.text = self.navigationItem.title
        return UIBarButtonItem(customView: label)
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
        if let currentNavigationBarHeight = self.navigationController?.navigationBar.frame.height,
            currentNavigationBarHeight != self.navigationBarHeight {
            self.updateNavigationItems(hideLargeTitle: currentNavigationBarHeight < self.navigationBarHeight)
        }
    }
    
}


private extension LetterBoxViewController {
    
    @IBAction func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        // TODO:- 컨트롤 변경시 데이터 변경
        print("[caution] didChangeSegmentedControl \(sender.selectedSegmentIndex) ")
        [self.filterSegmentControl, self.segmentControl]
            .filter { $0 !== sender && $0?.selectedSegmentIndex != sender.selectedSegmentIndex }
            .forEach {
                $0?.selectedSegmentIndex = sender.selectedSegmentIndex
        }
    }
    
    func updateNavigationItems(hideLargeTitle: Bool) {
        // FIXME:- 누가 좀 더 깔쌈하게 바꿔줘봐바
        if hideLargeTitle {
            self.navigationItem.setRightBarButton(self.segmentControlBarButtonItem, animated: true)
            self.navigationItem.setLeftBarButton(self.leftAlignmentTitleBarButtonItem, animated: true)
            self.navigationItem.title = nil
        } else {
            self.navigationItem.setRightBarButton(nil, animated: true)
            self.navigationItem.setLeftBarButton(nil, animated: true)
            self.navigationItem.title = "편지함"
        }
        
        UIView.animate(withDuration: 0.2) {
            self.filterSegmentControl.alpha = hideLargeTitle ? 0 : 1
        }
    
    }
    
}

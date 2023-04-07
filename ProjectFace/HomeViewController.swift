//
//  HomeViewController.swift
//  ProjectFace
//
//  Created by 위대연 on 2023/04/07.
//

import UIKit
struct FaceItem {
    let path: URL
    let name: String
    let author: String
    let corverImage: UIImage?
}

class HomeViewController: UITableViewController {
    var data: [FaceItem] = [
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.indicatorStyle = .default
        tableView.register(FaceCell.self, forCellReuseIdentifier: FaceCell.reuseID)
        self.navigationItem.title = "WatchFace 공유"
        
        
        let twPath: URL = Bundle.main.url(forResource: "ddube", withExtension: "watchface")!
        data.append(.init(path: twPath, name: "2b", author: "wiwi", corverImage: nil))
        
        self.tableView.reloadData()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FaceCell.reuseID, for: indexPath) as! FaceCell
        if let item: FaceItem = self.data.getItem(index: indexPath.row) {
            cell.imageView?.image = item.corverImage
            cell.topLabel.text = item.name
            cell.bottomLabel.text = item.author
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemVC: ItemInfoViewController = .init()
        if let item: FaceItem = self.data.getItem(index: indexPath.row) {
            itemVC.item = item
        }
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
}

class FaceCell: UITableViewCell {
    static let reuseID: String = .init(describing: FaceCell.self)
    // 셀의 속성을 추가합니다.
    let customImageView = UIImageView()
    let topLabel = UILabel()
    let bottomLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 셀의 뷰 계층 구조를 설정합니다.
        addSubview(customImageView)
        addSubview(topLabel)
        addSubview(bottomLabel)

        // 이미지 뷰를 구성합니다.
        customImageView.contentMode = .scaleAspectFit
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        customImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 96).isActive = true

        // 상단 레이블을 구성합니다.
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16).isActive = true
        topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        // 하단 레이블을 구성합니다.
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 4).isActive = true
        bottomLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = nil
        self.topLabel.text = nil
        self.bottomLabel.text = nil
    }
}


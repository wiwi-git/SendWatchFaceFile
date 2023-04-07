//
//  ItemInfoVC.swift
//  ProjectFace
//
//  Created by 위대연 on 2023/04/07.
//
import UIKit
import ClockKit
import WatchConnectivity

class ItemInfoViewController: UIViewController {
    var item: FaceItem?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Loading"
        return label
    }()

    let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Loading"
        return label
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("내 애플워치에 넣기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Item Info"

        // 뷰 계층 구조를 구성합니다.
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(topLabel)
        scrollView.addSubview(bottomLabel)
        scrollView.addSubview(textView)
        view.addSubview(button)

        // Auto Layout을 설정합니다.
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor),

            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            topLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            topLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            topLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            bottomLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            bottomLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),

            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])

        // topLabel과 bottomLabel의 높이를 계산하여 Auto Layout 제약 조건을 추가합니다.
        let labelHeight = max(topLabel.intrinsicContentSize.height, bottomLabel.intrinsicContentSize.height)
        NSLayoutConstraint.activate([
            topLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            bottomLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let item {
            print("아이템이 설정됨", item)
            DispatchQueue.main.async {                
                self.imageView.image = item.corverImage
                self.topLabel.text = item.name
                self.bottomLabel.text = item.author
                self.textView.text = """

그냥 설명 글

"""
            }
        } else {
            print("아이템이 설정되지 않았어")
        }
    }

    @objc func buttonTapped() {
        guard let item = item else { return }
//        guard verifyAppleWatchConnection() else {
//            let alert: UIAlertController = .init(title: "경고", message: "아이폰과 애플워치를 연결한후 시도해주세요", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "ok", style: .default))
//            self.present(alert, animated: true)
//            return
//        }
        let library = CLKWatchFaceLibrary()
        library.addWatchFace(at: item.path) { (error: Error?) in
            print(error)
        }
    }
    
    func verifyAppleWatchConnection() -> Bool {
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isPaired && session.isWatchAppInstalled {
                return true
            }
        }
        return false
    }
}

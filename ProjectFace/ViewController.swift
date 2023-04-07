//
//  ViewController.swift
//  ProjectFace
//
//  Created by 위대연 on 2023/04/07.
//

import UIKit
class ViewController: UIViewController {
    let homeViewController: HomeViewController = .init()
    lazy var navigation: UINavigationController = MainNaivationController(rootViewController: homeViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(navigation)
        view.addSubview(navigation.view)
        navigation.didMove(toParent: self)
    }
}

class MainNaivationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension UIView {
    enum Contraint {
        case top;
        case leading;
        case trailing;
        case bottom;
    }
    func sameParentConstraint(directions: Contraint ...) {
        guard let parent = self.superview else { return }
        for direction in directions {
            let anchor: NSLayoutConstraint
            switch direction {
            case .top: anchor = self.topAnchor.constraint(equalTo: parent.topAnchor)
            case .leading: anchor = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
            case .bottom: anchor =  self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            case .trailing: anchor =  self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
            }
            
            anchor.isActive = true
        }
    }
}
extension Array {
    func getItem(index: Int) -> Element? {
        guard self.count > index else { return nil }
        return self[index]
    }
}



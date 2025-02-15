//
//  ChangeLangViewController.swift
//  Curify
//
//  
//

import UIKit
import PanModal

//struct Mode {
//    let image: UIImage
//    let name: String
//    let mode: AppMode
//}

//enum AppMode {
//    case dark
//    case light
//    case system
//}

var languages: [Language] = [
    Language(image: Images.en!, name: "english".translate(), language: .English),
    Language(image: Images.uz!, name: "uzbek".translate(), language: .Uzbek)
]

//let modes: [Mode] = [
//    Mode(image: UIImage(systemName: "cloud.moon")!, name: "dark".translate(), mode: .dark),
//    Mode(image:  UIImage(systemName: "sun.max")!, name: "light".translate(), mode: .light),
//    Mode(image:  UIImage(systemName: "iphone.gen1")!, name: "system".translate(), mode: .system)
//]

class ChangeLangViewController: BaseViewController {
    
    var contentHeight = 150.0
    lazy var subView = SubView(frame: .zero)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ChangeLangTableViewCell.self, forCellReuseIdentifier: String(describing: ChangeLangTableViewCell.self))
        return tableView
    }()
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setContentHeight()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        configure()
    }
    
    private func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setContentHeight() {
        self.contentHeight = tableView.contentSize.height
        self.panModalSetNeedsLayoutUpdate()
        self.panModalTransition(to: .shortForm)
    }
    
    override func languageDidChange() {
        languages = [
            Language(image: Images.en!, name: "english".translate(), language: .English),
            Language(image: Images.uz!, name: "uzbek".translate(), language: .Uzbek)
        ]
        tableView.reloadData()
    }
    
}

extension ChangeLangViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChangeLangTableViewCell.self), for: indexPath) as? ChangeLangTableViewCell else { return UITableViewCell() }
        cell.isChosen = indexPath.row == getChosenIndex()
        cell.setData(model: languages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...1 {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: indexPath.section)) as? ChangeLangTableViewCell {
                cell.isChosen = false
            }
        }
        guard let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as? ChangeLangTableViewCell else { return }
        Vibration.light.vibrate()
        cell.isChosen.toggle()
        if cell.isChosen {
            let language = languages[indexPath.row]
            LanguageManager.setApplLang(language.language)
            tableView.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name("ChangeTabBar"), object: nil)
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
            dismiss(animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        //        header.textLabel?.frame = CGRect(x: view.bounds.origin.x + 20, y: view.bounds.origin.y, width: 100, height: view.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "selectLanguage".translate()
    }
    
    func getChosenIndex() -> Int {
        let language = LanguageManager.getAppLang()
        var index = language == .English ? 0 : 1
        return index
    }
}

extension ChangeLangViewController: PanModalPresentable {
    
    var shortFormHeight: PanModalHeight {
        if contentHeight > UIWindow().bounds.height {
            return .maxHeight
        }
        return .contentHeight(contentHeight)
    }
    
    var longFormHeight: PanModalHeight {
        if contentHeight > UIWindow().bounds.height {
            return .maxHeight
        }
        return .contentHeight(150)
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.5)
    }
}

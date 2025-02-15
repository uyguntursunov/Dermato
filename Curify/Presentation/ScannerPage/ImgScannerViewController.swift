//
//  ImgScannerViewController.swift
//  Curify
//
//
//

import UIKit

var scanTutorials: [Instruction] = [
    Instruction(title: "scanTutorial1".translate(), image: Images.step1!),
    Instruction(title: "scanTutorial2".translate(), image: Images.step2!),
    Instruction(title: "scanTutorial3".translate(), image: Images.step3!)
]

class ImgScannerViewController: BaseViewController {
    
    var responseTitle: String?
    var imgData: Data?
    var date: String?
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var cameraButton: CameraButtonView = {
        let view = CameraButtonView(frame: .zero)
        view.layer.cornerRadius = 35
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        view.addGestureRecognizer(gestureRecognizer)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ScanTutorialTableViewCell.self, forCellReuseIdentifier: String(describing: ScanTutorialTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        initViews()
    }
    
    @objc func cameraTapped() {
        showCameraAlert()
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func showCustomAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let attributedMessage = message.attributedStringFromMarkdown()
        alertController.setAttributedMessage(attributedMessage)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func uploadImage(image: UIImage, lang: String) {
        showLoadingView()
        API.shared.uploadImage(image: image, lang: lang) { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(let data):
                self?.dismissLoadingView()
                if let response = data.response, let imgData = self?.imgData, let date = self?.date {
                    self?.showCustomAlert(title: "success".translate(), message: response)
                    self?.showAlert(title: "success".translate(), message: response)
                    self?.saveScan(model: Scan(title: response, image: imgData, date: date))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initViews() {
        title = "scanner".translate()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(cameraButton)
        cameraButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70)
        }
    }
    
    func showCameraAlert() {
        let alert = UIAlertController(title: "imageSelection".translate(), message: "imageSource".translate(), preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "camera".translate(), style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "photoAlbum".translate(), style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "cancel".translate(), style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNotesAlert() {
        let alert = UIAlertController(title: "additionalNotes".translate(), message: "enterAdditionalNotes".translate(), preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func languageDidChange() {
        title = "scanner".translate()
        scanTutorials = [
            Instruction(title: "scanTutorial1".translate(), image: Images.step1!),
            Instruction(title: "scanTutorial2".translate(), image: Images.step2!),
            Instruction(title: "scanTutorial3".translate(), image: Images.step3!)
        ]
        tableView.reloadData()
    }
}

extension ImgScannerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scanTutorials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScanTutorialTableViewCell.self), for: indexPath) as? ScanTutorialTableViewCell else { return UITableViewCell()}
        cell.setData(model: scanTutorials[indexPath.row], num: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        //        header.textLabel?.frame = CGRect(x: view.bounds.origin.x + 20, y: view.bounds.origin.y, width: 100, height: view.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "tutorials".translate()
    }
    
}

extension ImgScannerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) { [weak self] in
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //            self?.showNotesAlert()
            DispatchQueue.main.async {
                guard let imageData = image.jpegData(compressionQuality: 1), let date = self?.getDate(), let lang = self?.getCurrentLanguage()  else {
                    print("jpg error")
                    return
                }
                
                self?.imgData = imageData
                self?.date = date
                
                self?.uploadImage(image: image, lang: lang)
            }
            
            //Setting image to your image view
            //                self?.profileImgView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveScan(model: Scan) {
        DataPersistanceManager.shared.saveScan(model: model) { result in
            switch result {
            case .success(()):
                print("Successfully saved")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, MMMM dd"
        let result = formatter.string(from: date)
        return result
    }
}

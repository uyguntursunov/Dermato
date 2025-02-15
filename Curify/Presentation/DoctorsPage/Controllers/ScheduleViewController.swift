//
//  ScheduleViewController.swift
//  Curify
//
//  
//

import UIKit

protocol ScheduleViewControllerDelegate: AnyObject {
    func textFieldDidChange(index: Int, text: String)
    func didSlectDate(date: String)
    func didAgree(isAgree: Int)
}

class ScheduleViewController: BaseViewController {

    var doctorModel: DoctorModel?
    let icons = ["person", "phone", "calendar", "clock", "list.clipboard", "circle"]
    let placeholders = ["Name", "Contact number", "Date", "Duration (mins)", "Purpose of appointment", ""]
    
    var name: String = ""
    var contact: String = ""
    var date: String = ""
    var duration: String = ""
    var purpose: String = ""
    var isAgree: Int = 0
    var completions: [Bool] = []
    
    lazy var subView = SubView(frame: .zero)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: String(describing: ScheduleTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
    }
    
    @objc func doneButtonPressed() {
        if let id = doctorModel?.id {
            print("xxx", id, name, contact, date, duration, isAgree)
            API.shared.scheduleAppointment(model: AppointmentModel(doctor_id: String(describing: id), name: name, phone_number: contact, date: date, from_time: date, to_time: duration, purpose: purpose, agree: "\(isAgree)")) {[weak self] result in
                switch result {
                case .success(_):
                    self?.showAlert(title: "Success", message: "You have successfully scheduled an appointment!")
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self?.showAlert(title: "Error", message: "Something went wrong")
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func initViews() {
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Enter the details"
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true)
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScheduleTableViewCell.self), for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.index = indexPath.row
        cell.isDate = indexPath.row == 2 ? true : false
        cell.isLast = indexPath.row == 5 ? true : false
        if indexPath.row == 5 { cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0) }
        cell.setData(imageString: icons[indexPath.row], placeholder: placeholders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 5 ? 100 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension ScheduleViewController: ScheduleViewControllerDelegate {
    func didAgree(isAgree: Int) {
        self.isAgree = isAgree
    }
    
    func didSlectDate(date: String) {
        self.date = date
    }
    
    func textFieldDidChange(index: Int, text: String) {
        
        switch index {
        case 0:
            name = text
            completions.append(true)
        case 1:
            contact = text
            completions.append(true)
        case 3:
            duration = text
            completions.append(true)
        case 4:
            purpose = text
            completions.append(true)
        default:
            break
        }
    }
}

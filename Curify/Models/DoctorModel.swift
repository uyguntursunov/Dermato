//
//  DoctorModel.swift
//  Curify
//
//  
//

import UIKit

struct DoctorTypeModel: Codable {
    let id: String?
    let type: String?
    let Doctor: [DoctorModel]?
}

struct DoctorModel: Codable {
    let id: Int?
    let name: String?
    let workplace: String?
    let work_hours: String?
    let type: String?
    let phone_number: String?
    let rating: Float?
    let photo: String?
}

struct AppointmentModel: Codable {
    let doctor_id: String?
    let name: String?
    let phone_number: String?
    let date: String?
    let from_time: String?
    let to_time: String?
    let purpose: String?
    let agree: String?
}

struct Resultt: Codable {
    let message: String?
}

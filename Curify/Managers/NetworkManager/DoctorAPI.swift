//
//  DoctorAPI.swift
//  Curify
//
//  
//

import UIKit
import Alamofire

extension API {

    func getDoctors(completion: @escaping (Result<[DoctorTypeModel], Error>) -> Void) {
        let url = API_URL_GET_ALL_DOCTORS
        let headers = Token.getToken()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([DoctorTypeModel].self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func scheduleAppointment(model: AppointmentModel, completion: @escaping (Result<Resultt, Error>) -> Void) {
        let url = API_URL_SCHEDULE_APPPOINTMENT
//        let headers = Token.getToken()
        
        let parameters: [String: String?] = [
            "doctor_id": model.doctor_id,
            "name": model.name,
            "phone_number": model.phone_number,
            "date": model.date,
            "from_time": model.from_time,
            "to_time": model.to_time,
            "purpose": model.purpose,
            "agree": model.agree
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(Resultt.self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func searchDoctor(query: String, completion: @escaping (Result<[DoctorModel], Error>) -> Void) {
        let url = API_URL_SEARCH_DOCTOR + query
        let parameters: [String: String] = [
            "name": query
        ]
        
        let headers = Token.getToken()
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([DoctorModel].self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

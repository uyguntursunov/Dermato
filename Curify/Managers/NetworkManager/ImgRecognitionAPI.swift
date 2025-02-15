//
//  ImgRecognitionAPI.swift
//
//
//  
//

import UIKit
import Alamofire

extension API {
    
    func uploadImage(image: UIImage, lang: String, completion: @escaping(Result<ResponseModel, Error>) -> Void) {
        //        let url = API_URL_UPLOAD_IMAGE + lang
        
        let url = API_URL_UPLOAD_IMAGE
        
        guard let imgData = image.jpegData(compressionQuality: 0.2) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image", fileName: "file.jpg", mimeType: "image/jpeg")
        }, to: url)
        .response { resp in
            switch resp.result {
            case .success(let data):
                //                upload.responseJSON { response in
                //                    print(response.result.value)
                //                }
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ResponseModel.self, from: data!)
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
    

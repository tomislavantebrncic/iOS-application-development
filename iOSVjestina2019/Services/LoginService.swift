import Foundation

class LoginService {
    
    func login(username: String, password: String, completion: @escaping ((Bool) -> Void)) {
        let url = URL(string: "https://iosquiz.herokuapp.com/api/session")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    completion(false)
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                completion(false)
                return
            }
            
            do {
                let responseString = String(data: data, encoding: .utf8)
                print(responseString)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict = json as? [String: String],
                    let token = jsonDict["token"],
                    let userId = jsonDict["user_id"] {
                    print(token, userId)
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.set(userId, forKey: "user_id")
                }
            } catch {
                completion(false)
            }
            
            completion(true)
        }
        
        task.resume()
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

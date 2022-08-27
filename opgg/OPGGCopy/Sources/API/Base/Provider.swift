//
//  Provider.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Alamofire
import Combine

final class Provider<Target: BaseTarget> {

    private static func createRequest(_ target: Target) throws -> URLRequest? {
        guard let url = target.baseURL?.appendingPathComponent(target.path) else {
            return nil
        }
        var request = try URLRequest(url: url, method: target.method)
        target.headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return try target.encoding.encode(request, with: target.parameter)
    }
    
    func request(_ target: Target) -> AnyPublisher<Result<Response, APIError>, Never> {
        Future<Result<Response, APIError>, Never> { promise in
            guard let request = try? Self.createRequest(target) else {
                let error = APIError.custom(message: "APIError", debugMessage: "Request가 제대로 생성되지 않았습니다.")
                promise(.success(.failure(error)))
                return
            }
            
            AF.request(request)
                .response { dataResponse in
                    switch (dataResponse.response, dataResponse.data, dataResponse.error) {
                    case let (.some(urlResponse), data, .none):
                        let response = Response(statusCode: urlResponse.statusCode, data: data ?? Data(), request: request, response: urlResponse)
                        promise(.success(.success(response)))

                    case let (.some(urlResponse), _, .some(error)):
                        let response = Response(statusCode: urlResponse.statusCode, data: Data(), request: request, response: urlResponse)
                        let apiError = APIError.underlying(error: error, response: response)
                        promise(.success(.failure(apiError)))

                    case let (_, _, .some(error)):
                        let apiError = APIError.underlying(error: error, response: nil)
                        promise(.success(.failure(apiError)))

                    default:
                        let apiError = APIError.underlying(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), response: nil)
                        promise(.success(.failure(apiError)))
                    }
                }
        }.eraseToAnyPublisher()
    }
}

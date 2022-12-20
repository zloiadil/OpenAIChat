//
//  APICaller.swift
//  OpenAIChat
//
//  Created by Адиль Бектурсунов on 20.12.2022.
//
import OpenAISwift
import Foundation


final class APICalller {
    static let shared = APICalller()
    
    @frozen enum Constant  {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constant.key)
    }
    
    public func getResponse(input: String, completion: @escaping (Result <String, Error>) -> Void) {
        client?.sendCompletion(with: input,completionHandler: { result in
            switch result {
            case  .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let  error):
                completion(.failure(error))
            }
        })
    }
    
}

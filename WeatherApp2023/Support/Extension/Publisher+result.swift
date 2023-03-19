//
//  Publisher+result.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import Combine

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}

//
//  UserDetailPresenter.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class UserDetailPresenter {
    
    weak var view: UserDetailPresenterOutput?
    private let router: UserDetailRouterProtocol
    private let interactor: UserDetailInteractorInput
    private let dateFormatter: DateFormatter
    
    init(router: UserDetailRouter,
         view: UserDetailPresenterOutput,
         interactor: UserDetailInteractorInput,
         dateFormatter: DateFormatter = DateFormatter()) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dateFormatter = dateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        interactor.attach(self)
    }
    
    private func handleResult<T>(result: (Result<T, Error>)) throws -> T {
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    private func buildUserDetailCellConstructor(_ data: UserDetailResponseModel) -> UserDetailCellConstructor {
        .init(item: .init(avatarUrlString: data.avatarUrlString,
                          userName: data.userName,
                          userLogin: data.userLogin,
                          userRegisterString: ["Register date".localized,
                                               dateFormatter.string(from: data.userRegisterDate)]
            .joined(separator: ": "),
                          onGetImage: { [weak interactor] url, completion in
            interactor?.imageLoadingService.loadImage(with: url,
                                                      completion: { result in
                completion(try? result.get())
            })
        }))
    }
    
    private func buildRespositoryConstructor(_ data: UserRepositoryResponseModel) -> UserRepositoryCellConstructor {
        .init(item: .init(language: data.language,
                          forksCount: data.forksCount.description,
                          forksDescription: "Forks".localized,
                          watchersCount: data.watchers.description,
                          watchersDescription: "Watchers".localized,
                          description: data.description,
                          name: data.name))
    }
    
}

extension UserDetailPresenter: UserDetailPresenterInput {
    
    func viewDidLoad() {
        view?.showLoader()
        interactor.fetchData()
    }
    
}

extension UserDetailPresenter: UserDetailInteractorOutput {
    func didRecieveResponses(userDetailCompletion: (() -> (Result<UserDetailResponseModel, Error>))?,
                             userReposCompletion: (() -> (Result<[UserRepositoryResponseModel], Error>))?) {
        defer { view?.hideLoader() }
        guard let detailResponse = userDetailCompletion?(),
              let repositoryResponse = userReposCompletion?() else {
            return
        }
        do {
            let details = try handleResult(result: detailResponse)
            let repos = try handleResult(result: repositoryResponse)
            
            view?.reloadData(with: [buildUserDetailCellConstructor(details)] + repos.map(buildRespositoryConstructor(_:)))
        } catch {
            router.showAlert(title: "Something went wrong".localized,
                             message: error.description,
                             actions: [.init(title: "Ok".localized,
                                             style: .default) { [weak router] _ in
                router?.pop()
            }])
        }
    }
}

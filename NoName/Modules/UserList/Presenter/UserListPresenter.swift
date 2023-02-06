//
//  UserListPresenter.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class UserListPresenter {
    
    weak var view: UserListPresenterOutput?
    private let router: UserListRouterProtocol
    private let interactor: UserListInteractorInput
    
    private var userConstructors: [UserElementCellConstructor] = []
    
    init(router: UserListRouterProtocol,
         view: UserListPresenterOutput,
         interactor: UserListInteractorInput) {
        self.view = view
        self.router = router
        self.interactor = interactor
        interactor.attach(self)
    }
    
    func mapResponse(response: [UserResponseModel]) -> [UserElementCellConstructor] {
        
        response.map { element in
            UserElementCellConstructor(item: makeUserListElementModel(element))
                .onPrefetch { [weak interactor] in
                    URL(string: element.avatarUrlString)
                        .map { interactor?.imageLoadingService.loadImage(with: $0,
                                                                         completion: { _ in  }) }
                }
                .onTap { [weak router] in
                    router?.showUserDetailModule(login: element.userLogin)
                }
        }
    }
    
    private func fetchMoreIfNeeded(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y + scrollView.bounds.height > scrollView.contentSize.height -  scrollView.bounds.height else { return }

        userConstructors
            .map(\.item.id)
            .max()
            .map(interactor.fetchUsers(since:))
    }
    
    private func makeUserListElementModel(_ element: UserResponseModel) -> UserListElementViewModel {
        .init(name: ["Login".localized,
                     element.userLogin].joined(separator: ": "),
              id: element.userId,
              idDescription: ["ID".localized,
                              element.userId.description].joined(separator: ": "),
              avatarUrl: element.avatarUrlString,
              onGetImage: { [weak interactor] url, completion in
            interactor?.imageLoadingService.loadImage(with: url) { result in
                completion(try? result.get())
            }
        },
              onReuse: { [weak interactor] url in
            interactor?.imageLoadingService.cancel(url: url)
        })
    }
    
}

extension UserListPresenter: UserListPresenterInput {
    
    func didPullToRefresh() {
        interactor.cancelUsersLoadingTask()
        userConstructors.removeAll()
        interactor.fetchUsers()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        fetchMoreIfNeeded(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        fetchMoreIfNeeded(scrollView)
    }
    
    func viewDidLoad() {
        view?.showLoader()
        interactor.fetchUsers()
    }
    
}

extension UserListPresenter: UserListInteractorOutput {
    func didRecieveUserList(_ result: Result<[UserResponseModel], Error>, since: Int) {
        defer {
            view?.hideLoader()
        }
        switch result {
        case .success(let response):
            userConstructors.append(contentsOf: mapResponse(response: response))
            view?.reloadData(with: userConstructors)
        case .failure(let error):
            router.showAlert(title: "Something went wrong".localized,
                            message: error.description,
                            actions: [.init(title: "Try again".localized,
                                            style: .default) { [weak interactor] _ in
                interactor?.fetchUsers(since: since)
            },
                                      .init(title: "Cancel".localized,
                                            style: .cancel)])
        }
    }
    
}

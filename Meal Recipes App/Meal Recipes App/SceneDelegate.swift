//
//  SceneDelegate.swift
//  Meal Recipes App
//
//  Created by Amin faruq on 01/11/22.
//

import os
import UIKit
import Combine
import CoreData
import Meal_Recipes
import Meal_Recipes_iOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var scheduler: AnyDispatchQueueScheduler = DispatchQueue(
        label: "co.id.aminfaruq.infra.queue",
        qos: .userInitiated,
        attributes: .concurrent
    ).eraseToAnyScheduler()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var baseURL = URL(string: "https://www.themealdb.com/api/json")!

    private lazy var navigationController = UINavigationController(
        rootViewController: CategoriesUIComposer.categoryComposedWith(
            categoryLoader: makeRemoteFeedLoader,
            imageLoader: makeLocalImageLoaderWithRemoteFallback)
    )
    
    convenience init(httpClient: HTTPClient, scheduler: AnyDispatchQueueScheduler) {
        self.init()
        self.httpClient = httpClient
        self.scheduler = scheduler
    }
    
    private lazy var logger = Logger(subsystem: "co.id.aminfaruq.Meal-Recipes-App", category: "main")


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
        
    }
    
    func configureWindow() {
        //MARK: Compose essential feed
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
    }
    
    
    private func makeRemoteFeedLoader() -> AnyPublisher<[RemoteCategory], Error> {
        let url = CategoriesEndPoint.get.url(baseURL: baseURL)
        return httpClient
            .getPublisher(url: url)
            .tryMap(CategoriesMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> CategoryImageDataLoader.Publisher {
        return httpClient
            .getPublisher(url: url)
            .tryMap(CategoryImageDataMapper.map)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }


}


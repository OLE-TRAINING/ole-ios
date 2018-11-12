//
//  CategoriesViewModel.swift
//  LocadoraOleTraining
//
//  Created by Marcelo Mendes on 09/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class CategoriesViewModel: NSObject {

    var pages = [String]()

    func fetchCategories(completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.pages = ["Ação", "Comédia"]
            completion(self?.pages ?? [])
        })
    }

}

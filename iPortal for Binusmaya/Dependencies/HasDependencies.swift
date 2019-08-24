//
//  HasDependencies.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 24/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit

public protocol HasDependencies {
    var dependencies: Dependency { get }
}

public extension HasDependencies {
    var dependencies: Dependency {
        return DependencyInjector.dependencies
    }
}

struct DependencyInjector {
    static var dependencies: Dependency = CoreDependencies()
    private init () {}
}

public extension UIApplicationDelegate {
    func configure(dependency: Dependency) {
        DependencyInjector.dependencies = dependency
    }
}

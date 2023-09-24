//  swift-tools-version: 5.4
//
//  Package.swift
//  Feige
//
//  Created by William Towe on 9/23/23.
//  Copyright © 2023 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import PackageDescription

let package = Package(
    name: "Feige",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Feige",
            targets: ["Feige"]),
    ],
    dependencies: [
            // other dependencies
            .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Feige",
            path: "Feige"),
        .testTarget(
            name: "FeigeTests",
            dependencies: ["Feige"],
            path: "FeigeTests"),
    ]
)

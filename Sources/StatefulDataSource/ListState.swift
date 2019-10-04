//
//  ListState.swift
//  StatefulDataSource
//
//  Created by Eugène Peschard on 04/10/2019.
//  Copyright © 2019 pesch.app All rights reserved.
//

import Foundation

/**
 Represents the different states that a list can be in

 - Loading: The data is being remotely fetched.
 - Loaded:  The data is loaded and ready to be shown to the user
 - Failure: The data failed to load and an error is shown to the user
 */
public enum ListState<T> {
    case loading
    case loaded(data: [T])
    case failure(error: Error)
}

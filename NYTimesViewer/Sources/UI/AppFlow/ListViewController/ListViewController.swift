//
//  ListViewController.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

class ListViewController<Event, ViewModel: ListViewModel<Event>, View: ListView<Event, ViewModel>>: BaseViewController<View, ViewModel> {

}
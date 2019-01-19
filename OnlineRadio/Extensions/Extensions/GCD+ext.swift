//  DealApp
//
//  Created by Egor Sakhabaev on 11.04.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
func delay(delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

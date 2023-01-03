//
//  BackgroundView.swift
//  Music
//
//  Created by 清水健司 on 2023/01/04.
//

import SwiftUI

struct BackgroundView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName).resizable().ignoresSafeArea().scaledToFill()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(imageName: "background")
    }
}

//
//  SwiftUIView.swift
//  SneakerApp
//
//  Created by Dung  on 24.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//
import UIKit
import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
            Text("Hello World").fontWeight(.bold).multilineTextAlignment(.leading)
       
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

class SecondViewHostingController: UIHostingController<SwiftUIView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SwiftUIView())
    }
}




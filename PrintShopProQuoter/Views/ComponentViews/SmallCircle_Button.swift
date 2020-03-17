//
//  SmallCircle_Button.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/16/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct SmallCircle_Button: View {
	
	private var imageName: String
	
	init(imageName:String){
		self.imageName = imageName
	}
	
	var body: some View {
		ZStack {
			
			GradientBackground().mask(Circle())
				.padding()
				.frame(width: 100, height: 100, alignment: .center)
				.shadow(color: Color(UIColor(cgColor: LightBlueHue_DEFAULT)), radius: 5, x: 5, y: 5)
				.opacity(0.35)
				.shadow(color: Color(UIColor(cgColor: DarkBlueHue_DEFAULT)), radius: 5, x: -5, y: -5)
			
			Image(systemName: imageName)
				.foregroundColor(.white)
		}
	}
}

struct smallCircle_ButtonPreview: PreviewProvider {
	
	static var previews : some View {
		
		ZStack{
			GradientBackground()
		SmallCircle_Button(imageName: "folder")
		}
		.frame(width: 100, height: 100, alignment: .center)
		.previewLayout(.sizeThatFits)
	}
}

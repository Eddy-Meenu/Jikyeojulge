//
//  MedicalInputDetailView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/14.
//

import SwiftUI

struct MedicalInputDetailView: View {
    var directInput: PhotoDirectInputEntity

    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Image(uiImage: UIImage(data: directInput.photo!)!)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 50)
                HStack {
                    Text(directInput.medicalTitle ?? "")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text(directInput.descriptions ?? "")
                        .font(.system(size: 16))
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 50)
        }
    }
}

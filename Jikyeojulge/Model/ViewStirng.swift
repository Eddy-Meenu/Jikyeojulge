//
//  MainViewComponent.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/09.
//

import Foundation

struct MainViewComponent {
    let name =  "이름"
    let birth = "생년월일"
    let bloodType = "혈액형"
    let contact = "비상연락처"
}

struct OnboardingComponent {
    let title = ["1단계", "2단계", "3단계", "4단계", "5단계", "6단계"]
    let description = ["배경화면의 빈 공간을 진동이 느껴질 때까지 꾹 눌러주세요.",
                       "가장 왼쪽 화면으로 이동해주세요.",
                       "화면 좌측 상단의 (+) 버튼을 눌러주세요.",
                       "'지켜줄게'위젯을 검색창에 입력하고, 검색 결과를 클릭해주세요.",
                       "위젯 추가하기를 클릭해주세요.",
                       "완료 버튼 또는 배경화면을 클릭해주세요.", ""]
    let imageName = ["배경화면",
                     "위젯전용화면",
                     "위젯제공화면",
                     "위젯전용화면",
                     "위젯선택화면",
                     "위젯설치완료"]
}

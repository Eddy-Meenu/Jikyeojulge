//
//  MedicineModel.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/06/29.
//

struct MedicineJSON: Codable {
    let header: MedicineHeader?
    let body: MedicineModel?
}

struct MedicineHeader: Codable {
    let resultCode: String?
    let resultMsg: String?
}

struct MedicineModel: Codable {
    let pageNo: Int?
    let totalCount: Int?
    let numOfRows: Int?
    let items: [Medicine]?
}

struct Medicine: Codable {
    let entpName: String? // 업체명
    let itemName: String? // 제품명
    let itemSeq: String? // 품목기준코드
    let efcyQesitm: String? // 문항1(효능)
    let useMethodQesitm: String? // 문항2(사용법)
    let atpnWarnQesitm: String? // 문항3(주의사항경고)
    let atpnQesitm: String? // 문항4(주의사항)
    let intrcQesitm: String? // 문항5(상호작용)
    let seQesitm: String? // 문항6(부작용)
    let depositMethodQesitm: String? // 문항7(보관법)
    let openDe: String? // 공개일자
    let updateDe: String? // 수정일자
    let itemImage: String? // 낱알이미지
}

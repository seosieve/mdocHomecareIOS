//
//  EducationViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/11/25.
//

import Foundation

class EducationViewModel {
    func makeEducation(_ selectedHashTagArr: [String]) -> [Education] {
        var education = [Education]()
        if selectedHashTagArr.contains("전체") {
            for i in 0..<educationArr.count {
                education.append(Education(i))
            }
        } else {
            for i in 0..<educationArr.count {
                if selectedHashTagArr.contains(educationArr[i].4) {
                    education.append(Education(i))
                }
            }
        }
        return education
    }
}

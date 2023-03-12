//
//  SettingModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import Foundation

struct ViewMore {
    var image: ImageAsset.Image
    var title: String
//    var info: String
    
    var topComponent = [
        (Asset.SettingIcons.genderIcon.image, "성별"),
        (Asset.SettingIcons.birthdayIcon.image, "생년월일"),
        (Asset.SettingIcons.patientIcon.image, "환자번호")]

    var midComponent = [
        (Asset.SettingIcons.oldphoneIcon.image, "휴대 전화 번호")]
    
    init(_ section: Int, _ index: Int, userData: String) {
        
        if section == 0 {
            self.image = topComponent[index].0
            self.title = topComponent[index].1
        } else {
            self.image = midComponent[index].0
            self.title = midComponent[index].1
        }
    }
}

struct PostSetting {
    var image: ImageAsset.Image
    var title: String
    
    var bottomComponent = [
        (Asset.SettingIcons.notiIcon.image, "알림"),
        (Asset.SettingIcons.settingIcon.image, "설정")
    ]
    
    init(_ index: Int) {
        self.image = bottomComponent[index].0
        self.title = bottomComponent[index].1
    }
}

struct Setting {
    var image: ImageAsset.Image
    var title: String
    var color = Colors.Text.mainContent
    var divider = false
    var type = 3
    
    var topComponent = [
        (Asset.SettingIcons.notiIcon.image, "푸시알림 설정"),
        (Asset.SettingIcons.editIcon.image, "비밀번호 변경")]
    
    var midComponent = [
        (Asset.SettingIcons.termIcon.image, "서비스 이용약관"),
        (Asset.SettingIcons.privacyIcon.image, "개인정보 보호 정책"),
        (Asset.SettingIcons.versionIcon.image, "버전 정보")]
    
    var bottomComponent = [
        (Asset.SettingIcons.signoutIcon.image, "로그아웃"),
        (Asset.SettingIcons.resignIcon.image, "서비스 탈퇴")
    ]
    
    init(_ section: Int, _ index: Int) {
        if section == 0 {
            self.image = topComponent[index].0
            self.title = topComponent[index].1
            self.divider = true
            if index == 0 {
                self.type = 1
            }
        } else if section == 1 {
            self.image = midComponent[index].0
            self.title = midComponent[index].1
            if index == midComponent.count-1 {
                self.divider = true
                self.type = 2
            }
        } else {
            self.image = bottomComponent[index].0
            self.title = bottomComponent[index].1
            if index == 0 {
                self.color = Colors.Semantic.warningRed
            }
            if index == 1 {
                self.color = Colors.Default.gray4
            }
            if index == bottomComponent.count-1 {
                self.divider = true
            }
        }
    }
}

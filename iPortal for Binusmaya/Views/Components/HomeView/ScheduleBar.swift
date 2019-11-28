//
//  ScheduleBar.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

protocol SchedulesBarProtocol {
    
}

class SchedulesBar {
    private var scheduleRepository: ScheduleRepository
    
    init () {
        self.scheduleRepository = ScheduleRepository()
    }
    
    func render () -> ASLayoutSpec {
        let schedulesStackNode = self.scheduleBarContent()
        
        schedulesStackNode.children = [
            self.scheduleBarHeader(),
            self.scheduleBarContent()
        ]
        
        let scheduleBarInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let scheduleBarWrapper = ASInsetLayoutSpec(insets: scheduleBarInset, child: schedulesStackNode)
        
        return scheduleBarWrapper
    }
    
    func scheduleBarHeader() -> ASLayoutSpec {
        let scheduleBarHeaderIcon = ASImageNode()
        
        let scheduleBarHeaderTextNode = ASTextNode()
        let scheduleBarHeaderTextNodeAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: Fonts.headerFont,
            NSAttributedString.Key.foregroundColor: Colors.primaryColor
        ]
        scheduleBarHeaderTextNode.attributedText = NSAttributedString(
            string: "4 kelas",
            attributes: scheduleBarHeaderTextNodeAttribute
        )
        
        let scheduleHeaderStackNode = ASStackLayoutSpec()
        scheduleHeaderStackNode.direction = .horizontal
        scheduleHeaderStackNode.justifyContent = .start
        
        scheduleHeaderStackNode.children = [
            scheduleBarHeaderIcon,
            scheduleBarHeaderTextNode
        ]
        
        return scheduleHeaderStackNode
    }

    func scheduleBarDate (_ courseTime: String) -> ASTextNode {
        let dateTextNode = ASTextNode()
        let dateTextNodeAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 18)!
        ]
        dateTextNode.attributedText = NSAttributedString(
            string: courseTime,
            attributes: dateTextNodeAttribute
        )
        
        return dateTextNode
    }

    func scheduleBarCell (
        courseTitle: String,
        courseLocation: String,
        courseRoom: String,
        courseTime: String
    ) -> ASLayoutSpec {
        let scheduleBarCellCourseTitle = ASTextNode()
        let scheduleBarCellCourseTitleAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 18)!
        ]
        scheduleBarCellCourseTitle.attributedText = NSAttributedString(
            string: courseTitle,
            attributes: scheduleBarCellCourseTitleAttribute
        )
        
        let scheduleBarCellCourseLocation = ASTextNode()
        let scheduleBarCellCourseLocationAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 12)!
        ]
        scheduleBarCellCourseLocation.attributedText = NSAttributedString(
            string: courseLocation,
            attributes: scheduleBarCellCourseLocationAttribute
        )
        
        let scheduleBarCellCourseRoom = ASTextNode()
        let scheduleBarCellCourseRoomAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 12)!
        ]
        scheduleBarCellCourseRoom.attributedText = NSAttributedString(
            string: courseRoom,
            attributes: scheduleBarCellCourseRoomAttribute
        )
        
        let scheduleBarCellContent = ASStackLayoutSpec()
        scheduleBarCellContent.style.maxWidth = ASDimensionMakeWithPoints(Screen.width)
        scheduleBarCellContent.direction = .vertical
        scheduleBarCellContent.alignItems = .start
        scheduleBarCellContent.style.maxWidth = ASDimensionMakeWithPoints(Screen.width)
        
        let scheduleBarCellContentBottomStackView = ASStackLayoutSpec()
        scheduleBarCellContentBottomStackView.direction = .horizontal
        scheduleBarCellContentBottomStackView.spacing = 10
        
        scheduleBarCellContentBottomStackView.children = [
            scheduleBarCellCourseLocation,
            scheduleBarCellCourseRoom
        ]
        
        scheduleBarCellContent.children = [
            scheduleBarCellCourseTitle,
            scheduleBarCellContentBottomStackView
        ]
        
        let scheduleBarCellWrapper = ASStackLayoutSpec()
        scheduleBarCellWrapper.direction = .horizontal
        scheduleBarCellWrapper.alignItems = .center
        scheduleBarCellWrapper.spacing = 10
        
        scheduleBarCellWrapper.children = [
            scheduleBarDate(courseTime),
            scheduleBarCellContent,
        ]
        
        return scheduleBarCellWrapper
    }

    func scheduleBarContent () -> ASLayoutSpec {
        let schedulesStackNode = ASStackLayoutSpec()
        schedulesStackNode.direction = .vertical
        schedulesStackNode.spacing = 6
        
        let schedules = self.scheduleRepository.getSchedules()
        let schedulesBarCells = schedules.map { schedule -> ASLayoutSpec in
            return self.scheduleBarCell(
                courseTitle: schedule.COURSE_TITLE_LONG,
                courseLocation: schedule.LOCATION,
                courseRoom: schedule.ROOM,
                courseTime: schedule.MEETING_TIME_START
            )
        }
        
        schedulesStackNode.children = schedulesBarCells
        
        return schedulesStackNode
    }

    func scheduleBar () -> ASLayoutSpec {
        let schedulesStackNode = scheduleBarContent()
        
        schedulesStackNode.children = [
            scheduleBarHeader(),
            scheduleBarContent()
        ]
        
        let scheduleBarInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let scheduleBarWrapper = ASInsetLayoutSpec(insets: scheduleBarInset, child: schedulesStackNode)
        
        return scheduleBarWrapper
    }
}

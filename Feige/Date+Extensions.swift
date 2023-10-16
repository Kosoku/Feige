//
//  Date+Extensions.swift
//  Feige
//
//  Created by William Towe on 10/16/23.
//  Copyright © 2023 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Foundation

public extension Date {
    // MARK: - Public Properties
    /**
     Returns the second component.
     */
    var second: Int {
        Calendar.current.component(.second, from: self)
    }
    
    /**
     Returns the minute component.
     */
    var minute: Int {
        Calendar.current.component(.minute, from: self)
    }
    
    /**
     Returns the hour component.
     */
    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    
    /**
     Returns the day component.
     */
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    /**
     Returns the month component.
     */
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    /**
     Returns the year component.
     */
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    // MARK: -
    /**
     Returns a date representing the start of the day.
     */
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /**
     Returns a date representing the end of the day.
     */
    var endOfDay: Date? {
        Calendar.current.date(byAdding: DateComponents().also {
            $0.day = 1
            $0.second = -1
        }, to: self.startOfDay)
    }
    
    /**
     Returns a date representing the start of the week.
     */
    var startOfWeek: Date? {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date
    }
    
    /**
     Returns a date representing the end of the week.
     */
    var endOfWeek: Date? {
        guard let to = self.startOfWeek else {
            return nil
        }
        return Calendar.current.date(byAdding: DateComponents().also {
            $0.weekOfYear = 1
            $0.second = -1
        }, to: to)
    }
    
    /**
     Returns a date representing the start of the month.
     */
    var startOfMonth: Date? {
        Calendar.current.dateComponents([.calendar, .year, .month], from: self).date
    }
    
    /**
     Returns a date representing the end of the month.
     */
    var endOfMonth: Date? {
        guard let to = self.startOfMonth else {
            return nil
        }
        return Calendar.current.date(byAdding: DateComponents().also {
            $0.month = 1
            $0.day = -1
        }, to: to)
    }
    
    /**
     Returns a date representing the start of the month.
     */
    var startOfYear: Date? {
        guard let to = self.startOfMonth else {
            return nil
        }
        return Calendar.current.dateComponents([.calendar, .year], from: to).date
    }
    
    /**
     Returns a date representing the end of the month.
     */
    var endOfYear: Date? {
        guard let to = self.startOfYear else {
            return nil
        }
        return Calendar.current.date(byAdding: DateComponents().also {
            $0.year = 1
            $0.day = -1
        }, to: to)
    }
}

//
//  Timer.swift
//  Feige
//
//  Created by William Towe on 10/15/23.
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

/**
 Block based timer that uses *Grand Central Dispatch* internally.
 */
public final class BlockTimer: ScopeFunctions {
    // MARK: - Public Types
    /**
     Typealias for block that is invoked whenever the timer fires.
     */
    public typealias Block = (BlockTimer) -> Void
    
    // MARK: - Public Properties
    /**
     Get/set the default repeats value.
     */
    public static var defaultRepeats: Bool = false
    /**
     Get/set the default target queue where the timer will fire.
     */
    public static var defaultTargetQueue: DispatchQueue = .main
    
    // MARK: - Private Properties
    private let timeInterval: TimeInterval
    private let repeats: Bool
    private let targetQueue: DispatchQueue
    private let block: Block
    
    // MARK: -
    private lazy var queue: DispatchQueue = { [unowned self] in
        DispatchQueue(label: "\(String.bundleIdentifier).\(self)", target: self.targetQueue)
    }()
    private lazy var timer: DispatchSourceTimer = { [unowned self] in
        DispatchSource.makeTimerSource(queue: self.queue)
    }()
    private lazy var scheduleOnce: () -> Void = { [unowned self] in
        let time = DispatchTimeInterval.milliseconds(Int(self.timeInterval * 1000.0))
        
        self.timer.setEventHandler { [weak self] in
            guard let self else {
                return
            }
            self.block(self)
        }
        self.timer.schedule(deadline: .now() + time, repeating: self.repeats ? time : .never)
        self.timer.resume()
        return {}
    }()
    
    // MARK: - Public Functions
    /**
     Returns a timer after calling `BlockTimer.schedule()` on it.
     
     - Parameter timeInterval: The time interval at which the timer should fire
     - Parameter repeats: Whether the timer should repeat
     - Parameter targetQueue: The queue on which the timer should fire
     - Parameter block: The block to invoke when the timer fires
     - Returns: The scheduled timer
     */
    public static func scheduled(timeInterval: TimeInterval, repeats: Bool = BlockTimer.defaultRepeats, targetQueue: DispatchQueue = BlockTimer.defaultTargetQueue, block: @escaping Block) -> BlockTimer {
        BlockTimer(timeInterval: timeInterval, repeats: repeats, targetQueue: targetQueue, block: block)
            .also {
                $0.schedule()
            }
    }
    
    // MARK: -
    /**
     Schedules the timer to begin firing.
     
     - Warning: Calling this more than once does nothing
     */
    public func schedule() {
        self.scheduleOnce()
    }
    
    /**
     Invalidates a previously scheduled timer.
     
     - Warning: Calling this more than once does nothing
     */
    public func invalidate() {
        guard self.timer.isCancelled.not() else {
            return
        }
        self.timer.cancel()
    }
    
    /**
     Invokes the block that was provided during initialization asynchronously on provided target queue.
     
     - Warning: Calling this on a timer that has been invalidated does nothing
     */
    public func fire() {
        guard self.timer.isCancelled.not() else {
            return
        }
        self.targetQueue.async {
            self.block(self)
        }
    }
    
    // MARK: - Initializers
    /**
     Creates an instance with the provided parameters.
     
     - Parameter timeInterval: The time interval at which the timer should fire
     - Parameter repeats: Whether the timer should repeat
     - Parameter targetQueue: The queue on which the timer should fire
     - Parameter block: The block to invoke when the timer fires
     - Returns: The instance
     */
    public init(timeInterval: TimeInterval, repeats: Bool = BlockTimer.defaultRepeats, targetQueue: DispatchQueue = BlockTimer.defaultTargetQueue, block: @escaping Block) {
        self.timeInterval = timeInterval
        self.repeats = repeats
        self.targetQueue = targetQueue
        self.block = block
    }
    
    deinit {
        self.invalidate()
    }
}

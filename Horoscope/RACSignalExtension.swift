//
//  RACSignalExtension.swift
//  Horoscope
//
//  Created by Jovanny Espinal on 5/26/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import ReactiveCocoa

extension RACSignal {
    func subscribeNextAs<T>(nextClosure:(T) -> ()) -> () {
        self.subscribeNext {
            (next: AnyObject!) -> () in
            let nextAsT = next as! T
            nextClosure(nextAsT)
        }
    }
    
    func filterAs<T>(nextClosure:(T!) -> Bool) -> (RACSignal) {
        return self.filter {
            (next: AnyObject!) -> Bool in
            if(next == nil){
                return nextClosure(nil)
            }else{
                let nextAsT = next as! T
                return nextClosure(nextAsT)
            }
        }
    }
    
    func mapAs<T>(nextClosure:(T!) -> AnyObject!) -> (RACSignal) {
        return self.map {
            (next: AnyObject!) -> AnyObject! in
            if(next == nil){
                return nextClosure(nil)
            }else{
                let nextAsT = next as! T
                return nextClosure(nextAsT)
            }
        }
    }
}
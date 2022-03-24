//
//  Todo Classes.swift
//  ataglance
//
//  Created by Luis Alvarado on 3/8/22.
//

import Foundation
import UIKit

//Things To add on todo list class
//1. Array to keep all the tasks to do in todo list.
//2. A way to mark as task completed.
//3. A way to delete a task.
//4. A way to display the tasks in the array.
//5. A way to replace existing task to something else.
//6. A way to display how many tasks the user has in the todo list.
//7. Maintain a way to keep the tasks when app is closed.

//Checkpoint 3: Add the swift UIKIT and organize the way I want my UI storyboard to look like

class Todolist {
    
    //moved to view controller
    //creates an empty array of the todo list
    var todos:[String] = []
    
    // moved to view controller
    //adds users todo's onto the array
    func todoadd(todo:String) {
        todos.append(todo)
    }
    
    //Prints the users todos array list
    func TodoListPrint() {
        todos.forEach { todo in
            print("Todo: \(todo)")
        }
    }
    
    //@Breif: function removes from the index that is pressed. If the array is empty then the function will return "Your Todo List is empty today. 😃"
    func removeindex(index:Int) {
        if todos.isEmpty {
            print("Your Todo List is empty today. 😃")
        } else {
            todos.remove(at:index)
        }
    }
    
    //moved to viewcontroller
    //@Breif: Function replaces the old task in todo list to a newTask
    func changeNameOfTask(index: Int, newTask: String) {
        for tasks in 0..<todos.count {
            if tasks == index {
                todos[tasks] = newTask
            }
        }
    }
    
    //moved to viewcontroller
    //@Breif: Counts the amount of things in the list.
    func countTodoTasks() {
        var count = 0
        for _ in 0..<todos.count {
            count+=1
        }
        print("You have \(count) tasks today.")
    }

}

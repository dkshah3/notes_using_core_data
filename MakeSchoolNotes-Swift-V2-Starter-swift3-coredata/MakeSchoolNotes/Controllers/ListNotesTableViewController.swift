//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
 
    //core data will hold a default context that holds the notes even when the app is closed. By stating retriveNotes in the beginning with viewDidLoad, as it will load the notes when the app is first opened.
    override func viewDidLoad() {
        super.viewDidLoad()
            //notes = CoreDataHelper.retrieveNotes()
    }
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
         self.notes = CoreDataHelper.retrieveNotes()
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    
    // 1 set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // 2 how each row will look
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1 instead of creating a HUGE  table (lots of memory), it will create templates, and as you scroll, new info will be inserted into each template to give the illusion that there are sooo many rows. this is why its a reusable dequeu cell. the identifier tells us the name of the template to use.
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        // 1
        let row = indexPath.row
        
        // 2
        let note = notes[row]
        
        // 3
        cell.noteTitleLabel.text = note.title
        
        // 4
        cell.noteModificationTimeLabel.text = note.modificationTime?.convertToString()
        
        return cell
    }

    //this will deal with what happens when you press a note, and how it leads to a new screen. Any time you need a new screen (that uses a hierarchical structure) use segues and navigation controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1 this says that the identifier is for segue
        if let identifier = segue.identifier {
            // 2 if the segue is for "displayNote" screen, then print
            if identifier == "displayNote" {
                print("Table view cell tapped")
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destination as! DisplayNoteViewController
                // 4
                displayNoteViewController.note = note
            }
            else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    // 1
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //1
        CoreDataHelper.delete(note: notes[indexPath.row])
        //2
        notes = CoreDataHelper.retrieveNotes()
        }
    }
    
    
    


    
    

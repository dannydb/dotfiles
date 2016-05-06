tell application "Reminders"
	repeat with thisReminder in (get reminders in list "Reminders" whose name is "Don't forget your laptop!")
		set reminderDate to current date
		log day of reminderDate
		if day of reminderDate is 6 then
			set day of reminderDate to ((reminderDate's day) + 3)
		else if day of reminderDate is 7 then
			set day of reminderDate to ((reminderDate's day) + 2)
		else
			set day of reminderDate to ((reminderDate's day) + 1)
		end if
		set time of reminderDate to (8 * hours)
		
		set due date of thisReminder to reminderDate
		set completed of thisReminder to false
	end repeat
end tell

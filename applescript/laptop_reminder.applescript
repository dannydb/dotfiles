tell application "Reminders"
	repeat with thisReminder in (get reminders in list "Reminders" whose completed is false)
		set nameObj to name of thisReminder
		if (nameObj is equal to "Don't forget your laptop!") then
			return
		end if
	end repeat
	
	set reminderDate to current date
	set day of reminderDate to ((reminderDate's day) + 1)
	set time of reminderDate to (8 * hours) + (45 * minutes)
	tell list "Reminders"
		make new reminder at end with properties {name:"Don't forget your laptop!", remind me date:reminderDate}
	end tell
end tell

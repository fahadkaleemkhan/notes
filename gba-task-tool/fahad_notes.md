incorporate the following notes into the specs, and rewrite this folder such that i can give it a fresh claude session to execute (meaning remove any records of the back-and-forth between you and me and between me and atheeq.)  

## notes on mvp features
- we will deploy on digital ocean since i have it.  
- we will 
## rough layout

### lead view 
a simple view of ticket-stubs

	planned
		{ticket 1 title} | [assign] | started 12.04.26 due 12.04.26
		{ticket 2 title} | {assignee} | started 12.04.26 due 12.04.26
	in-flight
		{ticket 1 title} | {assignee} | started 12.04.26 due 12.04.26
		{ticket 2 title} | {assignee} | started 12.04.26 due 12.04.26
	review
		 {}
	

clicking on any ticket-stub should pull out the ticket in a pleasing way. 
### ticket fan-out view

	{ticket n title} | [assign] | started 12.04.26 due 12.04.26      
		{space for to write text of particulars; click to edit}
		Contact
			[Call \/] {}

Notes
- the text `due 12.04.26` should be red when past-due
- [Call \/] is a drop-down with options Call / email /  
- want it to be visually beautiful and simple. it should look like an executive's desk, and each ticket stub and ticket fan-out should look like a real document or stub in some way (but the styling should not too heavy-hand. 
- considering renaming terminology from task -> ticket. 
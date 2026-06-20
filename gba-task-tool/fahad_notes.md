incorporate the following notes into the specs, and rewrite this folder such that i can give it a fresh claude session to execute (meaning remove any records of the back-and-forth between you and me and between me and atheeq.)  

## notes on mvp features
- we will deploy on digital ocean since i have it.  
- we will 
## rough layout
#### key: 
	`[text]` is a button. 
	[       text     ] is a fill-to-zoom-on-mobile button that looks a normal [text] button on desktop.
	`\/` is dropdown. 
	 `[_____]` is fill-in field
	 `[_____\/]` is exposed dropdown. 
	 `{sdsd}` is a chip with dynamic text.
	 [...\/] is collapse/expand button.     
### lead view 
a simple view of ticket-stubs

Desktop view

	 Tickets						 Organise by [status\/] [Add ticket]
	planned
		{ticket 1 title} | [assign] | due 12.04.26  
		{ticket 2 title} | {assignee1} | due 12.04.26 [...\/]
	in-action
		{ticket 1 title} | {assignee} | started 12.04.26 due 12.04.26
			{subticket1 title} | {assignee} | started 12.04.26 due 12.04.26
	needs review
		{ticket 2 title} | {assignee} | started 12.04.26 due 12.04.26
									Organise by [status\/] [Add ticket]

Mobile view

	planned
		{ticket 1 title} | [assign]  
		{ticket 2 title} | {assignee1}  
	in-action
		{ticket 1 title} | {assignee1}{assignee2} 
			{subticket 1 title} | {assignee1}{assignee2} 
	needs review
		 {ticket 1 title} 
	
	[Organise by status\/]             [Add ticket] 

#### Notes
-  Organise-by options: 
	- status | planned/in-action/needs review 
	- date 
		- when the list is small, just sort and have an ascending / descending
		- when list is large and spanned over a large
	- assignee

clicking on any ticket-stub should pull out the ticket in a pleasing way. 
### ticket fan-out view

	{ticket n title}              [re-assign]{assignee 1} 
	.     started 12.04.26 due 27.04.26      
		{space for to write text of particulars; double-tap to edit}
		Persons to Contact
			1. Contact [_____\/] to [______] 
			     [📎Phone][📎email]
			2. Contact [Mahendra from BBMP\/] to [____] 
				 [📞938821232][📧mahendra@bbmp.com][📎Phone][📎email]
		Updates
			17.04.26 Completed field-visit to Belgaum [...\/]
			14.04.26 Surveyed land near [...\/]
			 [       Add update                ]
		 Comments
			 Needs approval from BDA [...\/]
			**Resolved** MoU has been signed [...\/]
			 [     Add comment     ]
		  

Notes
- the text `due 12.04.26` should be red when past-due
- in `to [____]` text field, before clicking there should be some placeholder text options that keep cycling, like 'to schedule a meeting in office', 'to discuss a potential partnership', or 'to obtain the details from' 
- [📞938821232] should fan out to multiple options like 'call', 'save to contact', etc.
	- i am a little unsure if it should show the number or if it should display the name with an emoji next to it. 
- assignee text should just be first-name.
- All lists (ticket-stubs, updates, comments, etc.) should be limited a certain number of viewable entries after which point there should be a ... more option (think of the best ui element to make that work.)
- Contacts will get fed from phone (seek permission the first time the user 
- want it to be visually beautiful and simple. it should look like an executive's desk, and each ticket stub and ticket fan-out should look like a real document or stub in some way (but the styling should not too heavy-hand. 
- considering renaming terminology from task -> ticket. 
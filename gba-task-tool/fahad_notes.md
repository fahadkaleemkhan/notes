incorporate the following notes into the specs, and rewrite this folder such that i can give it a fresh claude session to execute (meaning remove any records of the back-and-forth between you and me and between me and atheeq.)  

## notes on mvp features
- we will deploy on digital ocean since i have it.  
- we will 
## rough layout
#### key: 
	`[text]` is a button. 
	`\/` is dropdown. 
	 `[_____]` is fill-in field
	 `[_____\/]` is exposed dropdown. 
	 `{}` is dynamic text.
### lead view 
a simple view of ticket-stubs

Desktop view

	planned
		{ticket 1 title} | [assign] | started 12.04.26 due 12.04.26
		{ticket 2 title} | {assignee1} | started 12.04.26 due 12.04.26
	in-flight
		{ticket 1 title} | {assignee} | started 12.04.26 due 12.04.26
		{ticket 2 title} | {assignee} | started 12.04.26 due 12.04.26
	needs review
		 {}

Mobile view

	planned
		{ticket 1 title} | [assign] 
		{ticket 2 title} | {assignee1} 
	in-flight
		{ticket 1 title} | {assignee1}{assignee2} 
		{ticket 2 title} | {assignee1}{assignee2} 
	needs review
		 {}


clicking on any ticket-stub should pull out the ticket in a pleasing way. 
### ticket fan-out view

	{ticket n title} | [assign] | started 12.04.26 due 12.04.26      
		{space for to write text of particulars; click to edit}
		Persons to Contact
			1. Contact [_____\/] to [______] 
			     [📎Phone][📎email]
			2. Contact [Mahendra from BBMP\/] to [____] 
				 [📞938821232][📧mahendra@bbmp.com][📎Phone][📎email]

Notes
- the text `due 12.04.26` should be red when past-due
- in `to [____]` text field, before clicking there should be some placehold text options that keep cycling, like 'to schedule a meeting in office', 'to discuss a potential partnership', or 'to obtain the budget details of yadgir scheme' 
- [📞938821232] should fan out to multiple options like 'call', 'save to contact', etc.
	- i am a little unsure if this is best approach. li
- assignee text should just be first-name.
- Contacts will get fed from phone (seek permission the first time the user 
- want it to be visually beautiful and simple. it should look like an executive's desk, and each ticket stub and ticket fan-out should look like a real document or stub in some way (but the styling should not too heavy-hand. 
- considering renaming terminology from task -> ticket. 
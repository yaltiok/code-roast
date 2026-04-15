# Example: Linus Torvalds roasts incomprehensible regex

## Input code

```python
import re

def validate_input(data):
    email_pattern = r'^(?=.{1,256})(?=.{1,64}@.{1,255}$)(?:[a-zA-Z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&\'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$'
    
    if re.match(email_pattern, data.get('email', '')):
        phone_pattern = r'^(\+?\d{1,3}[-.\s]?)?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}$'
        if re.match(phone_pattern, data.get('phone', '')):
            return True
    return False
```

## Roast output (medium)

````
    ┌────────────────┐
    │   ◉  ╭╮  ◉    │
    │     ────       │
    │   │ sigh. │    │
    │   └───────┘    │
    └────────────────┘
  *takes off glasses,
   rubs eyes for 30 seconds*
````

I stared at this for a full minute. Not because I was trying to understand it — I gave up on that after ten seconds. I was trying to figure out what series of life choices led you here.

1. **You have written a regex that no human can read, no human can debug, and no human should have to maintain.** That `email_pattern` is 450 characters of line noise. I have seen kernel oops messages that were more intelligible. If you showed this to the person who invented regular expressions, they would deny involvement. You have taken a tool designed for pattern matching and turned it into a weapon of mass confusion.

2. **You copied the RFC 5322 email regex and pasted it into production code.** I know you did, because no sane person would type `[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]` by hand. That regex technically validates emails according to the full RFC specification, which means it accepts email addresses that no mail server on Earth will actually deliver to. You are validating against a theoretical standard that includes quoted strings with escaped control characters. When was the last time someone signed up for your service with an email containing a backslash-escaped bell character? Never. The answer is never.

3. **This is a single line.** You have a 450-character regex on ONE LINE. No `re.VERBOSE`. No comments. No named groups. No breaking it into comprehensible parts. Six months from now, when this regex rejects a valid email or accepts an invalid one — and it will, because regex-based email validation always does — whoever has to debug this will need to parse 450 characters of dense metacharacter soup to find the problem. That person might be you. I hope it is.

4. **The function is called `validate_input` but it validates exactly two fields.** What happens when you need to validate a third field? A fourth? Are you going to nest another `if re.match` inside? You're already two levels deep with no error reporting. The caller gets back `True` or `False` with no indication of WHICH validation failed or WHY. "Your input is invalid" — thanks, which part?

5. **Use a library.** I'm not usually the person who says "just use a library" for everything, but email validation is a solved problem. It has been solved by people who have spent years understanding the edge cases that your copy-pasted regex handles incorrectly. Python has `email-validator`. It gives you clear error messages, handles internationalized domains, and — most importantly — it's readable. Your regex is not readable. Your regex is a cry for help.

The phone regex is at least short enough that a human could theoretically modify it, so I'll give you partial credit for that. But partial credit on a two-question exam still means you failed.

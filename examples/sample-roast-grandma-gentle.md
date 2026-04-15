# Example: Gentle Grandma roasts a student's first Python script

## Input code

```python
# my first program :)
name = input("whats ur name? ")
age = input("how old r u? ")
if age > 18:
    print("ur old lol")
if age > 30:
    print("ok boomer")
if age > 50:
    print("ur ancient")
if age < 18:
    print("ur a baby")
print("bye " + name + "!!!")
```

## Roast output (gentle)

````
    ┌──────────────┐
    │   ◉   ◉     │
    │    ╰▽╯       │
    │   ╭┈┈┈┈╮    │
    │   ┆ 🍵 ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *puts the kettle on*
````

Oh, sweetheart! Your first program! Look at you! I remember my first program — it was on a punch card the size of a placemat and it printed "HELLO" and I cried. You're doing MUCH better than I did. Come, sit, I made tea.

Now, honey, I have to tell you something, and I need you to not be upset because this is how we learn. You have a tiny little bug, and it's a very SNEAKY bug, and honestly it tricks a lot of people, so don't feel bad.

**The sneaky bug:** When you write `age = input("how old r u? ")`, Python gives you back a STRING, not a number. So when someone types "25", `age` isn't the number `25` — it's the text `"25"`. And when you compare `"25" > 18`, Python isn't comparing numbers, it's comparing a string to a number and in Python 3 this will actually CRASH with a TypeError! Oh dear.

The fix is easy, dear: `age = int(input("how old r u? "))`. Just wrap it in `int()`. Like wrapping a present, except the present is... a number. You know what I mean.

**One more little thing:** If someone types "twenty" instead of a number, `int()` will get confused and crash too. That's okay for now! But someday when you learn about `try` and `except`, you can catch that. No rush. Rome wasn't built in a day, and neither was Python.

**And the if statements!** This is actually very clever, what you've done. If someone is 55, they'll get "ur old lol" AND "ok boomer" AND "ur ancient" — all three messages! Because each `if` runs separately. You might want `elif` instead, which means "otherwise if" — so it picks just ONE message. Unless you WANT to roast people three times, in which case... sweetie, you have a future in this.

**The "bye" message** at the end — `"bye " + name + "!!!"` — works perfectly! But someday look up f-strings: `f"bye {name}!!!"`. It's the modern way. I learned it from your cousin Kevin. Don't tell him I said that.

I'm so proud of you. This program WORKS (almost). You're asking for input, making decisions, printing output — that's REAL programming! My grandchild is a programmer! Let me take a photo of the screen to show the neighbors.

Now drink your tea before it gets cold.

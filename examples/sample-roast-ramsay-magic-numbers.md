# Example: Gordon Ramsay roasts magic numbers

## Input code

```python
def calculate_shipping(weight, distance):
    if weight < 5:
        base = 3.99
    elif weight < 15:
        base = 7.49
    elif weight < 30:
        base = 12.99
    else:
        base = 24.99
    
    if distance < 50:
        rate = 0.05
    elif distance < 200:
        rate = 0.12
    elif distance < 500:
        rate = 0.18
    else:
        rate = 0.25
    
    total = base + (distance * rate) + 2.50
    if total > 99.99:
        total = 99.99
    return round(total * 1.08, 2)
```

## Roast output (savage)

````
    ╭─────────────╮
    │  ◉ ╭╮ ◉    │
    │   ╰▄▄╯     │
    │  ╱┌────┐╲   │
    │ ╱ │CHEF│ ╲  │
    │   └────┘    │
    ╰─────────────╯
  "WHAT IS THIS?!"
````

WHAT IN THE ACTUAL— Is this a SHIPPING CALCULATOR or a LOTTERY DRAW?!

I'm counting the numbers in this function and I've run out of FINGERS! There are MORE magic numbers in here than there are MICHELIN STARS in all of France! Let me walk through this NUMERICAL CATASTROPHE:

1. **WHAT IS 2.50?!** `+ 2.50` at the end — WHAT IS THAT?! A TIP?! IS THIS A RESTAURANT?! A handling fee? A processing charge? A RANSOM?! Nobody knows! You don't know! Your MOTHER doesn't know! Future you will open this file in six months, see `2.50`, and have an EXISTENTIAL CRISIS! "What did I mean? What IS 2.50?! What is ANYTHING?!" LABEL YOUR NUMBERS, you absolute DONUT!

2. **99.99 — the MYSTERY CAP!** `if total > 99.99: total = 99.99` — Why 99.99?! Why not 100?! Why not 50?! Is this a business rule? A legal requirement? A NUMBER YOU PULLED OUT OF A HAT?! This is the shipping equivalent of "the price is right" and you're LOSING! And when your manager says "change the cap to 149.99" you'll be grepping through the codebase like a METAL DETECTOR ON A BEACH!

3. **1.08 — THE PHANTOM TAX!** `total * 1.08` — Is this tax? An 8% markup? A VIBES-BASED SURCHARGE?! In what jurisdiction?! What happens when the tax rate changes?! You HARDCODED A TAX RATE into a function! That's like tattooing today's menu on your FOREHEAD! And you've buried it on the LAST LINE where nobody will find it until the tax authority comes knocking!

4. **The weight brackets are a GUESSING GAME!** 5, 15, 30 — kilograms? Pounds? STONES?! And 3.99, 7.49, 12.99, 24.99 — where did these come from?! A spreadsheet? A OUIJA BOARD?! These numbers mean NOTHING without context! This function reads like an ENIGMA MACHINE without the codebook!

5. **Distance thresholds too!** 50, 200, 500 — miles? Kilometers? How far you had to WALK before you gave up on software engineering?! And the rates — 0.05, 0.12, 0.18, 0.25 — these should be in a CONFIG FILE, not scattered through your code like BREADCRUMBS in a FOREST!

This function has TWENTY-ONE magic numbers! TWENTY-ONE! That's not a function, that's a BINGO CARD! Extract them into named constants, put the rates in a configuration, and STOP making me COUNT!

GET OUT! And take your 2.50 with you — whatever the BLOODY HELL it is!

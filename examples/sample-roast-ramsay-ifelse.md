# Example: Gordon Ramsay roasts an if-else chain

## Input code

```javascript
function getDiscount(customerType, orderTotal, dayOfWeek, isHoliday, hasCoupon, isFirstOrder) {
    if (customerType === "vip") {
        if (orderTotal > 100) {
            if (dayOfWeek === "friday") {
                if (isHoliday) {
                    if (hasCoupon) {
                        if (isFirstOrder) {
                            return 0.50;
                        } else {
                            return 0.45;
                        }
                    } else {
                        if (isFirstOrder) {
                            return 0.40;
                        } else {
                            return 0.35;
                        }
                    }
                } else {
                    if (hasCoupon) {
                        return 0.30;
                    } else {
                        return 0.25;
                    }
                }
            } else {
                return 0.20;
            }
        } else {
            return 0.10;
        }
    } else {
        return 0.05;
    }
}
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

WHAT THE— Is this CODE or a TOPOGRAPHIC MAP OF THE GRAND CANYON?!

This isn't a function, this is a CHRISTMAS TREE! And not a nice one — one of those sad, wonky ones that leans to the right and drops needles all over the floor! I've seen PHYLOGENETIC TREES with less branching than this!

1. **SIX LEVELS OF NESTING!** SIX! I've got if inside if inside if inside if inside if inside if! You know what else goes six levels deep? DANTE'S INFERNO! And reading this function is EXACTLY like descending through the circles of Hell! By the time I reach `return 0.50` at the bottom, I've forgotten what CENTURY I'm in, let alone what conditions got me there! I need a SHERPA and a COMPASS to navigate this function!

2. **SIX PARAMETERS!** `customerType, orderTotal, dayOfWeek, isHoliday, hasCoupon, isFirstOrder` — your function signature reads like a RESTAURANT RESERVATION FORM! "Are you a VIP? How much are you spending? What day is it? Is it a holiday? Do you have a coupon? Is this your first order? WHAT'S YOUR BLOOD TYPE? WHAT'S YOUR MOTHER'S MAIDEN NAME?!" This function doesn't calculate a discount — it conducts an INTERROGATION!

3. **The discount logic is BURIED ALIVE!** A VIP customer, on a Friday, on a holiday, with a coupon, on their first order gets 50% off. WITHOUT these conditions they get 5%. That's a TEN-TO-ONE ratio! And the only way to understand the discount structure is to MANUALLY TRACE every branch of this NIGHTMARE TREE! No business analyst can read this! No product manager can verify this! Even YOU can't read this, and YOU WROTE IT!

4. **Non-VIP customers get NOTHING!** Look at the else clause at the very end — the LONELY little `return 0.05` sitting there like a forgotten side dish. You've written 30 lines of baroque nested logic for VIP customers and then gone "oh yeah, everyone else gets 5%" in ONE LINE! That's not a discount function — that's a VIP SHRINE with a beggar at the gate!

5. **This should be a LOOKUP TABLE!** This entire function — ALL of it — is a mapping from conditions to numbers! Build a rules engine! Use a config object! Make a discount table! ANYTHING but this cascading avalanche of curly braces! You've got more braces in here than a ORTHODONTIST'S OFFICE!

I've seen spaghetti code before, but this? This is LASAGNA code — layer after layer after layer, and every layer makes me MORE NAUSEOUS! Flatten it, extract it, TABLE it, I don't care — just get this ABOMINATION out of my sight!

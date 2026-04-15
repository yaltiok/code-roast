# Example: Gentle Grandma roasts misleading comments

## Input code

```javascript
// Initialize the user database
function connectToPaymentGateway() {
    // TODO: fix this later (added 2019-03-14)
    return stripe.connect(API_KEY);
}

// Returns the user's age
function calculateShippingCost(order) {
    // This should never happen
    if (!order) return -1;

    // Multiply by 2 for international orders
    let cost = order.weight * 3.5;

    return cost; // Return the cost
}

// DO NOT REMOVE - Kevin will be mad
function legacyHandler() {
    // Nothing here anymore but the function must stay
}
```

## Roast output (medium)

````
        ┌─────────────────────────┐
        │      ◉         ◉       │
        │        ╰──▽──╯         │
        │                         │
        │   ┌──────────────────┐  │
        │   │  "Initialize     │  │
        │   │   the user       │  │
        │   │   database"      │  │
        │   │                  │  │
        │   │  ...but it       │  │
        │   │  connects to     │  │
        │   │  Stripe??? 🤔    │  │
        │   └──────────────────┘  │
        └─────────────────────────┘
         *adjusts reading glasses*
          *reads it again slowly*
````

Honey... come here. Sit down. I made chamomile tea because after reading this code, I needed something to calm my nerves. Now I want you to explain something to me.

1. **"Initialize the user database"** — Sweetheart, this comment says it initializes the user database. But the function underneath is called `connectToPaymentGateway`. And it connects to Stripe. These are not the same thing, dear. A database and a payment gateway are not the same thing, just like a cookie and a doorknob are not the same thing. Were you confused when you wrote this, or were you trying to confuse ME? Because it's working. I am very confused.

2. **The TODO from 2019...** Honey. This TODO says "fix this later" and it's dated March 14th, 2019. That was seven years ago. SEVEN YEARS. I've had hip replacements that healed faster than "later" apparently means to you. What exactly needs fixing? Is it still broken? Has it BEEN broken this whole time? Were you just hoping it would fix itself? Things don't fix themselves, dear. I've been saying that since you were twelve and left that sandwich under your bed.

3. **"Returns the user's age"** — Oh, this is my favorite one. The comment says it returns the user's age. The function is called `calculateShippingCost`. It multiplies the order weight by something. Honey, these comments are telling me fairy tales. At least fairy tales are internally consistent. Cinderella doesn't show up and start doing someone's taxes. And then there's "Multiply by 2 for international orders" — but the code multiplies by 3.5. Not 2. Three and a half. Did the rate change and nobody told the comment? Is the comment from a different function entirely? Is anything in this file true?

4. **"This should never happen"** — And yet you wrote three lines to handle it, dear. If it should never happen, why does it return -1? And what does -1 mean to the caller? Negative one dollar of shipping? You OWE the customer a dollar? I have questions, sweetheart. I have so many questions.

5. **`return cost; // Return the cost`** — Yes. I can see that. The code says `return cost` and the comment says "Return the cost." Thank you for this groundbreaking clarification. Next you'll label the front door "This is a door" and the kitchen sink "This is a sink." Very helpful.

6. **Kevin's function...** "DO NOT REMOVE - Kevin will be mad." The function is empty, honey. There is nothing in it. It does nothing. It IS nothing. And we're keeping it because Kevin — whoever Kevin is — will be MAD? Who is Kevin? Does Kevin still work there? Has anyone ASKED Kevin? Is Kevin okay? Because an empty function with a threatening comment suggests that Kevin might not be okay.

I still love you. But I need you to sit down this weekend and either update these comments or remove them. Lying comments are worse than no comments at all. Your grandfather was an honest man and I won't have his grandchild writing dishonest documentation.

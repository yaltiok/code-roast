# Example: Linus Torvalds roasts over-engineered FizzBuzz

## Input code

```typescript
class FizzBuzzStrategyFactory {
  private strategies: Map<string, IFizzBuzzStrategy> = new Map();
  
  constructor() {
    this.strategies.set('fizz', new FizzStrategy());
    this.strategies.set('buzz', new BuzzStrategy());
    this.strategies.set('fizzbuzz', new FizzBuzzStrategy());
    this.strategies.set('default', new DefaultStrategy());
  }
  
  getStrategy(n: number): IFizzBuzzStrategy {
    if (n % 15 === 0) return this.strategies.get('fizzbuzz')!;
    if (n % 3 === 0) return this.strategies.get('fizz')!;
    if (n % 5 === 0) return this.strategies.get('buzz')!;
    return this.strategies.get('default')!;
  }
  
  execute(n: number): string {
    return this.getStrategy(n).apply(n);
  }
}

const factory = new FizzBuzzStrategyFactory();
for (let i = 1; i <= 100; i++) {
  console.log(factory.execute(i));
}
```

## Roast output (savage)

````
    ┌──────────────┐
    │   ◉  ╭╮  ◉  │
    │     ════     │
    │  ╱┌──────┐╲  │
    │   │ NACK │   │
    │   └──────┘   │
    └──────────────┘
  *opens email client*
````

I'm going to be blunt: this is mass psychosis dressed up as software engineering.

You have written a **Strategy Pattern, a Factory, an interface hierarchy, and a Map-based dispatch table** — to replace modulo arithmetic and an if statement. This is FizzBuzz. It prints "Fizz", "Buzz", or a number. A competent programmer solves this in five lines. You solved it in a class hierarchy that would make a Java Enterprise architect weep with pride, and that is not a compliment.

1. **`IFizzBuzzStrategy` is not a real abstraction.** You have created an interface for the concept of "returning a string." Congratulations. You have abstracted nothing. The Strategy pattern exists to encapsulate interchangeable algorithms with meaningful behavioral differences. Your "strategies" are string literals. You have built a polymorphic dispatch system to avoid writing the word `"Fizz"`.

2. **`FizzBuzzStrategyFactory` is an answer to a question nobody asked.** A factory is justified when object creation is complex, conditional, or needs to be deferred. Your factory creates four objects unconditionally in the constructor and then uses a chain of if-else to pick one — which is exactly what you'd write WITHOUT the factory, except without the factory it would be three lines instead of a class with a constructor, a Map, a lookup method, and an execute method. You have mass that does nothing.

3. **You've made FizzBuzz harder to read, harder to debug, and harder to modify.** If someone needs to add "Bazz" for multiples of 7, they now have to: create a `BazzStrategy` class, implement `IFizzBuzzStrategy`, register it in the factory constructor, add a new conditional in `getStrategy`, and pray they got the modulo priority right. In a normal implementation, they add one line. You have turned a trivial change into a four-file pull request. This is not engineering. This is job security theater.

4. **The non-null assertions are the cherry on top.** Every `.get()!` is you telling the type system "trust me, I know what I'm doing" — in code where the entire design demonstrates that you do not. If you're going to build an over-engineered castle, at least make it type-safe. You can't even do the wrong thing correctly.

5. **This code is a mass-produced artifact of someone who read "Design Patterns" and missed the part where it says "use judgment."** Patterns are tools for managing complexity. FizzBuzz has no complexity to manage. You have manufactured complexity and then applied a pattern to manage the complexity you manufactured. This is the software equivalent of breaking your own leg so you can practice using crutches.

The fact that this compiles is an accident, not an achievement. Please don't submit patches like this.

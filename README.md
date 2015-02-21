# Guardsafe

[![Build Status](https://travis-ci.org/DevL/guardsafe.svg?branch=master)](https://travis-ci.org/DevL/guardsafe)
[![Inline docs](http://inch-ci.org/github/DevL/guardsafe.svg?branch=master)](http://inch-ci.org/github/DevL/guardsafe)
[![Hex.pm](https://img.shields.io/hexpm/v/guardsafe.svg)](https://hex.pm/packages/guardsafe)

Macros expanding into code that can be safely used in guard clauses.

## Usage

Update your `mix.exs` file and run `mix deps.get`.
```elixir
defp deps do
  [{:guardsafe, "~> 0.1.0"}]
end
```

Import all the macros...
```elixir
defmodule MyModule do
  import Guardsafe
```

...or just the ones you need.
```elixir
defmodule MyOtherModule do
  import Guardsafe, only: [divisible_by?: 2]
```

Now go forth and make your guard clauses more readable!
```elixir
def leap_year?(year) when divisible_by?(year, 400), do: true
def leap_year?(year) when divisible_by?(year, 100), do: false
def leap_year?(year), do: divisible_by?(year, 4)
```

Documentation for each macro is of course available in `iex`.
```
iex(1)> h Guardsafe.divisible_by?

                    defmacro divisible_by?(number, divisor)

Expands divisible_by?(number, divisor) into rem(number, divisor) == 0
```
